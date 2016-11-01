require 'open-uri'

class Scraper
  attr_accessor :selectors
  
  def initialize(url)
    @url = url
    @selectors = ['h1', 'h2', 'h3']
  end
  
  def content
    @page ||= (
      Nokogiri::HTML(open(@url)) do |config|
        config.strict.nonet.noblanks
      end
    )
    @content ||= parse!(@page)
  end
  
  private
  def parse!(page)
    parse_tags(page) + parse_hrefs(page)
  end
  
  def parse_tags(page)
    page.css(*selectors).map(&:to_html)
  end
  
  def parse_hrefs(page)
    links = page.css("a").select do |a|
      a.get_attribute('href') =~ /\Awww|http/i
    end
    links.map(&:to_html)
  end
end