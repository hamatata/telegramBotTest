require './bot_dependencies'

# TODO: move this to some Utils method (e.g. FileUtils::read_config)
config = JSON.parse(File.read('config.json')) # read config.json

# TODO: move to methods of some Bot custom operations
page_html = Nokogiri::HTML(open(config['basecamp_url'])) # => Nokogiri::HTML::Document
all_news = page_html.css('.news-card').map { |news_card| NewsCard.new(news_card) }
all_news.each {|card| puts "Title: #{card.title}\nLink: #{card.link}\n"}

# TODO in Bot menu:
# Show all news
# Show only BaseCamp news
  # Show 1, 2, 3 etc. page
# TODO for deploying (later)
# use Heroku

exit
Telegram::Bot::Client.run(config['bot_token']) do |bot|
  bot.listen do |message|
    chat_id = message.chat.id
    user_name = message.from.first_name
    case message.text
      when '/start'
        bot.api.send_message(chat_id: chat_id, text: "Hello, #{user_name}")
      when '/stop'
        bot.api.send_message(chat_id: chat_id, text: "Bye, #{user_name}")
    end
  end
end
