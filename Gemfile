source "http://rubygems.org"

gem "bicho", ">= 0.0.10"

# xmlrpc (required by bicho) has been extracted
# to a separate gem since Ruby 2.4
if RUBY_VERSION =~ /^2\.[4-9]\./
  gem "xmlrpc"
end

gem "ruby-trello", "~> 1.3.0"
gem "rainbow", ">= 2.0.0"

# ruby-trello requires activemodel
# activemodel-5 requires ruby-2.2
# but an openSUSE-42.1 installation may have only ruby-2.1
# so let's use an older version
if RUBY_VERSION.start_with?("2.1.")
  gem "activemodel", "< 5", require: false
end

group :development do
  gem "rubocop", "~> 0.29.1", require: false
end
