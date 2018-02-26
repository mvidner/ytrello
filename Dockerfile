FROM opensuse:42.3
MAINTAINER Knut anderssen "kanderssen@suse.com"

RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
    gcc libxml2-devel libxslt-devel make ruby2.4-devel ruby2.4-rubygem-bundler \
    python-bugzilla ca-certificates gcc-c++ && zypper clean -a

# Set Ruby 2.2 as the default version
RUN ln -sf /usr/bin/ruby.ruby2.4 /usr/local/bin/ruby

RUN mkdir -p /ytrello
WORKDIR /ytrello

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle config --global build.nokogiri "--use-system-libraries"
RUN bundle config --global path "/ytrello/.vendor"
RUN bundler install

COPY . /ytrello/
COPY oscrc /root/.oscrc
