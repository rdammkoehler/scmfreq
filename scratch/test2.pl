#!/usr/bin/perl

use strict;
use warnings;

use DateTime::Format::Strptime;

#my $fmt = '%Y-%m-%dT%H:%M:%S.%3NZ';
my $fmt = "%a %b %d %H:%M:%S %Y %z";

#my ($start, $end) = qw(2004-11-15T18:59:52.863Z
#                       2004-11-15T19:09:52.972Z);
my ($start, $end) = ( "Thu Aug 25 08:48:08 2011 +0200", "Thu Aug 25 09:48:08 2011 +0200" );
print "start $start\nend $end\n";

my $parser = DateTime::Format::Strptime->new(pattern => $fmt);

my $dt1 = $parser->parse_datetime($start) or die;
my $dt2 = $parser->parse_datetime($end) or die;

my $diff = $dt2 - $dt1;

print $diff->hours, " hours\n";
print $diff->minutes, " minutes\n";
print $diff->seconds, " seconds\n";
print $diff->nanoseconds / 1e6, " milliseconds\n";
