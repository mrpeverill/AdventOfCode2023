data←⍎¨⊃⎕NGET '/Users/mpeverill/Documents/AdventOfCodeSolutions/2024/input.day2.txt' 1
diffs←2 -/ ¨ data
+/{^/⍵}¨{(1≤|⍵ ^ 3≥|⍵) , (|+/⍵) = +/|⍵}¨diffs  ⍝ Part 1

dropiter←{((⊃⍴⍵),(¯1+⊃⍴⍵)) ⍴(,⍵)[⍸~,idm ⊃⍴⍵]} ⍝ drop the diagonal from a matrix and reshape
matricize←{⍵ ∘.×⍨ ⍵ * 0 } ⍝ repeat a vector until you get a square matrix
+/∨/¨^/¨{(1≤|⍵ ^ 3≥|⍵) , (|+/⍵) = +/|⍵}¨{2 -/ dropiter matricize ⍵}¨data ⍝ Part 2
