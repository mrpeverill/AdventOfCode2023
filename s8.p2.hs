import Data.Map (Map)
import qualified Data.Map as Map
import Debug.Trace (trace)

lineParse :: String -> (String, (String, String))
lineParse a = (key, (lval, rval))
  where key = take 3 a
        lval = take 3 $ drop 7 a
        rval = take 3 $ drop 12 a

-- Use with fold / scan. The accumulator returns the next location and is applied to the list of directions.
onetravel :: Map String (String, String) -> String -> Char -> String
onetravel m start d
  | d == 'R' = snd mapTuple
  | d == 'L' = fst mapTuple
  | otherwise = error "Bad Direction"
  where mapTuple = m Map.! start

getPathFromStart :: Map String (String, String) -> String ->  String -> [String]
getPathFromStart cmap start dirs = scanl accum start dirs
  where accum = \acc char -> onetravel cmap acc char

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
