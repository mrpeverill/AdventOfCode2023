import Data.Map (Map)
import qualified Data.Map as Map
import Debug.Trace (trace)

lineParse :: String -> (String, (String, String))
lineParse a = (key, (lval, rval))
  where key = take 3 a
        lval = take 3 $ drop 7 a
        rval = take 3 $ drop 12 a

--basic recursion. This stack overflows with the real data. The code is fine, but the problem needs something more sophisticated than this brute force solution.
--Also there is a problem with lazy evaluation https://wiki.haskell.org/Foldr_Foldl_Foldl%27

travel :: [String] -> String -> Map String (String, String)-> Int
travel locs (d:ds) m
  | all (=='Z') (map last locs) = 0
  | otherwise = 1 + travel next ds m
  where mapTuples = map (m Map.!) locs
        next
          | d == 'R' = map snd mapTuples
          | d == 'L' = map fst mapTuples
          | otherwise = error "Bad Direction"

-- still memory leaks like crazy.
travel' :: [String] -> String -> Map String (String, String)-> Int -> Int
travel' locs (d:ds) m n
  | all (=='Z') (map last locs) = n'
  | otherwise = seq n' travel' next ds m n'
  where n' = n + 1
        mapTuples = map (m Map.!) locs
        next
          | d == 'R' = map snd mapTuples
          | d == 'L' = map fst mapTuples
          | otherwise = error "Bad Direction"

-- This version should get a sequence / cycle from one start point.
-- No this gives steps to the first ending point
onetravel :: String -> String -> Map String (String, String)-> Int -> Int
onetravel loc (d:ds) m n
  | last loc == 'Z' = n'
  | otherwise = seq n' onetravel next ds m n'
  where n' = n + 1
        mapTuple = m Map.! loc
        next
          | d == 'R' = snd mapTuple
          | d == 'L' = fst mapTuple
          | otherwise = error "Bad Direction"

-- this one will get called by sequence across the directions. I.e. it takes a starting place, then a list of directions, and both returns the next step and also provides that to the next fold.
onetravel' :: Map String (String, String) -> String -> Char -> String
onetravel' m start d
  | d == 'R' = snd mapTuple
  | d == 'L' = fst mapTuple
  | otherwise = error "Bad Direction"
  where mapTuple = m Map.! start

getPathFromStart :: Map String (String, String) -> String ->  String -> [String]
getPathFromStart cmap start dirs = scanl accum start dirs
  where accum = \acc char -> onetravel' cmap acc char

--https://en.wikipedia.org/wiki/Pollard%27s_rho_algorithm
prho :: Int -> [(Int, Int)]
prho n =
  where g x = (x^2+1) % n


main :: IO ()
main = do
  dirLine <- getLine
  let dirs = cycle dirLine
  contents <- getContents
  let cmap = Map.fromList . map lineParse $ drop 1 $ lines contents
  let startpoints = [x | x<-Map.keys cmap, last x == 'A']
  -- "AAA" seems not to repeat, but "ZZZ" does, regularly.
  -- The first start point defines a simple arithmetic progression.
  -- So does the second and third
  -- let seqone = getPathFromStart cmap "NQA" dirs
  -- let seqone' =  [i | (i, x) <- zip [0..] seqone, (last x) == 'Z']
  -- print startpoints
  -- print $ take 20 seqone'

  -- Let's proceed assuming they are all simple arithmetic sequences:
  let paths = map (\start -> getPathFromStart cmap start dirs) startpoints
  -- credit to https://stackoverflow.com/a/49647242/8371482
  let endpoints = map (\list -> [i | (i, x) <- zip [0..] list, (last x) == 'Z']) paths
  let periods = map head endpoints
  print periods
