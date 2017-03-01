class LinksController < ApplicationController
  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to @link
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      # render "new"
    end
  end
end
