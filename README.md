# Advent of Code 2023 Solutions

I thought this would be a fun way to poke into a few different programming languages I've been curious about.

## Common Lisp -- days 1 and 2
I really failed to find the koolaid with this one. I suspect that these problems are too simple for lisp's complexity to really shine, but I don't really grok why people like the language yet. I possibly cheated myself out of the full lisp experience by using the cl-ppcre library, but it was so obviously what the problems needed that I couldn't help myself. Possibly if I was wanting a pure lisp experience I should have been playing with Scheme or racket. 

## Perl -- day 3
I haven't written any perl since the 90s! At some point while researching lisp someone reminded me of it. I probably should be using it more instead of bash. Also, it has cool derivatives.

I didn't enjoy perl very much. The syntax feels messy. I can use $. to keep track of the index in a while loop, but not in a foreach loop. substr is a function, but print is... something else that doesn't use parentheses? Basically, the syntax feels inconsistent between contexts. Also, it's odd that there is no max / min function in a language that's this interpreted.

So far I am dissapointed that the 'meat' of each of these puzzles is regex, regardless of language used.

Solution for day 3 part 1 is done. I'm heavily renaming all the little special variables that perl gives you. For sure the code would be much more compact if I did not do this, but it's not worth the loss of readability. The actual algorithm is about as compact as I could make it. Initially I put the whole string in one variable and subtracted 140 from the index to look at the previous line. Not worth it.

## Future programming languages to try:

So far the problems are very string processing heavy, which really rewards use of a certain sort of language, but it may be fun to try some other stuff:

* Forth
* Julia
* K

This is a great page: https://madhadron.com/programming/seven_ur_languages.html
