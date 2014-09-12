# NAdicNumber

[![Gem Version](https://badge.fury.io/rb/n_adic_number.svg)](http://badge.fury.io/rb/n_adic_number) [![Build Status](https://travis-ci.org/tsukasaoishi/n_adic_number.svg?branch=master)](https://travis-ci.org/tsukasaoishi/n_adic_number) [![Code Climate](https://codeclimate.com/github/tsukasaoishi/n_adic_number/badges/gpa.svg)](https://codeclimate.com/github/tsukasaoishi/n_adic_number)

NAdicNumber treats N-adic Number.

## Installation

Add this line to your application's Gemfile:

    gem 'n_adic_number'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install n_adic_number

## Usage
NAdicNumber::Base.mapping is setting map table of N-adic Number.
For example, 16-adic:

    class NumberObBase16 < NAdicNumber::Base
      mapping ["0".."9", "a".."f"].map{|r| r.to_s}.flatten
    end

For example, 94-adic:

    class NumberObBase94 < NAdicNumber::Base
      mapping (33..126).map{|i| i.chr}
    end

Sample:

    class NumberOfBase62 < NAdicNumber::Base
      mapping ["0".."9", "A".."Z", "a".."z"].map{|r| r.to_a}.flatter
    end

    one = NumberOfBase62.new(1)
    sixty_two = NumberOfBase62.new(62)

    one.to_s #=> "1"
    sixty_two.to_s #=> "z"
    one.to_i #=> 1
    sixty_two.to_i => 62

    sum = one + sixty_two
    sum.to_i #=> 63
    sum.to_s #=> "10"

    sum += 100
    sum.to_s #=> "2d"
    sum.to_i #=> 163

    all_a = NumberOfBase62.new("aaaaa")
    all_a.to_s #=> "aaaaa"
    all_a.to_i #=> 540668556




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
