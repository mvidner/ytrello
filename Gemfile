source "http://rubygems.org"

gem "bicho", ">= 0.0.10"
gem "ruby-trello", "~> 1.3.0"
gem "rainbow", ">= 2.0.0"
# ruby-trello requires activemodel
# activemodel-5 requires ruby-2.2
# but an openSUSE-42.1 installation may have only ruby-2.1
# so let's use an older version
gem "activemodel", "< 5", require: false

group :development do
  gem "rubocop", "~> 0.29.1", require: false
end
