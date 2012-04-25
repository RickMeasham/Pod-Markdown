# vim: set ts=2 sts=2 sw=2 expandtab smarttab:
use strict;
use warnings;
use Test::More tests => 1;
use Test::Differences;
use Pod::Markdown;

my $pod_prefix = 'http://search.cpan.org/perldoc?';

my $parser = Pod::Markdown->new;
$parser->parse_from_filehandle(\*DATA);
my $markdown = $parser->as_markdown;

my $expect = <<EOMARKDOWN;
# Lists

## Unordered

- This
- is
- a

    basic

- bulleted

    item

- list
- test
- and _Italics_, __Bold__, `Code`, and [Links](${pod_prefix}Links) should work in list item

    and _in_ __paragraph__ `after` [item](${pod_prefix}item)

- verbatim paragraphs

        need double-indent inside lists

## Ordered

1. B
2. D
EOMARKDOWN

1 while chomp $markdown;
1 while chomp $expect;

TODO: {
  local $TODO = 'Lists only minimally supported';
  eq_or_diff $markdown, $expect, "this file's POD as markdown";
}

__DATA__
=head1 Lists

=head2 Unordered

=over 4

=item *

This

=item *	is

=item	* a

basic

=item *

bulleted

item

=item *

list

=item * test

=item * and I<Italics>, B<Bold>, C<Code>, and L<Links> should work in list item

and I<in> B<paragraph> C<after> L<item>

=item * verbatim paragraphs

  need double-indent inside lists

=back

=head2 Ordered

=over

=item 1.

B

=item 2.

D

=back

=cut