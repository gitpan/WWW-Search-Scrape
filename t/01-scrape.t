#!/perl -T

use Test::Simple qw( no_plan );
use WWW::Search::Scrape qw/:all/;

BEGIN
{
    ok(!search({engine => 'a', results => '2'}));
    ok(!search({engines => 'a', results => '2'}));
    ok(!search({engine => 'GooGlE'}));
    ok(!search({engine => 'GooGlE', results => 0}));
    ok(search({engine => 'GooGlE', results => '1', keyword => 'x'}));
    ok(search({engine => 'bInG', results => '1', keyword => 'x'}));
    $res = search({engine => 'GooGlE', results => '50', keyword => 'test'});

    use Data::Dumper;
    warn Dumper($res);
    warn $res->{num};
    ok($res->{num} > 500);
}
