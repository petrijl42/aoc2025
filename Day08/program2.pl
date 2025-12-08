#!/usr/bin/perl -w

use strict;
use warnings;

my @junctions;
my %circuits;
my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $i = 0;
while (my $line = <$fd>)
{
    chomp $line;
    my @coords = split /,/, $line;
    push @junctions, {x => $coords[0], y => $coords[1], z => $coords[2], circuit => $i};
    $circuits{$i} = [$i];
    $i++;
}

close($fd);


my ($from_id, $to_id) = merge_circuits(\@junctions, \%circuits);

my $result = $junctions[$from_id]->{x} * $junctions[$to_id]->{x};
print "Result: $result\n";


sub distance
{
    my $junction_a = shift;
    my $junction_b = shift;

    my $dx = $junction_a->{x} - $junction_b->{x};
    my $dy = $junction_a->{y} - $junction_b->{y};
    my $dz = $junction_a->{z} - $junction_b->{z};

    return sqrt($dx * $dx + $dy * $dy + $dz * $dz);
}


sub get_junction_distances
{
    my $junction_list = shift;

    my @distances;

    for (my $from_id = 0; $from_id < @{$junction_list}; $from_id++)
    {
        for (my $to_id = $from_id + 1; $to_id < @{$junction_list}; $to_id++)
        {
            my $from = $junction_list->[$from_id];
            my $to = $junction_list->[$to_id];
            my $distance = distance($from, $to);
            push @distances, {distance => $distance, from => $from_id, to => $to_id};
        }
    }

    return \@distances;
}


sub merge_circuits
{
    my $junctions = shift;
    my $circuits = shift;

    my $distances = get_junction_distances($junctions);
    my @sorted = sort {$a->{distance} <=> $b->{distance}} @$distances;

    for (my $i = 0; $i < @sorted; $i++)
    {
        my $from_id = $sorted[$i]->{from};
        my $to_id = $sorted[$i]->{to};

        my $from = $junctions->[$from_id];
        my $to = $junctions->[$to_id];

        next if ($from->{circuit} == $to->{circuit});

        my $old_circuit = $to->{circuit};
        my $new_circuit = $from->{circuit};

        foreach my $junction_id (@{$circuits->{$old_circuit}})
        {
            $junctions->[$junction_id]->{circuit} = $new_circuit;
        }

        $circuits->{$new_circuit} = [ @{$circuits->{$new_circuit}} , @{$circuits->{$old_circuit}} ];
        delete $circuits->{$old_circuit};

        if (keys %{$circuits} == 1)
        {
            return ($from_id, $to_id);
        }
    }

    die "Could not merge all circuits\n";
}
