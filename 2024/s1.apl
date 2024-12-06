data←↓⍉↑{⍎⍵}¨⊃⎕NGET '/Users/mpeverill/Documents/AdventOfCodeSolutions/2024/input.day10.txt' 1
testdata←(3 4 2 1 3 3 ) (4 3 5 3 9 3)
+/⊃|-/{⍵[⍋⍵]}¨data ⍝ Solution to Part 1
(⊃data) +.× +/⊃∘.⍷/data ⍝ Solution to Part 2
