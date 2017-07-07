class EarthQuakesController < ApplicationController

  def index
    params[:start_date] = start_time.to_date
    params[:end_date]   = end_time.to_date
    @earth_quakes = EarthQuake.query_view(
      location.merge( start_time: start_time, end_time: end_time )
    )
  end

  private

    def location
      {
        latitude:   params.fetch(:latitude,   34.0522),
        longitude:  params.fetch(:longitude,  -118.2437),
        multiplier: params.fetch(:multiplier, 6334)
      }
    end

    def start_time
      @start_date ||= params[ :start_date ] ? Date.parse(
        params[ :start_date ]
      ).beginning_of_day : EarthQuake.default_start_time
    end

    def end_time
      @end_date   ||= params[ :end_date ] ? Date.parse(
        params[ :end_date ]
      ).end_of_day : EarthQuake.default_end_time
    end

end
