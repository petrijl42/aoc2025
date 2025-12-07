#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $splits = 0;
my %beams;

while (my $line = <$fd>)
{
    chomp $line;
    my @data = split //, $line;

    for (my $i = 0; $i < @data; $i++)
    {
        if ($data[$i] eq 'S')
        {
            $beams{$i} = 1;
        }
    }

    foreach my $key (keys %beams)
    {
        if ($data[$key] eq '^')
        {
            if (not defined $beams{$key+1})
            {
                $beams{$key+1} = 1;
            }
            if (not defined $beams{$key-1})
            {
                $beams{$key-1} = 1;
            }
            $splits++;
            delete $beams{$key};
        }
    }
}

close($fd);

print "Splits: $splits\n";
