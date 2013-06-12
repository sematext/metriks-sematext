# metriks-sematext[![Build Status](https://travis-ci.org/sematext/metriks-sematext.png?branch=master)](https://travis-ci.org/sematext/metriks-sematext)

[Metriks](https://github.com/eric/metriks) Reporter that uses [sematext-metrics](http://github.com/sematext/sematext-metrics-gem) gem to send metrics to [SPM](http://sematext.com/spm/index.html) as [Custom Metrics](https://sematext.atlassian.net/wiki/display/PUBSPM/Custom+Metrics).

## Installation

Add this line to your application's Gemfile:

    gem 'metriks-sematext'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metriks-sematext

## Usage

Initialize and start reporter.

``` ruby
  reporter = Metriks::Sematext::Reporter.new :interval => 60, :token => "[your-token]"
  reporter.start  
```

## License

Copyright 2013 Sematext Group, Inc.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
