use strict;
use warnings;
my $file=shift;
open(IN,$file)||die $!;
my $my_number=1015292;
my $closest_number=1016300;
my %busID;
while(<IN>){
	chomp;
	next unless($_=~/\,/);
	my @line=split(/\,/,$_);
	foreach my $bus (@line){
		next if($bus eq "x");
		my $cwait_time=$closest_number-$my_number;
		my $measure=$my_number%$bus;
		if($measure == 0){
			print "$bus doesn't need to wait!\n";
			exit;
		}else{
			my $bus_dis=$bus-$measure;
			print "$bus\t$measure\t$bus_dis\t$cwait_time\n";
			if($bus_dis<$cwait_time){
				$closest_number=$my_number+$bus_dis;
				$busID{$closest_number}=$bus;
			}else{
				next;
			}
		}
	}
}
print "Bus:$busID{$closest_number}\n";
my $req=($closest_number-$my_number)*$busID{$closest_number};
print "Answer:$req\n";