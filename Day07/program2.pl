#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

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
                $beams{$key+1} = 0;
            }
            if (not defined $beams{$key-1})
            {
                $beams{$key-1} = 0;
            }
            $beams{$key+1} += $beams{$key};
            $beams{$key-1} += $beams{$key};
            delete $beams{$key};
        }
    }
}

close($fd);

my $count = 0;

foreach my $key (keys %beams)
{
    if (defined $beams{$key})
    {
        $count += $beams{$key};
    }
}

print "Beams: $count\n";
