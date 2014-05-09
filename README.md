# Geolookup [![Build Status](https://travis-ci.org/Spokeo/geolookup.png?branch=master)](https://travis-ci.org/Spokeo/geolookup)
[![Code Climate](https://codeclimate.com/github/Spokeo/geolookup.png)](https://codeclimate.com/github/Spokeo/geolookup)

This gem wraps very common Geo lookups to either FIPS data or the collection of international data lookups.  All codes on the app are FIPS codes.

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

```ruby
# US State Examples:

# Code to US state abbreviation
Geolookup::USA::State.code_to_abbreviation(1)
# => "AL"

# Code to US state name
Geolookup::USA::State.code_to_name(1)
# => "Alabama"

# US State Name to US state code
Geolookup::USA::State.name_to_code("Alabama")
# => 1

# US State abbreviation to name
Geolookup::USA::State.abbreviation_to_name("AL")
# => "Alabama"

# US State name / Abbreviation to lat and long
Geolookup::USA::State.name_to_lat_long("Alabama")
# => [ 32318231,  -86602298]

Geolookup::USA::State.abbreviation_to_lat_long("AL")
# => [ 32318231,  -86602298]

# US State Code to Lat and Long
Geolookup::USA::State.code_to_lat_long(1)
# => [ 32318231,  -86602298]

# US County Examples:

# Given a state code and county code return the county name
Geolookup::USA::County.code_to_name(1, 1)
# => "AUTAUGA"

# Given a state code and county code return the lat and long for that county
Geolookup::USA::County.code_to_lat_long(1, 1)
# => [32534930, -86642790]

# Given a state code and county name return the county code
Geolookup::USA::County.name_to_code(1, 'Autauga')
# => 1


# Country Examples:

Geolookup::Country.name_to_code("American Samoa")
# => "AS"

Geolookup::Country.code_to_name("AS")
# => "American Samoa"

Geolookup::Country.lat_long("American Samoa")
# => [ -14333300, -170000000 ]
```

For additional functions and documentation please look in geolookup/fips.rb and geolookup/country.rb.

## Contributing

1. Fork it ( http://github.com/Spokeo/geolookup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs!
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## Running the Specs
    $ rake