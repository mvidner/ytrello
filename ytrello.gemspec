require File.expand_path(File.dirname(__FILE__) + "/lib/ytrello/version")

Gem::Specification.new do |s|
  s.name        = "ytrello"
  s.version     = Ytrello::VERSION
  s.summary     = "Tools to help with the YaST Trello boards and Bugzilla"
  s.description = <<TXT
Ytrello are tools to help my Scrum team manage Trello cards and Bugzilla bugs.
Much of the configuration is harcoded now, yuck!
TXT

  s.author      = "Martin Vidner"
  s.email       = "martin@vidner.net"
  s.homepage    = "https://github.com/mvidner/ytrello"
  s.license     = "MIT"

  # ruby -e 'puts `git ls-files`.lines.map { |f| "    %s" % f.strip.inspect }.join ",\n"'
  s.files       = [
    ".gitignore",
    ".rubocop.yml",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "VERSION",
    "bin/ytrello",
    "bin/ytrello-addurl",
    "bin/ytrello-check",
    "bin/ytrello-create",
    "bin/ytrello-reassign",
    "config/trello-creds.yml.template",
    "devel/show_list_ids",
    "lib/ytrello.rb",
    "lib/ytrello/version.rb",
    "ytrello.gemspec"
  ]

  s.executables = s.files.grep(/^bin\//) { |f| File.basename(f) }

  s.requirements << "python-bugzilla >= 2.1.0"

  s.add_dependency "bicho", ">= 0.0.10"
  s.add_dependency "ruby-trello", ">= 1.3.0"
  s.add_dependency "rainbow", ">= 2.0.0"

  s.add_development_dependency "rubocop", "0.50.0"
end
