# Geolookup

This gem wraps very common Geo lookups to either FIPS data or the collection of international data lookups.

## Installation

Add this line to your application's Gemfile:

    gem 'geolookup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geolookup

## Usage

There are functions within fips and country_info to convert codes to Country and US states.

## Examples
    # FIPS Examples:
    #
    # Code to US state abbreviation
    Geolookup::FIPS.code_to_state_abbreviation(1) # => "AL"

    # Code to US state name
    Geolookup::FIPS.code_to_full_name(1) # => "Alabama"


    # Country Examples:

    Geolookup::name_to_code("American Samoa") # => "AS"

    Geolookup::code_to_name("AS") # => "American Samoa"

    Geolookup::lat_long("American Samoa") # => [ -14333300, -170000000 ]

For additional functions and documentation please look in geolookup/fips.rb and geolookup/country.rb.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/geolookup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs!
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request



## Running the Specs
    -> rake