#!/usr/bin/perl -w

use strict;

use Test;
BEGIN { plan tests => 5};

use Queue::Base;
@Queue::ISA = qw(Queue::Base);

use File::Basename;
use lib dirname(readlink($0)||$0);
use TestLib;

use vars qw(@testElements);

################################################################################


@testElements = qw(one two three);


TEST1: # simple add/remove (queue size)
{
	my $queue = new Queue;
	if ($queue->size() != 0) {
		ok(0);
		last TEST1;
	}
	
	$queue->add('one');
	$queue->add('two');
	$queue->remove();
	$queue->add('three');

	if ($queue->size() != 2) {
		ok(0);
		last TEST1;
	}
	
	$queue->remove();
	$queue->remove();
	$queue->remove();
	
	if ($queue->size() != 0) {
		ok(0);	
	}
	else {
		ok(1);
	}
}


TEST2: # simple add/remove (content)
{ 
	my $queue = new Queue;	

	$queue->add('one');
	$queue->add('two');
	$queue->add('three');

	my @readElements;
	my $element = $queue->remove(); push(@readElements, $element);
	$element = $queue->remove(); push(@readElements, $element);
	$element = $queue->remove(); push(@readElements, $element);
	
	if (! match_structure(\@testElements, \@readElements)) {
		ok(0);
		last TEST2;
	}

	# should not add element - remove() returns undef
	if (my $element = $queue->remove()) {
		push (@readElements, $element);
	}

	if (! match_structure(\@testElements, \@readElements)) {
		ok(0);
		last TEST2;
	}
	else {
		ok(1);
	}
}


TEST3: # add/remove multiple elements
{
	my $queue = new Queue;
	$queue->add('one', 'two');
	$queue->add('three');

	my @readElements;
	push (@readElements, $queue->remove(2));
	push (@readElements, $queue->remove());

	if (! match_structure(\@testElements, \@readElements)) {
		ok(0);
		last TEST3;
	}

	# the queue is now empty
	push (@readElements, $queue->remove());

	if (! match_structure(\@testElements, \@readElements)) {
		ok(0);
		last TEST3;
	}

	# try to remove more nonexistent elements
	push (@readElements, $queue->remove(5));

	if (! match_structure(\@testElements, \@readElements)) {
		ok(0);
	}
	else {
		ok(1);
	}
}


TEST4: # initializing the queue
{
	my $queue = new Queue(\@testElements);

	my @readElements;
	push (@readElements, $queue->remove($queue->size()));

	if (! match_structure(\@testElements, \@readElements)) {
		ok(0);
	}
	else {
		ok(1);
	}
}


TEST5: # empty the queue
{
	my $queue = new Queue(\@testElements);
	
	$queue->empty();
	
	if ($queue->size() != 0) {
		ok(0);
	}
	else {
		ok(1);
	}
}

