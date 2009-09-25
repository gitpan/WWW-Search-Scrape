#!/usr/bin/perl -T

use Test::More qw/no_plan/;
use WWW::Search::Scrape::Bing;

BEGIN
{
    ok(WWW::Search::Scrape::Bing::search('bing', 10));
}
