source "http://rubygems.org"

# on openSUSE-42.3, which has /usr/bin/ruby -> ruby-2.1, use
#  bundler.ruby2.4 install
#  ruby.ruby2.4 $ytrello_tool

# implied by xmlrpc (required by bicho), but it's better to state it upfront
ruby "2.4.1" # argh, ">=2.4" does not work

gem "bicho", ">= 0.0.10"
gem "ruby-trello", "~> 1.3.0"
gem "rainbow", ">= 2.0.0"

group :development do
  gem "rubocop", "0.41.2", require: false
end
