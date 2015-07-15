#!/usr/bin/perl
use DateTime::Format::Strptime;
use DateTime::Format::Duration;

my %author_commit=();
my $author = "";
while(<>) {
    my $line = $_;
    if (/Author:/) {
	( $author ) = $line =~ /Author: (.*)$/;
    }
    if (/Date:/) {
	my ( $date ) = $line =~ /Date:\s+(.*)$/;
	push @{ $author_commit{$author} }, $date;
    }
}


#Thu Aug 25 08:48:08 2011 +0200
my $epoch = "Sat Jan 1 00:00:00 2000 +0500";
print "epoch $epoch\n";
my ($a,$m,$d,$H,$M,$S,$Y,$z) = split " |:", $epoch;
print "$a,$m,$d,$H,$M,$S,$Y,$z\n";

my $fmt = "%a %b %d %H:%M:%S %Y %z";
my $parser = DateTime::Format::Strptime->new( pattern => $fmt );
my $duration_format = DateTime::Format::Duration->new(
                pattern => '%Y years, %m months, %e days, '.
                                '%H hours, %M minutes, %S seconds'
        );
for my $key ( keys %author_commit ) {
    my $last = $epoch;
    print "$key :\n";
    for my $date ( reverse @{ $author_commit{$key} } ) {
	my $dt1 = $parser->parse_datetime($last) or die;
	my $dt2 = $parser->parse_datetime($date) or die;
        my $diff  = $dt2 - $dt1;
	print "\t" . $duration_format->format_duration( $diff ) . "\n";
	$last = $date;
    }
    print "\n";
}
