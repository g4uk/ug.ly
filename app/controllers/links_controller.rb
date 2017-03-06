class LinksController < ApplicationController
  before_action

  def shorten
    permitted_params = params.require(:link).permit(:url)

    @link = Link.find_or_create_by(url_md5: Digest::MD5.hexdigest( permitted_params[:url] )) do |user|
      user.url = permitted_params[:url]
    end
    respond_to do |format|
      if @link.save
        flash[:shorten_link] = @link
        format.html { redirect_to :root, notice: t('.success') }
      else
        format.html { redirect_to :root, alert: @link.errors.messages[:url].first }
      end
    end
  end

  def redirect_permanently
    permitted_params = params.permit(:shorten_path)

    @link = Link.find_by(ugly_path: permitted_params[:shorten_path])
    if @link
      redirect_to @link.url, :status => 301
    else
      render template: 'errors/link_not_found', layout: 'layouts/application', status: 404
    end
  end
end
