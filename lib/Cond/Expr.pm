use strict;
use warnings;

package Cond::Expr;
# ABSTRACT: conditionals as expressions

use Sub::Exporter -setup => {
    exports => ['cond'],
    groups  => { default => ['cond'] },
};

use Devel::CallParser;
use Devel::CallChecker;

use XSLoader;

XSLoader::load(
    __PACKAGE__,
    $Cond::Expr::{VERSION} ? ${ $Cond::Expr::{VERSION} } : (),
);

=head1 SYNOPSIS

    my %args = (
        foo => 'bar',
        (cond
            ($answer == 42) { answer => $answer }
            ($answer)       { wrong_answer => 1 }
            otherwise       { no_answer    => 1 }
        ),
    );

=head1 DESCRIPTION

This module implements a Lisp alike C<cond> control structure.

=head2 How is this different from…

=over 4

=item * C<given>/C<when>

C<given> is a statement, not an expression, and is therefore not readily usable
as part of an expression unless its use is wrapped within a C<do> block, which
is cumbersome.

Additionally, this module avoids all the, possibly unwanted, side effects
C<given>/C<when> and it's underlying smart matching mechanism happen to impose.

=item * C<if>/C<elsif>/C<else>

Similar to C<given>, C<if> is a statement, needing special care in order to be
useful as part of a surrounding expression.

=item * Nested ternary C<?:>

Using nested ternary C<?:> expressions, such as in

  my %args = (
      foo => 'bar',
      (($answer == 42)
          ? (answer => $answer)
              : ($answer)
                  ? (wrong_answer => 1)
                      : (no_answer => 1)),
  );

can be used to achieve functionality similar to what this module provides. In
fact, the above use of C<?:> is exactly what the L</SYNOPSIS> for this module
will compile into. The main difference is the C<cond> syntax provided by this
module being easier on the eye.

=back

=func cond

Takes a set of test/expr pairs. It evaluates each test one at a time. If a test
returns logical true, cond evaluates and returns the value of the corresponding
expr and doesn't evaluate any of the other tests or exprs. When none of the
provided tests yield a true value, C<()> or C<undef> is returned in list and
scalar context, respectively.

=cut

1;
