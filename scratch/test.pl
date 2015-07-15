#!/usr/bin/perl

use strict;
use warnings;

use DateTime::Format::Strptime;

my $fmt = '%Y-%m-%dT%H:%M:%S.%3NZ';

my ($start, $end) = qw(2004-11-15T18:59:52.863Z
                       2004-11-15T19:09:52.972Z);
print "start $start\nend $end\n";

my $parser = DateTime::Format::Strptime->new(pattern => $fmt);

my $dt1 = $parser->parse_datetime($start) or die;
my $dt2 = $parser->parse_datetime($end) or die;

my $diff = $dt2 - $dt1;

print $diff->hours, " hours\n";
print $diff->minutes, " minutes\n";
print $diff->seconds, " seconds\n";
print $diff->nanoseconds / 1e6, " milliseconds\n";
