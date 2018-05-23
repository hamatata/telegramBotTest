require 'telegram/bot'
require 'nokogiri'
require 'open-uri'

require './lib/news_card'
require './lib/cities'
require './lib/news'
require './lib/bot_config'

include Cities
BotConfig.init 'config.json'
