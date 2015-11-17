#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use lib "$FindBin::Bin/lib";
use Test::More;
use DriverFactory;

sub testBody() {
    my $desc = "Testing page title!";

    my $driver = DriverFactory->get_driver($desc);
    $driver->set_implicit_wait_timeout(10);
    $driver->get('https://saucelabs.com/test/guinea-pig');

    my $title = $driver->get_title();
    my $result = ($title eq "I am a page title - Sauce Labs");
    # print("$title\n");
    DriverFactory->set_job_result($driver, $result);
    $driver->quit();
    return $result;
}

ok(testBody());

done_testing();

