#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'WWW::Search::Scrape' );
    use_ok( 'WWW::Search::Scrape::Google' );
}

diag( "Testing WWW::Search::Scrape $WWW::Search::Scrape::VERSION, Perl $], $^X" );
