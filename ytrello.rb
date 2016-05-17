# install missing gems using bundler
bundler_dir =  File.expand_path("../.vendor", __FILE__)

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

# Trello board IDs
INC_BOARD_ID  = "5507f013b863aa041618871d" # Agile YaST Incoming Board
TEAM_1_BOARD_ID = "5502d5dd8eb45fb4581c1a0f" # Agile YaST: Team 1
TEAM_A_BOARD_ID = "557833ad6be7b9634f089201" # Agile YaST: Team A

# Trello list IDs, see [*] how to get the IDs
# JR: * not found, so I use in trello method with export to json and there are
# ids of everything
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
  "5507f04ba946797c971ecde3",
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
]

BUGZILLA_URL = "https://bugzilla.suse.com"
BUGZILLA_ACCOUNT = "yast-internal@suse.de"

ENV_TRELLO_KEY = "TRELLO_DEVELOPER_PUBLIC_KEY"
ENV_TRELLO_TOKEN = "TRELLO_MEMBER_TOKEN"

def check_trello_credentials
  return if ENV[ENV_TRELLO_KEY] && ENV[ENV_TRELLO_TOKEN]
  $stderr.puts "Error: Pass the Trello credentials via #{ENV_TRELLO_KEY}" \
  " and\n#{ENV_TRELLO_TOKEN} environment variables."
  exit 1
end

# set the SUSE Bugzilla connection
def setup_bicho
  Bicho.client = Bicho::Client.new(BUGZILLA_URL)
end

# set the Trello credentials
def setup_trello
  Trello.configure do |config|
    config.developer_public_key = ENV[ENV_TRELLO_KEY]
    config.member_token         = ENV[ENV_TRELLO_TOKEN]
  end
end

# Array#to_a -> Trello::MultiAssociation, WTF?!
def to_array(a)
  a.map { |i| i }
end

def debug(s)
  $stderr.puts s if $VERBOSE
end
