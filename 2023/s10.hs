import Debug.Trace

queryMap :: String -> (Int, Int) -> Char
--queryMap m (x,y) = trace ("Found " ++ show ((maplines!!y)!!x) ++ " at " ++ show (x,y)) ((maplines!!y)!!x)
queryMap m (x,y) = (maplines!!y)!!x -- maybe just calculate the index first?
  where maplines = lines m

getStart :: String -> (Int, Int) -> (Int,Int)
getStart (i:is) (x,y)
  | i == 'S' = (x,y)
  | i == '\n' = getStart is (0,y+1)
  | otherwise = getStart is (x+1,y)

beginLoop :: String -> (Int, Int) -> Int
beginLoop m (x,y)
  | elem (queryMap m (x,y-1)) ['|','7','F'] = northTo m (x,y-1)
  | elem (queryMap m (x+1,y)) ['-','J','7'] = eastTo m (x+1,y)
  | elem (queryMap m (x,y+1)) ['|','L','J'] = southTo m (x,y+1)
  | otherwise = error "no 1st step found"

--north/east/south/west from would have been more parsimonious
northTo :: String -> (Int, Int) -> Int
northTo m (x,y)
  | dir == 'S' = 0
  | dir == '|' = 1 + northTo m (x,y-1)
  | dir == 'F' = 1 + eastTo m (x+1,y)
  | dir == '7' = 1 + westTo m (x-1,y)
  where dir = queryMap m (x,y)

eastTo :: String -> (Int, Int) -> Int
eastTo m (x,y)
  | dir == 'S' = 0
  | dir == 'J' = 1 + northTo m (x,y-1)
  | dir == '-' = 1 + eastTo m (x+1,y)
  | dir == '7' = 1 + southTo m (x,y+1)
  where dir = queryMap m (x,y)

southTo :: String -> (Int, Int) -> Int
southTo m (x,y)
  | dir == 'S' = 0
  | dir == 'J' = 1 + westTo m (x-1,y)
  | dir == 'L' = 1 + eastTo m (x+1,y)
  | dir == '|' = 1 + southTo m (x,y+1)
  where dir = queryMap m (x,y)

westTo :: String -> (Int, Int) -> Int
westTo m (x,y)
  | dir == 'S' = 0
  | dir == 'L' = 1 + northTo m (x,y-1)
  | dir == '-' = 1 + westTo m (x-1,y)
  | dir == 'F' = 1 + southTo m (x,y+1)
  where dir = queryMap m (x,y)


main :: IO ()
main = do
 contents <- getContents
 let m = contents
 let scoord = getStart contents (0,0)
 let loopLength = beginLoop m scoord
 print "Steps until we get back to S:"
 print loopLength
 print $ ceiling (fromIntegral loopLength / 2)
