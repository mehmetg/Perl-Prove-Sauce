Using Sauce Labs with Perl
===========================

## Setup:

* Install [perl](http://www.perl.org) version 5.20 or newer.
* Install [cpan](http://www.cpan.org/).
* Install the following dependencies using cpan.
    <pre> cpan -i [dependency] </pre>
   
           * HTTP::Request
           * LWP::UserAgent
           * Selenium::Firefox
           * Selenium::Remote::Driver
           * Switch

* Set environment variables:
    * SAUCE_USERNAME=[your user name]
    * SAUCE_ACCESS_KEY=[your access/api key]
    * TARGET =["firefox"|"sauce"|blank]
        * "firefox" or blank  for local runs
        * "sauce" for Sauce Labs runs.
        
## Runing Tests:
Use the command below fromt the root of the project. For serial runs you should omit the "-jX" flag.
<pre>prove -jX</pre>
X : number of concurrent tests. 
Each test definition file (*.t) will be run in a different thread.

## Known Issues:
The Selenium::Firefox package has concurrency issues and will not run right for parallel tests. Sauce labs target 
runs without issues. 
