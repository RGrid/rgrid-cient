# Retention::Grid

A ruby client for retentiongrid.com API

## Installation

Add this line to your application's Gemfile:

    gem 'retentiongrid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install retentiongrid

## Usage

    require 'retentiongrid'
    Retentiongrid::Api.api_key = "your_api_key"
    order = Retentiongrid::Order.find(1234)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/retentiongrid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
