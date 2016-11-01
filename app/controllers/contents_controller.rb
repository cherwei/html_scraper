class ContentsController < ApplicationController
  def create
    scraper = Scraper.new(params[:content][:href])
    begin
      content = scraper.content.try(:to_s)
    rescue RuntimeError, Errno::ENOENT, Errno::ECONNREFUSED, SocketError => e
      flash[:error] = "Invalid URL"
    else
      Content.create(href: params[:content][:href], content: content)
    end
    redirect_to root_url
  end
  
  protected
  def content_params
    params.require(:content).permit(:href)
  end
end
