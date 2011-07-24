package Queue::Base;

use strict;
use warnings;

# ABSTRACT: Simple OO style queue implementation.

# VERSION

use Carp;

sub new {
    my ( $class, $elems ) = @_;
    my $self = bless( { list => [] }, $class );

    if ( defined $elems && ref($elems) eq 'ARRAY' ) {
        @{ $self->{list} } = @{$elems};
    }

    return $self;
}

sub add {
    my ( $self, @args ) = @_;
    push @{ $self->{list} }, @args;
    return;
}

sub remove_all {
    my $self = shift;
    return ( $self->remove( $self->size ) );
}

sub remove {
    my $self = shift;
    my $num = shift || 1;

    return shift @{ $self->{list} } unless wantarray;

    croak 'Paramater must be a positive number' unless 0 < $num;

    my @removed = ();

    my $count = $num;
    while ($count) {
        my $elem = shift @{ $self->{list} };
        last unless defined $elem;
        push @removed, $elem;
        $count--;
    }

    return @removed;
}

sub size {
    return scalar( @{ shift->{list} } );
}

sub empty {
    return shift->size == 0;
}

sub clear {
    shift->{list} = [];
    return;
}

sub copy_elem {
    my @elems = @{ shift->{list} };
    return @elems;
}

sub peek {
    my $self = shift;
    return $self->{list}->[0];
}

1;

__END__

=head1 SYNOPSIS

    use Queue::Base;

    # construction
    my $queue = new Queue::Base;
    # or
    my $queue = new Queue::Base(\@elements);

    # add a new element to the queue
    $queue->add($element);

    # remove the next element from the queue
    if (! $queue->empty) {
        my $element = $queue->remove;
    }

    # or
    $element = $queue->remove;
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

=method new [ELEMENTS]

Creates a new empty queue.

ELEMENTS is an array reference with elements the queue to be initialized with.

=method add [LIST_OF_ELEMENTS]

Adds the LIST OF ELEMENTS to the end of the queue.

=method remove [NUMBER_OF_ELEMENTS]

In scalar context it returns the first element from the queue.

In array context it attempts to return NUMBER_OF_ELEMENTS requested;
when NUMBER_OF_ELEMENTS is not given, it defaults to 1.

=method remove_all

Returns an array with all the elements in the queue, and clears the queue.

=method size

Returns the size of the queue.

=method empty

Returns whether the queue is empty, which means its size is 0.

=method clear

Removes all elements from the queue.

=method copy_elem

Returns a copy (shallow) of the underlying array with the queue elements.

=method peek

Returns the value of the first element of the queue, wihtout removing it.

=head1 CAVEATS

The module works only with scalar values. If you want to use more complex
structures (and there's a big change you want that) please use references,
which in perl5 are basically scalars.

=cut

