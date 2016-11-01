require 'spec_helper'
require 'support/html_response.rb'

describe Scraper do
  before(:each) do
    stub_request(:get, 'http://www.example.com').to_return(
      headers: {},
      status: 200,
      body: sample_response
    )
    
    @scraper = Scraper.new('http://www.example.com')
  end
  
  describe '#content' do
    it 'should return elements' do
      expect(@scraper).to receive(:parse!).once.and_call_original
      expect(@scraper.content).to_not be_blank
    end
  end
  
  describe '#parse_tags' do
    it 'should parse h1, h2 and h3 only' do
      nokogiri = Nokogiri::HTML(sample_response)
      expect(nokogiri).to receive(:css).with('h1', 'h2', 'h3').once.and_call_original
      @scraper.send(:parse_tags, nokogiri)
    end
  end
  
  describe '#parse_hrefs' do
    it 'should parse valid href tag only' do
      reponses = @scraper.send(:parse_hrefs, Nokogiri::HTML(with_invalid_urls_response))
      expect(reponses.size).to eq(1)
      expect(reponses.first).to eq('<a href="http://www.iana.org/domains/example">More information...</a>')
    end
  end
  
  describe '#parse!' do
    it 'should call #parse_tags and #parse_hrefs once' do
      expect(@scraper).to receive(:parse_tags).once.and_call_original
      expect(@scraper).to receive(:parse_hrefs).once.and_call_original
      @scraper.send(:parse!, Nokogiri::HTML(sample_response))
    end
  end
end