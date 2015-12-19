[![Build Status](https://travis-ci.org/st0012/ActiveJob-Cron.svg)](https://travis-ci.org/st0012/ActiveJob-Cron)
[![Code Climate](https://codeclimate.com/github/st0012/ActiveJob-Cron/badges/gpa.svg)](https://codeclimate.com/github/st0012/ActiveJob-Cron)
[![Test Coverage](https://codeclimate.com/github/st0012/ActiveJob-Cron/badges/coverage.svg)](https://codeclimate.com/github/st0012/ActiveJob-Cron/coverage)

# ActiveJob::Cron

This gem provides recurrent functionality for your `ActiveJob`. The usage and implementation is highly inspired by [Sidetiq](https://github.com/tobiassvn/sidetiq).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_job-cron'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_job-cron

## Usage

It's very simple to use, just include `ActiveJob::Cron`, and sets your job's recurrent frequency:

```ruby
class MyJob < ActiveJob::Base
  include ActiveJob::Cron
  
  recurrence { daily }
  
  def perform
    # do something.....
  end
end
```

Or you can specify more complex recurrence like:

```ruby
class MyJob < ActiveJob::Base
  include ActiveJob::Cron
  
  recurrence { weekly.day(:thursday) }
  
  def perform
    # do something.....
  end
end
```

I uses [IceCube](http://seejohncode.com/ice_cube/) as recurrence's DSL, you can see more usages in its documentation.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

- More feature
- More documentation
- More tests

Bug reports and pull requests are welcome on GitHub at https://github.com/st0012/active_job-cron. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

