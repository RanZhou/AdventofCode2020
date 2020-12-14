use strict;
use warnings;
my $file=shift;
open(IN,$file)||die $!;
my $size=0;
my $cmp=1;
my %residual;
while(<IN>){
	chomp;
	my @line=split(/\t/,$_);
	##Two columns:BusPositionIntheColumn(Residual) Then BusID(Prime Number)
	if($line[0] == 0){
		$residual{$line[1]}=0;
	}elsif($line[0]<$line[1]){
		$residual{$line[1]}=$line[1]-$line[0];
	}else{
		$residual{$line[1]}=$line[1]-($line[0]%$line[1]);
	}
	##The actual residual is not the difference between the goal number and the lineID/row number, which I thought it was.
	##So the code above kind of help with the calculation to convert the ID/row number to the modulo needed during the search.
	$cmp=$cmp*$line[1];
}
print "$cmp\n";
my $acc_sum=0;
foreach my $p (sort {$a<=>$b} keys %residual){
	my $revp=$cmp/$p;
	my $modrev=rev_mod($revp,$p);
	$acc_sum=$acc_sum+($residual{$p}*$modrev*$revp);
	print "$p,$residual{$p},$revp,$modrev,$acc_sum\n";
}
my $numberS=$acc_sum%$cmp;
print "$acc_sum,$numberS\n";

## Native search for the Modular multiplicative inverse
sub rev_mod{
	(my $revpn,my $pn)=@_;
    if($revpn % $pn ==1){
		return 1;
	}else{
		for(my $i=1;$i<$pn;$i++){
			if($i*$revpn % $pn ==1){
				return $i;
				last;
			}
		}
	}
}
