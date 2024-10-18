# Advent of Code 2023 Solutions

I thought this would be a fun way to poke into a few different programming languages I've been curious about.

## Common Lisp -- days 1 and 2
I really failed to find the koolaid with this one. I suspect that these problems are too simple for lisp's complexity to really shine, but I don't really grok why people like the language yet. I possibly cheated myself out of the full lisp experience by using the cl-ppcre library, but it was so obviously what the problems needed that I couldn't help myself. Possibly if I was wanting a pure lisp experience I should have been playing with Scheme or racket. 

## Perl -- day 3
I haven't written any perl since the 90s! At some point while researching lisp someone reminded me of it. I probably should be using it more instead of bash. Also, it has cool derivatives.

I didn't enjoy perl very much. The syntax feels messy. I can use $. to keep track of the index in a while loop, but not in a foreach loop. substr is a function, but print is... something else that doesn't use parentheses? Basically, the syntax feels inconsistent between contexts. Also, it's odd that there is no max / min function in a language that's this interpreted. length works for strings but you have to use 'scalar' for array?

So far I am dissapointed that the 'meat' of each of these puzzles is regex, regardless of language used.

I had to go past superficial understanding of lookahead to solve part 2, so that's fun. It might be cool to try to do this in Raku also.

## Day 4

Part 1: This is pretty easy in a language with robust list/vector handling. I initially dismissed R because I thought it would be too easy, but I was curious how long it would take me to do it (about 30 minutes -- mostly because the file input was tricky).

Part 2: Oh boy, this one is NOT a particularly good pick for a vectorized language. It could be done though.



## Future programming languages to try:

So far the problems are very string processing heavy, which really rewards use of a certain sort of language, but it may be fun to try some other stuff:

* Forth
* Julia
* K
* Raku

This is a great page: https://madhadron.com/programming/seven_ur_languages.html
