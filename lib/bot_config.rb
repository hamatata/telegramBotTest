# Config module
module BotConfig

  attr_reader :all, :bot_token, :bot_name, :basecamp_url

  # Read and parse config.json
  def self.init(config_path)
    @all = JSON.parse(File.read(config_path))
    @bot_token = @all['bot_token']
    @bot_name = @all['bot_name']
    @basecamp_url = @all['basecamp_url']
  end

  def self.bot_token
    @bot_token
  end

  def self.basecamp_url
    @basecamp_url
  end

end