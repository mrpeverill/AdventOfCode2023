#!/usr/bin/perl
use warnings;
use strict;

# The algorithm:
# 1. Put the whole file into an array
# 2. Search each line for numbers
# 3. Search the indices around the number for symbols
# 4. Each time we find a match, add the number to a running total.
#
# I'm heavily renaming all the little special variables that perl gives you.
# For sure the code would be much more compact if I did not do this, but it's
# not worth the loss of readability. The actual algorithm is about as compact
# as I could make it. Initially I put the whole string in one variable and
# subtracted 140 from the index to look at the previous line. Not worth it.

# Open the file
my $file = 'input.s3.txt';
open my $fh, $file or die "Could not open $file: $!";

# Store it in an array
my @input = ();
while( my $line = <$fh>) {
    push @input, $line;
}
my $lastindex = $. - 1; # How many lines?
close $fh;

# We'll put the solution here
my $total = 0;

while (my ($lineIndex, $line) = each @input) {
    # The regex looks for numbers. If we iterated over symbols, we'd get duplicates.
    while ($line =~ /([0-9]+)/g) {
        my $num = $1;
        my $start = $-[0] - 1;
        my $end = $+[0] + 1;
        # Handle numbers at the beginning / end of a line
        $start = 0 if $start < 0; #no min / max function...
        $end = 140 if $end >140;

        my $length = $end - $start;

        # Make a string for all adjacent characters
        my $context = substr($line,$start,$length);
        $context .= substr($input[$lineIndex - 1],$start,$length) if $lineIndex > 0; # if after the call. It's awful and I love it.
        $context .= substr($input[$lineIndex + 1],$start,$length) if $lineIndex < $lastindex;

        #debug output
        #my $teststring = "";
        #$teststring = "✓" if $context =~ /[^\.0-9]/;
        #print "$context $teststring \n";

        $total += $num if $context =~ /[^\.0-9]/;
    }
}

print "Part 1: The total of numbers adjacent to a symbol is $total \n";

my $productSum = 0;
## Part 2: gear ratios.
while (my ($lineIndex, $line) = each @input) {
    # The regex looks for the asterisk only
    while ($line =~ /\*/g) {
        # I think there are only 2 and 3 digit numbers. So we should be able to define a search space of 3 before and 3 after the asterisk
        my $start = $-[0] - 3;
        my $end = $+[0] + 3;
        # Handle being close to the line start/end
        $start = 0 if $start < 0; #no min / max function...
        $end = 140 if $end >140;

        my $length = $end - $start;
        my @nums = ();

        # Make an array for the context lines. We need to look at the lines seperately,
        # because we have to filter out 2 char numbers at the start and end (because they
        # won't be adjacent). Any other number will be adjacent.

        my @context = ();
        push @context, substr($input[$lineIndex - 1],$start,$length) if $lineIndex > 0;
        push @context, substr($line,$start,$length);
        push @context, substr($input[$lineIndex + 1],$start,$length) if $lineIndex < $lastindex;

        # The regex matches:
        # A 3 digit number anywhere,
        #   OR a two digit number that is not at the start or end (i.e. preceded by the beginning or followed by the end)
        #   OR a one digit number that is not at the start or end or separated from them by one non-whitespace character.
        # UGH -- it only works because There are no asterisk within 3 characters of the line end or beginning.

        foreach (@context) {
            print "$_ \n";
            while ($_ =~ /[0-9]{3}|(?<!^)[0-9]{2}(?!$)|(?<!^)(?<!^\S)[0-9](?!$)(?!\S$)/g ) {
                push @nums, $&;
            }
        }
        foreach(@nums) {print "$_ "}
        if (scalar @nums == 2) {
            my $product = $nums[0] * $nums[1];
            print "✓ $product";
            $productSum += $product;
        }
        print "\n\n"

    }
}

print "The total gear ratio is $productSum"
