data←⎕NGET '/Users/mpeverill/Documents/AdventOfCodeSolutions/2024/input.day3.txt' 1
regexstring←'mul\(([0-9]{1,3},[0-9]{1,3})\)'
+/ , 2 × /↑⍎¨regexstring ⎕S'\1' ⊢ ⊃,/data ⍝ Part 1

regexgrouping←'(?:do\(\)|^).*?(?:don''t\(\)|$)'
+/ , 2 × /↑⍎¨regexstring ⎕S'\1' ⊃,/regexgrouping ⎕S '&'⊃,/data ⍝ Part 2
