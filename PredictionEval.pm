package PredictionEval;
use strict;
use warnings 'FATAL' => 'all';

# Object used to store total Nucleotide/CDS/Gene Counts
sub new{
	my ($class) = @_;
	
	my $self = {
		true_pos  => 0,
		true_neg  => 0,
		false_pos => 0,
		false_neg => 0,
		match     => 0,
		mismatch  => 0,
		missing   => 0,

	};
	bless $self, $class;
	return $self;
}

sub true_pos{
	my ($self, $tp) = @_;
	return $self->{true_pos} unless defined $tp;
	$self->{true_pos} += $tp;
}

sub true_neg{
	my ($self, $tn) = @_;
	return $self->{true_neg} unless defined $tn;
	$self->{true_neg} += $tn;
}

sub false_pos{
	my ($self, $fp) = @_;
	return $self->{false_pos} unless defined $fp;
	$self->{false_pos} += $fp;
}

sub false_neg{
	my ($self, $fn) = @_;
	return $self->{false_neg} unless defined $fn;
	$self->{false_neg} += $fn;
}

sub match{
	my ($self, $match) = @_;
	return $self->{match} unless defined $match;
	$self->{match} += $match;
}

sub mismatch{
	my ($self, $miss) = @_;
	return $self->{mismatch} unless defined $miss;
	$self->{mismatch} += $miss;
}

sub missing{
	my ($self, $none) = @_;
	return $self->{missing} unless defined $none;
	$self->{missing} += $none;
}


#===================================#
# Calculating Evaluation Parameters #
#===================================#

# Sensitivity(TPR)
sub calc_tpr{
	my ($tp, $fn) = @_;
	my $denom = $tp + $fn;
	
	my $tpr;
	if ($denom == 0) {
		$tpr = 0;
	} else {
		$tpr = $tp/($denom);
	}
	return $tpr;
}

# Specificity(SPC)
sub calc_spc{
	my ($tn, $fp) = @_;
	my $denom = $tn + $fp;
	
	my $spc;
	if ($denom == 0) {
		$spc = 0;
	} else {
		$spc = $tn/($denom);
	}
	return $spc;
}

# Positive Predictive Value(PPV)
sub calc_ppv{
	my ($tp, $fp) = @_;
	my $denom = $tp + $fp;
	
	my $ppv;
	if ($denom == 0) {
		$ppv = 0;
	} else {
		$ppv = $tp/($denom);
	}
	return $ppv;
}

# Accuracy(ACC)
sub calc_acc{
	my ($tp, $tn, $fp, $fn) = @_;
	my $denom = $tp + $tn + $fp + $fn;
	
	my $acc;
	if ($denom == 0) {
		$acc = 0;
	} else {
		$acc = ($tp + $tn)/($denom);
	}
	return $acc;
}

# Matthews Correlation Coefficient(MCC)
sub calc_mcc{
	my ($tp, $tn, $fp, $fn) = @_;
	my $num   = ($tp * $tn) - ($fp * $fn);
	my $denom = ($tp + $fp)*($tp + $fn)*($tn + $fp)*($tn + $fn);
	
	my $mcc;
	if ($denom == 0) {
		$mcc = 0;
	} else {
		$mcc = $num/sqrt($denom);
	}
	return $mcc;
}

1;