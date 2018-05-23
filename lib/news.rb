# require './lib/bot_config'

# Place for all news cards and manipulations with them
module News
  attr_reader :all_news, :kyiv_news

  def self.kyiv_news
    @kyiv_news ||= []
    @kyiv_news = news_for_city(Cities::KYIV) if @kyiv_news.empty?
    @kyiv_news
  end

  def self.add_news_card(news_card)
    @all_news.push(news_card)
  end

  def self.all
    @all_news ||= []
  end

  def self.collect_all_news_from_site
    page_html = Nokogiri::HTML(open(BotConfig.basecamp_url))
    page_html.css('.news-card').map do |news_card|
      all.push NewsCard.new(news_card)
    end
  end

  def self.news_for_city(city)
    puts "Filtering news for #{city.first}"
    collect_all_news_from_site if all.empty?
    all.select do |news_card|
      news_card.for_city? city
    end
  end

end
