class StatsController < ApplicationController
  def show
    permitted_params = params.permit(:shorten_path)

    @link = Link.find_by(ugly_path: permitted_params[:shorten_path])
    @stats = @link.stats.duration_from(10.days)

    @total_clicks = @stats.to_a.count

    @time_chart_data = @stats.group_by_day(:created_at).count
    @referrers_chart_data = @stats.group(:source).count
    @browsers_chart_data = @stats.group(:browser_name).count
    @geo_chart_data = @stats.group(:country).count
    @os_chart_data = @stats.group(:os).count

    render template: 'errors/link_not_found', layout: 'layouts/application', status: 404 unless @link
  end
end
