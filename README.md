# WebUpdateChecker

[![Build Status](https://travis-ci.org/matsubo/web_update_checker.png?branch=master)](https://travis-ci.org/matsubo/web_update_checker)
[![Code Climate](https://codeclimate.com/repos/52fe140a6956801926004d67/badges/30ffdfe2a271ee8955b9/gpa.png)](https://codeclimate.com/repos/52fe140a6956801926004d67/feed)
[![Gem Version](https://badge.fury.io/rb/web_update_checker.png)](http://badge.fury.io/rb/web_update_checker)

This library polls an URL and notifies if the contents is changed.
This is useful if you want to be notified as soon as a web site contents is changed.

## Installation

Add this line to your application's Gemfile:

    gem 'web_update_checker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install web_update_checker

## Usage


main.rb
```
require 'mail'
require 'web_update_checker'

regex = /<h1>(.*)<\/h1>/
url = 'http://example.com/'

mail = Mail.new do
  from:    'TODO@example.com'
  to:      'TODO@example.com'
  subject: 'Web site is updated!'
  body:     url
end

mail.delivery_method :smtp, {
  address:   'localhost',
  port:      25,
}

WebUpdateChecker::Checker.new(url, regex, mail).execute
```


Execute like a following CLI
```
% while [ true ]; do; ruby main.rb; sleep 30; done
```


## Contributing

1. Fork it ( http://github.com/matsubo/web_update_checker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
