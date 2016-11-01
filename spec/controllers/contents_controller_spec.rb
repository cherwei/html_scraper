require 'rails_helper'

RSpec.describe ContentsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      stub_request(:get, 'http://www.example.com').to_return(
        headers: {},
        status: 200,
        body: sample_response
      )
    end
    
    it 'should create Content' do
      expect do
        post :create, content: {href: 'http://www.example.com'}
      end.to change(Content, :count).by(1)
    end
    
    it 'should rescue SocketError' do
      allow_any_instance_of(Scraper).to receive(:content).and_raise(SocketError)      
      expect do
        post :create, content: {href: 'http://www.example.com'}
      end.to_not raise_error
    end
    
    it 'should rescue Errno::ECONNREFUSED' do
      allow_any_instance_of(Scraper).to receive(:content).and_raise(Errno::ECONNREFUSED)
      expect do
        post :create, content: {href: 'http://www.example.com'}
      end.to_not raise_error
    end
    
    it 'should rescue Errno::ENOENT' do
      allow_any_instance_of(Scraper).to receive(:content).and_raise(Errno::ENOENT)
      expect do
        post :create, content: {href: 'http://www.example.com'}
      end.to_not raise_error
    end
    
    it 'should rescue RuntimeError' do
      allow_any_instance_of(Scraper).to receive(:content).and_raise(RuntimeError)
      expect do
        post :create, content: {href: 'http://www.example.com'}
      end.to_not raise_error
    end
    
    it 'should redirect to root' do
      post :create, content: {href: 'http://www.example.com'}
      expect(response).to redirect_to(root_url)
    end
  end
end
