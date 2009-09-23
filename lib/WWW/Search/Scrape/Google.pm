package WWW::Search::Scrape::Google;

use warnings;
use strict;

use Smart::Comments;

use Carp;

use LWP::UserAgent;
use HTML::TreeBuilder;

=head1 NAME

  WWW::Search::Scrape::Google - Google search engine

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

  You are not expected to use this module directly. Please use WWW::Search::Scrape instead.

=cut

=head1 FUNCTIONS

=head2 search

 'search is the most important function in this module.

Inputs
+---------------------------+
|        keyword            |
+---------------------------+
| desired number of results |
+---------------------------+

=cut


sub search($$)
{
    my ($keyword, $results_num) = @_;
### search google using
###   keyword: $keyword
###   results number: $results_num

    if ($results_num >= 100) {
        carp 'WWW::Search::Scrape::Google can not process results more than 100.';
        return undef;
    }

    my @res;

    my $ua = LWP::UserAgent->new;
    $ua->agent('Googlebot');

    my $url = "http://www.google.com/search?hl=en&source=hp&q=${keyword}&aq=f&oq=&aqi=g10&num=100";
### Query URL is: $url

    my $response = 
        $ua->get($url);
    if ($response->is_success) {
        my $tree = HTML::TreeBuilder->new;
        $tree->parse($response->decoded_content);
        $tree->eof;

        my @x = $tree->look_down('_tag', 'h3', 
                                 sub {
                                     return unless $_[0]->attr('class') eq 'r';
                                     1;
                                 });

        foreach (@x) {
            my ($link) = $_->look_down('_tag', 'a');
            push @res, $link->attr('href') unless $link->attr('href') =~ /^\//;
        }

    } else {
        die $response->status_line;
    }

### Result: @res
    return \{num => 100, results => @res};
}
    
