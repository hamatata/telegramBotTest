require 'telegram/bot'

token = '525973003:AAFB6NNZCyYkq8FFHVbLm71dBk7xjb5Y8lg'

Telegram::Bot::Client.run(token) do |bot|
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
