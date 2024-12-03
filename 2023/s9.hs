import Debug.Trace

parseLine :: String -> [Int]
parseLine x = map read $ words x

compareSeq :: [Int] -> [Int]
compareSeq (x:[]) = []
compareSeq (x:y:xs) = (y - x):compareSeq (y:xs)

deltaList :: [Int] -> [[Int]]
deltaList x
  | all (==0) x = []
  | otherwise = newdiff : deltaList newdiff
  where newdiff = compareSeq x

extrapolate :: [Int] -> Int
extrapolate x = foldr1 (+) endpoints
  where endpoints = map last $ x:(deltaList x)

rextrapolate :: [Int] -> Int
rextrapolate x = foldr1 (-) heads
  where heads = map head $ x:(deltaList x)

main :: IO ()
main = do
  let testdata = [[0,3,6,9,12,15],[1,3,6,10,15,21],[10,13,16,21,30,45]]
  print "Test Data:"
  print testdata
  print $ map deltaList testdata
  let tprojections = map extrapolate testdata
  print tprojections
  print $ sum tprojections

  contents <- getContents
  let slist = map parseLine $ lines contents
  let projections = map extrapolate slist
  print projections
  print $ sum projections

  let trprojections = map rextrapolate testdata
  print trprojections
  print $ sum trprojections

  let rprojections = map rextrapolate slist
  print rprojections
  print $ sum rprojections
