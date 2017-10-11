# install missing gems using bundler
bundler_dir = File.expand_path("../.vendor", __FILE__)

if !File.exist?(bundler_dir)
  puts "Installing needed Rubygems to #{bundler_dir} ..."
  require "shellwords"
  if !system "bundle install --path #{Shellwords.escape(bundler_dir)}"
    $stderr.puts "Installing the needed Ruby gems failed"
    exit 1
  end
end

require "rubygems"
require "bundler/setup"

require "trello"
require "bicho"
require "yaml"

# Trello board IDs
INC_BOARD_ID = "5507f013b863aa041618871d".freeze # Agile YaST Incoming Board
TEAM_1_BOARD_ID = "5502d5dd8eb45fb4581c1a0f".freeze # Agile YaST: Team 1
TEAM_A_BOARD_ID = "557833ad6be7b9634f089201".freeze # Agile YaST: Team A

# Trello list IDs, see also show_list_ids
CHECKED_LISTS = [
  # Incoming board, keep sorted same as incomming board
  # Backlog Team A
  "5502d691d05c3b3817317566",
  # Backlog Team 1
  "557835b5cb9c13dcd032ecbb",
  # SLE12-SP2 development
  "5538994821027776154180eb",
  # Generic Ideas
  "5507f28d31c1cfac7a83eb72",
  # SLE12-maintenance
  "5507f04f2c885ffbdd53208a",
  # SLE12-SP1 maintenance
  "5502d6719b0d5db70bcf6655",
  # SLE11-maintenance
  "5507f140ab44b6bcfcc6c561",
  # openSUSE
  "550800984de3079fa9ded12a",

  # Team 1 boards
  # Sprint Backlog
  "5577ed07930f16fb224ca248",
  # Doing
  "5502d6b29a7a2ab8025a4c56",

  # Team A boards
  # Sprint Backlog
  "5502d69d3e68ab3d1729337e",
  # Doing
  "557833dde4f1218b7d1cf831"
].freeze

BUGZILLA_URL = "https://bugzilla.suse.com".freeze
BUGZILLA_ACCOUNT = "yast-internal@suse.de".freeze

ENV_TRELLO_KEY = "TRELLO_DEVELOPER_PUBLIC_KEY".freeze
ENV_TRELLO_TOKEN = "TRELLO_MEMBER_TOKEN".freeze

# set the SUSE Bugzilla connection
def setup_bicho
  Bicho.client = Bicho::Client.new(BUGZILLA_URL)
end

# set the Trello credentials
def setup_trello
  fn = "#{ENV["HOME"]}/.config/trello-creds.yml"
  text = File.exist?(fn) ? File.read(fn) : ""
  creds = Hash(YAML.safe_load(text))
  key = ENV[ENV_TRELLO_KEY] || creds[ENV_TRELLO_KEY]
  token = ENV[ENV_TRELLO_TOKEN] || creds[ENV_TRELLO_TOKEN]
  unless key && token
    msg = "Error: Pass the Trello credentials via #{ENV_TRELLO_KEY} and\n" \
          "  #{ENV_TRELLO_TOKEN}, either in #{fn} or in environment variables."
    $stderr.puts msg
    exit 1
  end

  Trello.configure do |config|
    config.developer_public_key = key
    config.member_token = token
  end
end

# Array#to_a -> Trello::MultiAssociation, WTF?!
def to_array(a)
  a.map { |i| i }
end

def debug(s)
  $stderr.puts s if $VERBOSE
end
