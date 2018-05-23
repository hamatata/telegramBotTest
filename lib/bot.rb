require_relative './bot_dependencies'

# puts "We have '#{News.all.size}' news in total."
# puts "About Kyiv we have '#{News.kyiv_news}' news."
# TODO: in Bot menu:
# Show all news
# Show only BaseCamp news
# Show 1, 2, 3 etc. page
# TODO for deploying (later)
# use Heroku
# TODO: add database for all news? :)

# def kyiv_first_answer
#   puts 'Preparing to show first kyiv news cards titles...'
#   puts "We have #{News.kyiv_news.size} news"
#   if News.kyiv_news.size > 3
#     puts '> 3 => nice :)'
#   else
#     puts '< 3 => nice :('
#   end
#   puts News.kyiv_news[0..2].map(&:title).join("\n")
#   News.kyiv_news[0..2].map(&:title).join("\n")
# end
#
# News.kyiv_news
# kyiv_first_answer
#
# exit


Telegram::Bot::Client.run(BotConfig.bot_token) do |bot|
  puts 'Bot is started and listening to you...'

  def show_help(bot, chat_id)
    help_text = File.read('help_text.txt')
    bot.api.send_message(chat_id: chat_id, text: help_text)
  end

  def kyiv_first_answer
    # News.kyiv_news[0..2].map(&:title).join("\n")
    news_output = News.kyiv_news[0..4].each_with_index.map do |news_card, index|
      "/#{index+1}. #{news_card.title}"
    end
    news_output.join("\n")
  end

  bot.listen do |message|
    chat_id = message.chat.id
    user_name = message.from.first_name
    case message.text
    when '/start'
      # bot.api.send_message(chat_id: chat_id, text: "Hello, #{user_name}. I can show you which news we have about BaseCamps in GlobalLogic.\nPlease use /help first")
      show_help(bot, chat_id)
    when '/collect'
      News.collect_all_news_from_site
      bot.api.send_message(chat_id: chat_id, text: "Collected '#{News.all.size}' news in total.")
    when '/kyiv_num'
      bot.api.send_message(chat_id: chat_id, text: "We have '#{News.kyiv_news.size}' news for Kyiv.")
    when '/kyiv_first'
      bot.api.send_message(chat_id: chat_id, text: kyiv_first_answer)
    when '/city'
      bot.api.send_message(chat_id: chat_id, text: 'This functionality is IN PROGRESS...')
    when '/stop'
      bot.api.send_message(chat_id: chat_id, text: "Bye, #{user_name}")
    when '/help'
      show_help(bot, chat_id)


    # when user wants to see Kyiv news_card by index
    when '/boo'
      question = 'London is a capital of which country?'
      keyboard = [%w[Kyiv Kharkiv], %w[Lviv Donetsk]]
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: keyboard, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    when '/stop'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(', reply_markup: kb)
    when '/dev'
      bot.api.send_message(chat_id: chat_id, text: "/boo\n/ask\n/")
    when '/ask'
      kb = [
        Telegram::Bot::Types::KeyboardButton.new(text: 'Give me your phone number', request_contact: true),
        Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)
      ]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: 'Hey!', reply_markup: markup)
    else
      if message.text =~ /\/\d+/
        bot.api.send_message(chat_id: chat_id, text: "You sent message: #{message.text}")
        new_card_number = message.text[1..-1].to_i - 1
        bot.api.send_message(chat_id: chat_id, text: News.kyiv_news[new_card_number].link)
      else
        bot.api.send_message(chat_id: chat_id, text: "#{user_name}, WAT? Please read /help :)")
      end
    end
  end
end
