#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $line = <$fd>;

close($fd);

my @ranges = split(/,/, $line);
my $invalid_sum = 0;

foreach my $range (@ranges)
{
    my ($start, $end) = split(/-/, $range);

    # print "Checking range $start to $end\n";

    for (my $i = $start; $i <= $end; $i++)
    {
        if (is_invalid($i))
        {
            # print "  ID $i is invalid\n";
            $invalid_sum += $i;
        }
    }
}

print "Sum of invalid IDs: $invalid_sum\n";

sub is_invalid
{
    my $value = shift;
    my $length = length($value);

    return 0 if ($length % 2 == 1);

    my $beginning = substr($value, 0, $length / 2);
    my $end = substr($value, $length / 2, $length / 2);

    return 1 if ($beginning eq $end);

    return 0;
}
