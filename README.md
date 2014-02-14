# WebUpdateChecker

[![Build Status](https://travis-ci.org/matsubo/web_update_checker.png?branch=master)](https://travis-ci.org/matsubo/web_update_checker)

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
url = 'http://matsu.teraren.com/blog/'

regex = /<h1>(.*)<\/h1>/

mail = Mail.new do
from    'TODO@example.com'
to      'TODO@example.com'
subject 'Web site is updated!'
body     @url
end

mail.delivery_method :smtp, {
address:   'localhost',
             port:      25,
}


url = 'http://example.com/'
WebUpdateChecker::Checker.new(url, regex, mail).execute
```


Execute like a following CLI
```
% while [ true ]; do; ruby main.rb; sleep 30; done
```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/web_update_checker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
