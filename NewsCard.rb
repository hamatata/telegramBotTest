class NewsCard

  attr_reader :news_card
  attr_accessor :text, :title, :link


  # @param [Nokogiri::XML::Node] news_card
  def initialize(news_card)
    @news_card = news_card
    @text = news_card.text
    @title = news_card.css('.news-card-title').text
    @link = news_card['href']
  end

end