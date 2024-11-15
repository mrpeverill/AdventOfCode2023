import Data.Map (Map)
import qualified Data.Map as Map
import Debug.Trace (trace)

lineParse :: String -> (String, (String, String))
lineParse a = (key, (lval, rval))
  where key = take 3 a
        lval = take 3 $ drop 7 a
        rval = take 3 $ drop 12 a

--ltest :: Char -> [String] -> Bool
--ltest x y = foldl1 (&&) $ map (==x) y

travel :: [String] -> String -> Map String (String, String)-> Int
travel locs (d:ds) m
  | all (=='Z') (map last locs) = 0
  | otherwise = 1 + travel next ds m
  where mapTuples = map (m Map.!) locs
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
  let pathCount = travel [x | x<-Map.keys cmap, last x == 'A'] dirs cmap
  print pathCount
