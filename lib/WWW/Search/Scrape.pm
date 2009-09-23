package WWW::Search::Scrape;

use warnings;
use strict;

use Data::Dumper;
#use Smart::Comments;

use Carp;

use WWW::Search::Scrape::Google;

=head1 NAME

  WWW::Search::Scrape - Scrape search engine results

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS


  use WWW::Search::Scrape qw/:all/;
  my $result = search(engine => 'google', keyword =>'keywords', results => 10);
  print "Google returns " . $result->{num} . " results\n";
  print $_, "\n" foreach (@{$result->{num}});

=head1 DESCRIPTION

=head1 DESCRIPTION

  Most search engines do not provide full-function search API.

  Google finally shut down its Google search API on Sept 2009, while the registration for Google Search API had been disabled for years actually. The follower -- Google AJAX API, is simple not satisfied enough. That is why I wrote this module.

  The purpose of this module is provide a simple interface to extract top search results from Google search engine, and keep this interface as simple as possible (as soon as possible as well).

  Currently, it supports 'google.com' only. And maybe English as well. I schedule to add more functions soon.

=head1 EXPORT


  There is only one function in WWW::Search::Scrape -- search.

=cut

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

our @ISA = qw(Exporter);
our %EXPORT_TAGS = ('all' => [qw/search/]);
our @EXPORT_OK = (@{$EXPORT_TAGS{all}});
our @EXPORT = qw();

=head1 FUNCTIONS

=head2 search

search is the most important function in this module. It is used as a dispatcher for corresponding search engines -- Google, Yahoo, Bing etc.

It accepts a config hash. Possible keys are,
+---------+--------------------------------------------------------+
| engine  | The name for the search engine, like 'google', 'bing'  |
+---------+--------------------------------------------------------+
| keyword | The keyword(s) for the searching terms                 |
+---------+--------------------------------------------------------+
| results | How many results should be returned    (default: 10)   |
+---------+--------------------------------------------------------+

It returns a hash ref
+---------+-------------------------------------------------------------------------+
|   num   | How many items the search engine are able to return? (estimated number) |
+---------+-------------------------------------------------------------------------+
| results | List of returned results                                                +
+---------+-------------------------------------------------------------------------+

=cut

sub search (%) {
    my ($q) = @_;
### search got query: $q
    unless (ref($q) eq "HASH")
    {
        carp 'search query should be hash';
        return undef;
    }

    unless ($q->{engine})
    {
        carp 'engine not set.';
        return undef;
    }

    unless ($q->{results} && $q->{results} >= 0) {
        carp 'search results number not set.';
        return undef;
    }

    unless ($q->{keyword} && length($q->{keyword}) >= 1) {
        carp 'search keyword not set.';
        return undef;
    }

    if (lc $q->{engine} eq 'google') {
        return WWW::Search::Scrape::Google::search($q->{keyword}, $q->{results});
    }
    else {
        carp 'Search engine ' . $q->{engine} . ' not implemented yet.';
        return undef;
    }
}

=head1 AUTHOR

Quan Sun, C<< <cfk.quan at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-search-scrape at rt.cpan.org>, or C<cfk.quan@gmail.com>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Search-Scrape>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Search::Scrape


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Search-Scrape>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Search-Scrape>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Search-Scrape>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Search-Scrape/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Quan Sun.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WWW::Search::Scrape