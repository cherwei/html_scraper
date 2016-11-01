class HomeController < ApplicationController
  def show
    @contents = Content.page(params[:page])
  end
end
