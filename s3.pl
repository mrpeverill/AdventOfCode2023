#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
#use File::Slurp;

# The algorithm:
# 1. Put the whole file in one two dimensional array
# 2. Search each line for numbers
# 3. Search the indices around the number for symbols
# 4. Search the substring for symbols, and don't add the number to the list if we don't find one.
# 5. Sum the list
#


#We are using one string variable for the file. We could also have done line iteration to build a two dimensional array.
open my $fh, '<', 'input.s3.txt' or die "Can't open file $!";
my $searchText = do { local $/; <$fh> };

my $total = 0;
#The capture group gets the number. We match 1 or more non-whitespace around it to handle newlines
while ($searchText =~ /\S?([0-9]+)\S?/g) {
    #print "found $1 from ", $-[1] , " to ", $+[1], "\n";
    my $num = $1;
    my $length = $+[0] - $-[0];


    my $contentSearch = $&;
    if( $-[0]>140 ) {
        $contentSearch .= substr($searchText,$-[0]-140,$length);
    }
    if( $-[0]+140 < length($searchText)) {
        $contentSearch .= substr($searchText,$-[0]+140,$length);
    }

    print $contentSearch, "\n";

}
