class StatsController < ApplicationController
  def show
    permitted_params = params.permit(:shorten_path)

    @link = Link.find_by(ugly_path: permitted_params[:shorten_path])
    @stats = @link.stats.duration_from(10.days)
    unless @link
      render template: 'errors/link_not_found', layout: 'layouts/application', status: 404
    end
  end
end
