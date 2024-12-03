-- part 1
distance :: Int -> Int -> Int
distance charge time = (time-charge)*charge

vSet :: (Int,Int) -> [Int]
vSet (time, record) = [x | x <- [1..(time-1)], distance x time > record]

-- If our formula for distance is accurate, what we really want is the values where distance is equal to the record -- all the integers between are the solution. So:
-- -1*c^2 + T*c - R = 0
-- By the quadratic formula:
-- c = (1 +/- sqrt(T^2 - 4* (-1 * -R))/2*-1

quadraticRoots :: (Floating a) => a -> a-> a-> (a, a)
quadraticRoots a b c = (j, k)
  where
    j = ((-1) * b + sqrt(b^2 - 4*a*c))/(2*a)
    k = ((-1) * b - sqrt(b^2 - 4*a*c))/(2*a)

chargeLimits :: (Floating a) => (a,a) -> (a,a)
chargeLimits (t, r) = quadraticRoots (-1) t ((-1)*r)

main :: IO ()
main = do
  let races = [(61,430),(67,1036),(75,1307),(71,1150)]
  let ways = map (length . vSet) races
  let solution = foldl1 (*) ways
  print "Part 1:"
  print solution
  print "Part 2:"
  let race = (61677571,430103613071150)
  --Solution 1 -- slow and brutish. you can reverse the set and take the head of it to search from the beginning and end lazily, but it doesn't help much.
  --let ways' = length . vSet $ race
  --print ways'
  --print "Part 2 (alternate):"
  --let ways'' = (head $ vSet' race) - (head $ vSet race) + 1
  --print ways''
  --Solution 2
  --This is the 'right' way to do it. Probably we could've done it mostly on pen and paper in less time, since it's a very mathy problem.
  let limits = chargeLimits race
  let range = (\(a, b) -> floor b - ceiling a) limits
  print limits
  print range
