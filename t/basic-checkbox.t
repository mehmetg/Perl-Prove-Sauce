#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use lib "$FindBin::Bin/lib";
use Test::More;
use DriverFactory;

sub testCheckBox() {

    my $desc = "Testing checkbox state!";

    my $driver = DriverFactory->get_driver($desc);

    $driver->set_implicit_wait_timeout(10);
    $driver->get('https://saucelabs.com/test/guinea-pig');
    my $checkBox = $driver->find_element('checked_checkbox', 'id');
    my $result = $checkBox->is_selected() == 1;

    DriverFactory->set_job_result($driver, $result);
    $driver->quit();
    return $result;
}



ok(testCheckBox());

done_testing();

print @INC