package multidimensional;
BEGIN {
  $multidimensional::VERSION = '0.001';
}
# ABSTRACT: disables multidmensional array emulation

{ use 5.008; }
use strict;
use warnings;

use B::Hooks::OP::Check;
use XSLoader;

XSLoader::load __PACKAGE__, our $VERSION;


sub unimport { $^H{+(__PACKAGE__)} = 1 }


sub import { $^H{+(__PACKAGE__)} = undef }


1;

__END__
=pod

=head1 NAME

multidimensional - disables multidmensional array emulation

=head1 VERSION

version 0.001

=head1 SYNOPSIS

    no multidimensional;

    $hash{1, 2};                # dies
    $hash{join($;, 1, 2)};      # also dies

=head1 DESCRIPTION

Perl's multidimensional array emultaion stems from the days before the
language had references, but these days it mostly serves to bite you
when you typo a hash slice by using the C<$> sigil instead of C<@>.

This module lexically makes using multidmensional array emulation a
fatal error at compile time.

=head1 METHODS

=head2 unimport

Disables multidimensional array emultaion for the remainder of the
scope being compiled.

=head2 import

Enables multidimensional array emulation for the remainder of the
scope being compiled;

=head1 CAVEAT

Because of the way the module operates (by checking the optree), it also
catches explicit use of C<join($;, ...)> in a hash subscript.  If you
need to do this, either enable multidimensional hash emulation for just
that scope or use one of the following workarounds:

    my $key = join($;, 1, 2);
    $hash{$key};

    my $sep = $;;
    $hash{join($sep, 1, 2)};

    $hash{join(my $sep = $;, 1, 2)};

=head1 SEE ALSO

L<perlvar/$;>,
L<B::Hooks::OP::Check>.

=head1 AUTHOR

Dagfinn Ilmari Mannsåker <ilmari@ilmari.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Dagfinn Ilmari Mannsåker.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

