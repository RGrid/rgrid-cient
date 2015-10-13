# Retentiongrid

[![Gem Version](https://fury-badge.herokuapp.com/rb/retentiongrid.png)](http://badge.fury.io/rb/retentiongrid)
[![Build Status](https://travis-ci.org/RGrid/rgrid-client.png?branch=master)](https://travis-ci.org/RGrid/rgrid-client)
[![Coverage Status](https://coveralls.io/repos/RGrid/rgrid-client/badge.png)](https://coveralls.io/r/RGrid/rgrid-client)
[![Code Climate](https://codeclimate.com/github/RGrid/rgrid-client.png)](https://codeclimate.com/github/RGrid/rgrid-client)
[![License](http://img.shields.io/license/MIT.png?color=green) ](https://github.com/RGrid/rgrid-client/blob/master/LICENSE)


A ruby client for retentiongrid.com API


## Installation

Add this line to your application's Gemfile:

    gem 'retentiongrid'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install retentiongrid

## Usage

### set you API key

    require 'retentiongrid'
    Retentiongrid::Api.api_key = "your_api_key"

### Read from retentiongrid

    order = Retentiongrid::Order.find(1234)

### Write to retentiongrid

    order = Retentiongrid::Order.new({
      status:           'ok',
      order_id:         'R123',
      customer_id:      'C321',
      currency:         'EUR',
      total_price:      35.99,
      total_discounts:  0.0,
      order_created_at: Time.now,
    })
    order.save


## Contributing

1. Fork it ( https://github.com/[my-github-username]/retentiongrid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
