
package Queue::Base;

$VERSION = "1.02";


################################################################################

# Public Interface

################################################################################


sub new
{
	my $class = shift();
	my ($rElements) = shift();

	my $obj = {};
	bless($obj, $class);
		
	if (defined $rElements && ref($rElements) eq 'ARRAY') {
		@{$obj->{'list'}} = @{$rElements};
	}
	else {
		@{$obj->{'list'}} = ();
	}
	
	return $obj;
}


sub add
{
	my $obj = shift();
	
	while (my $elem = shift)
	{ 
		push(@{$obj->{'list'}}, $elem);
	}
}


sub remove
{
	my $obj = shift();
	my ($numOfElements) = shift;

	if (wantarray())
	{ 
		my @removedElements = ();
		if (! defined $numOfElements) {
			$numOfElements = 1;
		}

		for (my $k = $numOfElements; $k > 0; $k--)
		{
			if (my $elem = shift(@{$obj->{'list'}}) ) {
				push(@removedElements, $elem);
			}
			else {
				last;
			}
		}

		return @removedElements;
	}
	else {
		my $elem = shift(@{$obj->{'list'}});
		return $elem;
	}
}


sub size
{
	my $obj = shift();
	
	return scalar(@{$obj->{'list'}});
}


sub empty
{
	my $obj = shift();
	
	$obj->{'list'} = [];
}


1;


__END__

=head1 NAME

Queue::Base - Simple OO style queue implementation.

=head1 SYNOPSIS

 use Queue::Base;

 # construction
 my $queue = new Queue::Base;
 # or
 my $queue = new Queue::Base(\@elements);
 
 # add new element to the queue
 $queue->add($element);
 
 # remove an element from the queue
 if ($queue->size()) {
     my $element = $queue->remove();
 }
 # or
 $element = $queue->remove();
 if (defined $element) {
     # do some processing here
 }
 
 # add/remove more than just one element
 $queue->add($elem1, $elem2 ...)
 # and
 @elements = $queue->remove(5);

=head1 DESCRIPTION

The Queue::Base is a simple implementation for queue structures using an 
OO interface. Provides basic functionality: nothing less - nothing more.

=head1 METHODS

=head2 Constructor

=over

=item new [ELEMENTS]

Creates a new empty queue.

ELEMENTS is an array reference with elements the queue to be initialized with.

=back

=head2 Methods

=over

=item add [LIST_OF_ELEMENTS]

Adds the LIST OF ELEMENTS to the end of the queue.

=item remove [NUMBER_OF_ELEMENTS]

In scalar context it return the first element from the queue.

In scalar context it attempts to return the NUMBER_OF_ELEMENTS requested;
when NUMBER_OF_ELEMENTS is not given, it defaults to 1.

=item size

Returns the size of the queue.

=item emtpy

Empties the queue.

=back

=head1 CAVEATS

The module works only with scalar values. If you want to use more complex 
structures (and there's a big change you want that) please use references, 
which in perl5 are implemented as scalars.

=head1 AUTHOR

Farkas Arpad <arpadf@spidernet.co.ro>

=cut
