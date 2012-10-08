# Thincloud::Resque

## Description

Rails Engine to provide Resque support for Thincloud applications.

The Thincloud::Resque engine:

* Manages all the Resque (and Redis) dependencies for your application
* Initializes the Redis connection and namespace for Resque
* Configures the Resque Front End to use HTTP Basic authentication at `/admin/resque`
* Optionally configures `resque_mailer`
* Provides a generator to add a Capistrano recipe and a Procfile entry

## Requirements

This gem requires Rails 3.2+ and has been tested on the following versions:

* 3.2

This gem has been tested against the following Ruby versions:

* 1.9.3


## Installation

Add this line to your application's Gemfile:

``` ruby
gem "thincloud-resque"
```

* Run `bundle`

Or install it yourself as:

```
$ gem install thincloud-resque
```

## Usage

### Configuration

Thincloud::Resque configuration options are available under the Rails configuration object. Available options and their default values:

```ruby
  # ...
  # Redis connection details
  config.thincloud.resque.redis_url       = "unix:///tmp/redis.sock"
  config.thincloud.resque.redis_namespace = "resque:APP_NAME:RAILS_ENV"

  # Authenticaiton details used for the Resque Front End
  config.thincloud.resque.web_username    = "thincloud-resque"
  config.thincloud.resque.web_password    = "thincloud-resque"

  # Option to configure Resque::Mailer
  config.thincloud.resque.mailer          = true
  config.thincloud.resque.mailer_excluded_environments = []
  #...
```

_Note: this is how they would look when added to your application's config block_

By default, several of the options will default to environment variables when found.

```
  redis_url    -> ENV["REDIS_URL"]
  web_username -> ENV["RESQUE_WEB_USERNAME"]
  web_password -> ENV["RESQUE_WEB_PASSWORD"]
```

### Generator

Run the generator to optionally add the Capistrano recipe for Resque Front End assets and to add an entry to the Procfile. These steps are only performed if the files are found.

* Invoke the generator:

```
$ rails generate thincloud:resque
```

## Contributing

1. [Fork it](https://github.com/newleaders/thincloud-resque/fork_select)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. [Create a Pull Request](https://github.com/newleaders/thincloud-resque/pull/new)


## License

* Freely distributable and licensed under the [MIT license](http://newleaders.mit-license.org/2012/license.html).
* Copyright (c) 2012 New Leaders ([opensource@newleaders.com](opensource@newleaders.com))
* [https://newleaders.com](https://newleaders.com)

