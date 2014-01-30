# Geolookup

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'geolookup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geolookup

## Usage

There are functions within fips and country_info to convert codes to Country and US states.

So for example one:

    Geolookup::FIPS.code_to_state_abbreviation(1) => "AL"

## Contributing

1. Fork it ( http://github.com/<my-github-username>/geolookup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs!
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request



## Running the Specs
    -> rake