class PageController < ApplicationController
  def index
    @link = Link.new
  end
end
