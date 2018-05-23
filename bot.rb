require './bot_dependencies'

config = JSON.parse(File.read('config.json')) # reading config from config.json file
puts config.inspect

page_html = Nokogiri::HTML(open(config['basecamp_url'])) # => Nokogiri::HTML::Document
all_news = page_html.css('.news-card').map { |news_card| NewsCard.new(news_card) }
all_news.each {|card| puts "Title: #{card.title}\nLink: #{card.link}\n"}

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
