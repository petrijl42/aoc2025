#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my @sheet;

while (my $line = <$fd>)
{
    chomp $line;
    $line =~ s/(^\s+)|(\s+$)//g;
    $line =~ s/ +/ /g;
    push @sheet, [split(/ /, $line)];
}

close($fd);

my $total = 0;
my $operands = pop @sheet;

for (my $col = 0; $col < @$operands; $col++)
{
    my $col_total = ($operands->[$col] eq '*') ? 1 : 0;

    for (my $row = 0; $row < @sheet; $row++)
    {
        next unless defined $sheet[$row][$col];

        if ($operands->[$col] eq '*')
        {
            $col_total *= $sheet[$row][$col];
        }
        elsif ($operands->[$col] eq '+')
        {
            $col_total += $sheet[$row][$col];
        }
    }
    # print "Column $col total: $col_total\n";
    $total += $col_total;
}

print "Total: $total\n";
