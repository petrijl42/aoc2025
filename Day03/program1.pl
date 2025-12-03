#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $sum = 0;

while (my $line = <$fd>)
{
    chomp($line);

    my $first_str = substr($line, 0, -1);
    my $first_digit = get_largest_digit($first_str);

    my $second_str = substr($line, $first_digit->{index} + 1);
    my $second_digit = get_largest_digit($second_str);
    my $value = int($first_digit->{value} . $second_digit->{value});

    # print "$value\n";
    $sum += $value;
}

close($fd);

print "Sum: $sum\n";

sub get_largest_digit
{
    my $line = shift;

    my @chars = split(//, $line);
    my $length = scalar @chars;

    my $largest =
    {
        value => 0,
        index => 0
    };

    for (my $i = 0; $i < $length; $i++)
    {
        if ($chars[$i] > $largest->{value})
        {
            $largest->{value} = $chars[$i];
            $largest->{index} = $i;
        }
    }

    return $largest;
}
