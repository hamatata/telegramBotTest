# Class represents News Card object on the 'GL BaseCamp' page
class NewsCard
  attr_accessor :text, :title, :link

  # @param [Nokogiri::XML::Node] news_card
  def initialize(news_card)
    @news_card = news_card
    @text = news_card.text
    @title = news_card.css('.news-card-title').text.delete("\n").strip
    @link = news_card['href']
  end

  # @returns [boolean] true if news_card is about specified city
  def for_city?(city_name_forms)
    match_results = city_name_forms.collect do |city|
      @title.downcase =~ Regexp.compile(city.downcase)
    end
    !match_results.compact.empty?
  end
end
