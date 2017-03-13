class RedirectsController < ApplicationController
  VISITOR_COOKIES_KEY_PREFIX = :ug_ly

  def redirect_permanently
    permitted_params = params.permit(:shorten_path)

    @link = Link.find_by(ugly_path: permitted_params[:shorten_path])
    if @link
      set_analytics # @todo call .delay
      set_cookies
      redirect_to @link.url, :status => 301
    else
      render template: 'errors/link_not_found', layout: 'layouts/application', status: 404
    end
  end

  private
    def set_analytics
      @link.stats.add request.remote_ip, request.referer, request.user_agent if new_visit?
    end

    def set_cookies
      unless browser.bot?
        unless cookies[ get_cookie_key ].present?
          cookies.permanent[ get_cookie_key ] = SecureRandom.uuid
        end
      end
    end

    def get_cookie_key
      "#{VISITOR_COOKIES_KEY_PREFIX}_#{@link.ugly_path}"
    end

    def new_visit?
      !existing_visit_id
    end

    def existing_visit_id
      request.cookies[ get_cookie_key ]
    end
end
