⎕IO ← 0
filepath←'/Users/mpeverill/Documents/AdventOfCodeSolutions/2024/sample.day4.txt'
data←↑⊃⎕NGET filepath 1

⍝ Part 1:
getdiags←{↑{0 0⍉⍵}¨{1↓((⍳⊃⍴⍵)⊖¨(⊃⍴⍵)/⊂(2×⍴⍵)↑⍵),(⊂(2×⍴⍵)⍴' '),(⍳⊃⍴⍵)⌽¨(⊃⍴⍵)/⊂(2×⍴⍵)↑⍵}⍵}
mirror←{{⍵,⌽⍵}{⍵⍪⍉⍵}⍵↑⍨⍴⍵}
box←{¯1⌽¯1⊖⍵↑⍨2/2+⌈/⍴⍵}


+/'XMAS'{(+/⍺⍷{⍵,⌽⍵}(box getdiags ⍵)  , box getdiags ⍉⌽⍵),+/⍺⍷mirror box ⍵}data

⍝ Part 2:
cells←,({⊂⍵}⌺3 3)data
needle←'MSMS' 'MMSS' 'SMSM' 'SSMM'
needle∊⍨{(,⍵)[0 2 6 8]}¨{⍵[⍸'A'={1 1 ⌷⍵}¨ ⍵]}cells
