#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
#use File::Slurp;

# The algorithm:
# 1. Put the whole file into an array
# 2. Search each line for numbers
# 3. Search the indices around the number for symbols
# 4. Each time we find a match, add the number to a running total.
#

my $file = 'input.s3.txt';
open my $fh, $file or die "Could not open $file: $!";

my @input = ();
while( my $line = <$fh>) {
    push @input, $line;
}
my $lastindex = $. - 1;
close $fh;

my $total = 0;

#The capture group gets the number.
while (my ($lineIndex, $line) = each @input) {
    while ($line =~ /([0-9]+)/g) {
        my $num = $1;
        my $start = $-[0] - 1;
        my $end = $+[0] + 1;
        $start = 0 if $start < 0; #no min / max function...
        $end = 140 if $end >140;
        my $length = $end - $start;
        my $context = substr($line,$start,$length);
        $context .= substr($input[$lineIndex - 1],$start,$length) if $lineIndex > 0; # if after the call. It's awful and I love it.
        $context .= substr($input[$lineIndex + 1],$start,$length) if $lineIndex < $lastindex;

        #debug output
        my $teststring = "";
        $teststring = "✓" if $context =~ /[^\.0-9]/;
        print "$context $teststring \n";

        $total += $num if $context =~ /[^\.0-9]/;
    }
}

print "The total is $total \n"
