#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $count = 0;
my $fresh_ranges = [];

while (my $line = <$fd>)
{
    chomp($line);

    last if ($line eq '');

    my ($start, $end) = split('-', $line);
    push @$fresh_ranges, { start => $start, end => $end };
}

close($fd);

my $id = 0;

while (1)
{
    my $start = get_next_fresh_id($id, $fresh_ranges);

    last if (not defined $start);

    my $end = get_last_fresh_id($start, $fresh_ranges);

    die "End of range not found." if (not defined $end);

    $count += ($end - $start + 1);
    $id = $end + 1;

    # print "Found fresh range: $start - $end\n";
    # print "Current ID: $id\n";
}

print "Count: $count\n";

sub get_next_fresh_id
{
    my $current_id = shift;
    my $fresh_ranges = shift;

    my $min_range_start;

    foreach my $range (@$fresh_ranges)
    {
        if ($current_id <= $range->{start})
        {
            if ((not defined $min_range_start) || $min_range_start > $range->{start})
            {
                $min_range_start = $range->{start}
            }

        }

    }

    return $min_range_start;
}

sub get_last_fresh_id
{
    my $current_id = shift;
    my $fresh_ranges = shift;

    my $max_range_end = $current_id;
    my $extended;

    do
    {
        $extended = 0;
        foreach my $range (@$fresh_ranges)
        {
            if ($max_range_end >= $range->{start} && $current_id <= $range->{end})
            {
                if ($max_range_end < $range->{end})
                {
                    $max_range_end = $range->{end};
                    $extended = 1;
                    last;
                }
            }
        }
    }
    while ($extended);

    return $max_range_end;
}