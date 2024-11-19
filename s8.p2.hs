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

main :: IO ()
main = do
  dirLine <- getLine
  let dirs = cycle dirLine
  contents <- getContents
  let cmap = Map.fromList . map lineParse $ drop 1 $ lines contents
  print [x | x<-Map.keys cmap, last x == 'A']
  let pathCount = travel' [x | x<-Map.keys cmap, last x == 'A'] dirs cmap 0
  print pathCount
