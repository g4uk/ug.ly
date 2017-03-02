class LinksController < ApplicationController
  before_action

  def shorten
    @link = Link.shorten(link_params)
    respond_to do |format|
      if @link.save
        format.html { redirect_to :root, notice: t('.success') }
      else
        format.html { redirect_to :root, alert: @link.errors.messages[:url].first }
      end
    end
  end

  private
    def link_params
      params.require(:link).permit(:url)
    end
end
