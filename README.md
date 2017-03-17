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

# US State name to abbreviation
Geolookup::USA::State.name_to_abbreviation("Alabama")
# => "AL"

# US State name / Abbreviation to lat and long
Geolookup::USA::State.name_to_lat_long("Alabama")
# => [ 32318231,  -86602298]

Geolookup::USA::State.abbreviation_to_lat_long("AL")
# => [ 32318231,  -86602298]

# US State Code to Lat and Long
Geolookup::USA::State.code_to_lat_long(1)
# => [ 32318231,  -86602298]

# US State Names
Geolookup::USA::State.names
# => ["Alabama", "Alaska", ...]

# US State Abbreviations
Geolookup::USA::State.abbreviations
# => ["AL", "AK", "AZ", ...]

# US Domenstic Abbreviations
Geolookup::USA::State.domestic_abbreviations
# => ["CA", "AZ", ...]

# US Domenstic names
Geolookup::USA::State.domestic_names
# => ["California", "Arizona", ...]

# US state codes and abbreviations
Geolookup::USA::State.codes_and_abbreviations
# => {1: "AL", 2: "AK", ...}

# US state codes and names
Geolookup::USA::State.codes_and_names
# => {1: "Alabama", 2: "Alaska", ...}

# US state abbreviations and names
Geolookup::USA::State.abbreviations_and_names
# => {AL: "Alabama", AK: "Alaska", ...}

# US State Codes
Geolookup::USA::State.codes
# => [1, 2, 4, ...]

# US Territory State Codes
Geolookup::USA::State.territory_state_codes
# => [60, 66, 69, ...]

# US Territory State Names
Geolookup::USA::State.territory_state_names
# => ["American Samoa", "Guam", ...]

# US District State Codes
Geolookup::USA::State.district_state_codes
# => [11]

# US District State Names
Geolookup::USA::State.district_state_names
# => ["District of Columbia"]

# Determine if state is territory

# With code
Geolookup::USA::State.territory?(60)
# => true

Geolookup::USA::State.territory?('60')
# => true

# With state name
Geolookup::USA::State.territory?('Guam')
# => true

# With state abbreviation
Geolookup::USA::State.territory?('GU')
# => true

Geolookup::USA::State.territory?('AZ')
# => false

# Determine if state is district

# With code
Geolookup::USA::State.district?(11)
# => true

Geolookup::USA::State.district?('11')
# => true

# With state name
Geolookup::USA::State.district?('District of Columbia')
# => true

# With state abbreviation
Geolookup::USA::State.district?('DC')
# => true

Geolookup::USA::State.district?('FL')
# => false

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

Geolookup::USA::AreaCodes.find('202')
# => {country: 'US', description: '', service: 'y', state: 'DC', type: 'general purpose code'}

Geolookup::USA::Zipcodes.lat_long('90012')
# => {:lat_int=>39715698, :long_int=>-104814319}

Geolookup::Country::PhoneCodes.country_to_phone_code("US")
# => 1
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
