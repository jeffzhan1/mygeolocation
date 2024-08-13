# Load global configurations
#
config_folder = "#{::Rails.root}/config"

# SERVER_CONFIG
begin
  SERVER_CONFIG = YAML.safe_load(ERB.new(IO.read("#{config_folder}/server_configuration.yml")).result, aliases: true)[Rails.env]
rescue StandardError => e
  puts "Sorry, there was an issue with server_configuration.yml, and it could not be opened:"
  abort e.message
end

