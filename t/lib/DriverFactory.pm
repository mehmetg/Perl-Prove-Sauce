package DriverFactory;

use strict;
use warnings FATAL => 'all';
use Switch;
use Selenium::Firefox;
use Selenium::Remote::Driver;
use LWP::UserAgent;
use HTTP::Request;

# use ENV qw(SAUCE_USERNAME SAUCE_ACCESS_KEY);

use Exporter qw(import);
use Exporter qw(import);

#our @EXPORT_OK = qw(get_driver);
#our @EXPORT_OK = qw(get_driver);
my $target = $ENV{'TARGET'};
my $sauce_server = 'ondemand.saucelabs.com';
my $sauce_api_server = 'saucelabs.com';

sub get_driver(){
    my ($self, $desc) = @_;
    if (!$target) {
        $target = 'firefox';
    }

    my $driver = undef;
    switch ($target) {
        case "firefox"  { $driver =  Selenium::Firefox->new() }
        case "sauce"    { $driver = _get_sauce_driver($desc) }
    }
    return $driver;
}

sub _get_sauce_driver(){
    my ($desc) = @_;

    my $host = "$ENV{'SAUCE_USERNAME'}:$ENV{'SAUCE_ACCESS_KEY'}\@$sauce_server";
    my $driver = new Selenium::Remote::Driver(
        'remote_server_addr' => $host,
        'port' => "80",
        'browser_name' => "chrome",
        'version' => "46.0",
        'platform' => "Windows 10",
        'extra_capabilities' => {'name' => $desc},
    );
    return $driver;
}

sub set_job_result() {
    my ($self, $driver, $result) = @_;
    my $session_id = $driver->get_capabilities()->{'webdriver.remote.sessionid'};
    switch ($target) {
        case "sauce"    {
            my $username = $ENV{'SAUCE_USERNAME'};
            my $api_key = $ENV{'SAUCE_ACCESS_KEY'};

            if ($result) {
                    $result = 'true';
            } else {
                    $result = 'false';
            }

            my $result_data = "{ \"passed\": $result}";

            my $ua = LWP::UserAgent->new();
            my $req = HTTP::Request->new(PUT => "http://$sauce_api_server/rest/v1/$username/jobs/$session_id");
            $req->authorization_basic($username, $api_key);
            $req->header('content-type' => 'application/json');
            $req->content($result_data);
            $ua->request($req)->as_string;
        }

        else       { print("Running local nothing to update!") }

    }
}


1;