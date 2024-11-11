-- run with, e.g. cat s5sample.txt | runhaskell s5.hs
import Data.List.Split
import Data.Char (isDigit)
import Data.List (sortOn)

-- The mapping between seed and location is deterministic. It would be cool and haskell like to cons a defined array of the locations, filtered by whether it matches a seed, but it's going to be more efficient to map over the list of seeds and take a minimum.
-- this involves iterating over a series of table lookups

-- Part 1 Solution
-- Lookup one number in a map (list of ranges)
mapFromMapList :: Int -> [(Int, Int, Int)] -> Int
mapFromMapList x y
  | mList == [] = x
  | otherwise   = mapLookup x $ head mList
  where mList = filter (\(_, b, c) -> b <= x && x-b < c) (sortOn snd' y)
        mapLookup :: Int -> (Int, Int, Int) -> Int
        mapLookup x (a, b, _) =  (x-b) + a
        snd' (_, a, _) = a

-- Solve for one seed number
locationFromSeed :: Int -> [[(Int, Int, Int)]] -> Int
locationFromSeed _ [] = error "no maps provided"
locationFromSeed x [y] = mapFromMapList x y
locationFromSeed x (y:ys) = locationFromSeed (mapFromMapList x y) ys

-- Part 2 Solution
-- Parse the seed range list.
expandSeeds :: [Int] -> [(Int, Int)]
expandSeeds a = map (\[x,y] -> (x,x+y)) $ chunksOf 2 a

-- Get a range or set of ranges from one range tuple and a map (i.e., list of map ranges).
mapRange :: (Int, Int) -> [(Int, Int, Int)] -> [(Int,Int)]
mapRange (x, y) []
  | y<x = []
  | otherwise = [(x,y)]
mapRange (x, y) ((i,j,k):ms)
  | rangeIntersect (x,y) (j,j+k-1) = prefix ++ [(i+maximum([0,x-j]),i+minimum([k-1,y-j]))] ++ affix -- if any intersection
  | otherwise = mapRange (x, y) ms
  where affix = mapRange (j+k,y) ms
        prefix = mapRange(x,j-1) ms
        rangeIntersect :: (Int, Int) -> (Int, Int) -> Bool
        rangeIntersect (x, y) (j,k) = x <= k && j <= y

-- Get a new set of ranges by intersecting a list of ranges with one map (list of tuples)
mapRanges :: [(Int, Int)] -> [(Int, Int, Int)] -> [(Int, Int)]
mapRanges a b = concat $ map (\x -> mapRange x b) a

-- functions to read the data file.
parseIntList :: String -> [Int]
parseIntList = map read . words

parseMaps :: String -> [[(Int, Int, Int)]]
parseMaps a = map (map (readTuple . words)) out
  where out = (map lines $ subLists)
        subLists = split (dropDelims . dropBlanks $ onSublist "\n\n") $ drop 1 (unlines mapLines)
        mapLines = filter validLine $ lines a

        validLine :: [Char] -> Bool
        validLine "" = True
        validLine xs = isDigit $ head xs
        
        readTuple :: [String] -> (Int, Int, Int)
        readTuple [x, y, z] = (read x, read y, read z)
        readTuple _ = error "Invalid list provided to readTuple"

main :: IO ()
main = do
  seedsLine <- getLine
  let seeds = parseIntList $ drop 7 seedsLine
  contents <- getContents
  let ourMaps = parseMaps contents
  let locations = map (\x -> locationFromSeed x ourMaps) seeds
  let minLocation = foldr1 min locations
  print "Part 1:"
  print locations
  print minLocation

  print "Part 2:"
  let seedRanges = expandSeeds seeds
  let locationRanges = foldl mapRanges seedRanges ourMaps
  let minrange = head $ sortOn fst locationRanges
  print minrange
