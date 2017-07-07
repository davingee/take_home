class EarthQuake < ApplicationRecord

  extend Haversine

  scope :within_date_range, -> (range) { where("time > ? and time < ?", range[ :start_time ], range[ :end_time ]) }
  # where(time: range[ :start_time ]..range[ :end_time ]) # didn't work for sub select

  def self.view_selects(args = {})
    [ 
      "*",
      sphere_distance_sql(args), 
      "(ifnull(mag,0) * 100) as miles_traveled", 
    ].join(", ").strip
  end

  def self.build_view(args = {})
    self.select(
      view_selects(
        args.slice(:latitude, :longitude, :multiplier)
      )
    ).within_date_range(
      args.slice(:start_time, :end_time)
    ).as( "e" )
  end

  def self.query_view(args = {})
    ## felt as a negative shows how many miles the earthquake went past the coordinates used
    self.from(build_view(args)).select( 
      "e.*, (e.distance - e.miles_traveled) as felt" 
    ).having("felt <= ?", 0).order("felt").limit(10)
  end

  def self.default_start_time
    30.days.ago.to_date.beginning_of_day
  end

  def self.default_end_time
    Date.today.end_of_day
  end

  def city_state
    @city_state ||= place.split("of").last.split(", ") rescue []
  end

  def city
    city_state.try(:first).try(:strip)
  end

  def state
    city_state.try(:last).try(:strip)
  end

end
