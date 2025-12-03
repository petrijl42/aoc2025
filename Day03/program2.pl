#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $sum = 0;
my $digit_count = 12;

while (my $line = <$fd>)
{
    chomp($line);

    my @digits;

    for (my $i = 0; $i < $digit_count; $i++)
    {
        my $reserve_count = $digit_count - $i - 1;

        my $str = $line;
        $str = substr($line, 0, $reserve_count * -1) if $reserve_count > 0;

        my $digit = get_largest_digit($str);
        push @digits, $digit->{value};
        $line = substr($line, $digit->{index} + 1);
    }

    my $value = int(join('', @digits));

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
