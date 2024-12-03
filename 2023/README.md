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

Part 2: Oh boy, this one is NOT a particularly good pick for a vectorized language. I ended up using a for loop, which is not good R style but worked well.

## Day 5

Haskell is on my list, and for some reason this problem conforms to my naive idea of what Haskell would be good at (I suppose this is primarily because it works with infinite data ranges and because lazy execution might limit the amount of work we have to do to get the solution.)

...

Haskell did work! This (Part 2 esp.) was the first problem where performance was a bit of an issue. Technically, we can just expand the seed list for part 2 and brute force it, but Haskell is not lazy enough to do that in a performative way. Instead, I used a recursive function to process the ranges.

I'm sort of impressed about how Haskell really constrains you to write elegantly:

For the mapRange example, I started with a function that processed the whole range in one go, returning a variable number of ranges. But then I had a problem where I needed to see if the remainder matched to any maps. I would have had to return some sort of state report from that function. Then I thought, ok I'll use recursion to test the 'remainder' against the remaining maps. I thought, probably I could do this with recursion before and after, but that seems too complicated. But then I realized I  would need to use some sort of flow control to see if there was anything remaining in the prefix. Haskell doesn't facilitate that, so using the before and after recursion turned out to be the best solution. Then I didn't even need to sort the input list, because what I had left was insensitive to the ordering of the maps. Super cool.

I had never programmed in Haskell before. It took 3.5 hours just to get the input processed and honestly I wish I had done that in another way. 2 hours for part 1, 3.75 for part 2.

## Day 6:
The brute force solution worked fine and felt like a cinch. I did it in haskell. The data was copy-pasted into the code. I re-approached with more elegance later.

## Day 7:
Well, we definitely COULD do this in Haskell. We would probably make a function to compare two hands, and then order the bid list by the associated hands. However, it would be much easier to do in a language with data tables, because then we can easily save the rank information in columns and then order by that. In Haskell, it might be most stylistic to use recursion with a comparison function and that function would need to run every time a hand was compared to another. Alternately, we could use a scoring model (make a tuple with (score, bid), then sort).

Maybe we'll do both and benchmark -- fun!

The haskell solution worked fine. We ended up making a scoring function, and then a compare function to compare them. I hardcoded something for J,J,J,J,J on day 2 -- ugly!

I also made a Julia program. I had an algorithm for how to do it thought up in R, and saw Julia as a similar option. I like having list comprehensions available, but overall Julia is the wrong tool for a job of this size -- compilation takes ~30 seconds. However -- it is, indeed, more concise than the haskell solution.

## Day 8:
We're on a role with haskell -- kind of want to see if I can do this with recursion. I debated whether to use the Data.Map package. You could get around it with indexing, but why not learn to use something new?

Wow part 1's solution feels great and really elegant. I think we can do part 2 easily enough also -- just need to work with lists of locations and some test functions.

## Day 9:
This one was a roller coaster. I did it in Haskell (on a roll). Part 1 was easy. I had a beautiful solution for part 2, but it turned out to be too brutish to work (and it was hard to figure that out). The real solution involved a LOT more math than expected.

## Day 10:
Easy peasy. Haskell made the day 1 to day 2 pivot simple.

## Future programming languages to try:

So far the problems are very string processing heavy, which really rewards use of a certain sort of language, but it may be fun to try some other stuff:

* Forth
* Julia
* K
* Raku

This is a great page: https://madhadron.com/programming/seven_ur_languages.html
