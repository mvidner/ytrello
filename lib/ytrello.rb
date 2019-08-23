require "trello"
require "bicho"
require "yaml"

# Trello board IDs
INC_BOARD_ID = "5507f013b863aa041618871d".freeze # Agile YaST Incoming Board
TEAM_1_BOARD_ID = "5502d5dd8eb45fb4581c1a0f".freeze # Agile YaST: Team 1
TEAM_A_BOARD_ID = "557833ad6be7b9634f089201".freeze # Agile YaST: Team A
TEAM_S_NO_SCRUM = "5a55d35ca6cb8d380b5a6f37".freeze # Agile YaST: Team S no Scrum

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
