require "trello"
require "bicho"
require "yaml"

# Trello board IDs
INC_BOARD_ID = "5507f013b863aa041618871d".freeze # Agile YaST Incoming Board
TEAM_1_BOARD_ID = "5502d5dd8eb45fb4581c1a0f".freeze # Agile YaST: Team 1
TEAM_A_BOARD_ID = "557833ad6be7b9634f089201".freeze # Agile YaST: Team A
TEAM_S_NO_SCRUM = "5a55d35ca6cb8d380b5a6f37".freeze # Agile YaST: Team S no Scrum

# Trello list IDs, see also show_list_ids
CHECKED_LISTS = [
  # Incoming board, keep sorted same as incomming board
  # Backlog Team A
  "5502d691d05c3b3817317566",
  # Backlog Team 1
  "557835b5cb9c13dcd032ecbb",
  # SLE15 development
  "5952060e0e9190605c75863e",
  # SLE15 Storage development
  "59a3db0f0fac7c99d1808ae9",
  # SLE12-SP3 maintenance"
  "57cfdbcc9ae10f3d1fb996d3",
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
  "557833dde4f1218b7d1cf831",

  # Team S No SCRUM
  # Incoming Backlog (storage-ng)
  "5502d691d05c3b3817317566",
  # Incoming backlog (other)
  "5a86c1c40f43d52085c37808",
  # Current Backlog
  "56b1c34524d3a3599234affb",
  # Doing
  "557833dde4f1218b7d1cf831",
  # Done
  "5a26d54ecd9e0bb490360204"
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
