source "http://rubygems.org"

gem "bicho", ">= 0.0.10"

# xmlrpc (required by bicho) has been extracted
# to a separate gem since Ruby 2.4
gem "xmlrpc" if RUBY_VERSION =~ /^2\.[4-9]\./

gem "ruby-trello", "~> 1.3.0"
gem "rainbow", ">= 2.0.0"

# ruby-trello requires activemodel
# activemodel-5 requires ruby-2.2
# but an openSUSE-42.1 installation may have only ruby-2.1
# so let's use an older version
gem "activemodel", "< 5", require: false if RUBY_VERSION.start_with?("2.1.")

group :development do
  gem "rubocop", "0.41.2", require: false
end
