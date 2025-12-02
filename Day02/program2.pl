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

    # print "  Checking value $value of length $length\n";
    for (my $i = 2 ; $i <= $length ; $i++)
    {
        next if ($length % $i != 0);

        my $part_length = $length / $i;
        my @parts = $value =~ /(.{$part_length})/g;
        # print "    Parts: " . join(", ", @parts) . "\n";

        my $invalid = 1;
        foreach my $part (@parts)
        {
            if ($part ne $parts[0])
            {
                $invalid = 0;
                last;
            }
        }

        return 1 if ($invalid);
    }

    return 0;
}
