import Data.Map (Map)
import qualified Data.Map as Map
import Debug.Trace (trace)

-- For reading the input
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

--this one implements the scan for the above.
getPathFromStart :: Map String (String, String) -> String ->  String -> [String]
getPathFromStart cmap start dirs = scanl accum start dirs
  where accum = \acc char -> onetravel cmap acc char

-- --https://en.wikipedia.org/wiki/Pollard%27s_rho_algorithm
-- prho :: Int -> [(Int, Int)]
-- prho n =
--   where g x = (x^2+1) % n

-- -- turns out this is a built in -- but I'm using mine!
-- gcd' :: Int -> Int -> Int
-- gcd' x y
--   | x == y = x
--   | otherwise = gcd' b (a - b)
--   where a = max x y
--         b = min x y

--this is a trial division algorithm. Not efficient but probably good enough.

isPrime :: (Integral a) => a -> Bool
isPrime k | k <=1 = False | otherwise = not $ elem 0 (map (mod k)[2..k-1])

pfactorize :: Int -> [Int]
pfactorize n = pfactor n rprimes
  where rprimes=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157]  -- we only need primes up to the root of the largest period

pfactor :: Int -> [Int] -> [Int]
pfactor n [] = []
pfactor n (p:ps)
  | isPrime (fromIntegral n) = [n]
  | n `mod` p == 0 = p:(pfactor n' (p:ps))
  | otherwise = pfactor n ps
  where n' = quot n p

group :: [Int] -> [(Int, Int)]
group [] = []
group (x:xs) = ((1+match),x):(group nomatch)
  where match = length $ filter (==x) xs
        nomatch = filter (/=x) xs

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
  let factors = map pfactorize periods
  print "Prime factorizations:"
  print factors
  print "To get the solution, take the product of each prime factor to the maximum power present in each factorization"
  --let factorcounts = foldl1 (++) $ map group factors
  --print factorcounts
  --let lcm = foldl1 (*) products
  --print lcm
