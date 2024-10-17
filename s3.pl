#!/usr/bin/perl
use warnings;
use strict;

# The algorithm:
# 1. Put the whole file into an array
# 2. Search each line for numbers
# 3. Search the indices around the number for symbols
# 4. Each time we find a match, add the number to a running total.
#

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

print "The total is $total \n"
