#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my @sheet;

while (my $line = <$fd>)
{
    $line =~ s/[\r\n]//g;
    $line = $line . " ";  # Append space to handle last value
    my @fields = split //, $line;
    # print "|" . join("|", @fields) . "|\n";
    push @sheet, \@fields;
}

close($fd);

my $operands = pop @sheet;
my $operand;
my $total = 0;
my $value = "";
my @values;

for (my $col = 0; $col < @$operands; $col++)
{
    $operand = $operands->[$col] if $operands->[$col] =~ /[\*\+]/;

    for (my $row = 0; $row < @sheet; $row++)
    {
        next unless defined $sheet[$row][$col];
        next if $sheet[$row][$col] eq ' ';

        $value .= $sheet[$row][$col];
    }

    if ($value eq "")
    {
        if ($operand eq '+')
        {
            my $sum = sum(@values);
            $total += $sum;
            # print "= $sum\n";
        }
        elsif ($operand eq '*')
        {
            my $product = product(@values);
            $total += $product;
            # print "= $product\n";
        }
        @values = ();
    }
    else
    {
        push @values, $value;
        # print "$value ";
    }

    $value = "";
}

print "Total: $total\n";

sub sum
{
    my @values = @_;
    my $sum = 0;

    foreach my $v (@values)
    {
        $sum += $v;
    }

    return $sum;
}

sub product
{
    my @values = @_;
    my $product = 1;

    foreach my $v (@values)
    {
        $product *= $v;
    }

    return $product;
}
