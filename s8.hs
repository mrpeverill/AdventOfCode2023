import Data.Map (Map)
import qualified Data.Map as Map

lineParse :: String -> (String, (String, String))
lineParse a = (key, (lval, rval))
  where key = take 3 a
        lval = take 3 $ drop 7 a
        rval = take 3 $ drop 12 a

travel :: String -> String -> Map String (String, String)-> Int
travel "ZZZ" _ _ = 0
travel loc (d:ds) m = 1 + travel next ds m
  where mapTuple = m Map.! loc
        next
          | d == 'R' = snd mapTuple
          | d == 'L' = fst mapTuple
          | otherwise = error "Bad Direction"

main :: IO ()
main = do
  dirLine <- getLine
  let dirs = cycle dirLine
  contents <- getContents
  let cmap = Map.fromList . map lineParse $ drop 1 $ lines contents
  let pathCount = travel "AAA" dirs cmap
  print "Part 1:"
  print pathCount
