module Haversine

  def decimal_to_radian(decimal)
    decimal * Math::PI / 180
  end

  def sphere_distance_sql(args = {})
    raise "Latitude Longitude and Multilplier are needed" if args[:latitude].blank? || args[:longitude].blank? || args[:multiplier].blank?
    lat = args[ :latitude ] #decimal_to_radian(args[ :latitude ])
    lng = args[ :longitude ] #decimal_to_radian(args[ :longitude ])
    qualified_lat_column_name = :latitude
    qualified_lng_column_name = :longitude
    %|
      (ACOS(least(1,COS(RADIANS(#{lat}))*COS(RADIANS(#{lng}))*COS(RADIANS(#{qualified_lat_column_name}))*COS(RADIANS(#{qualified_lng_column_name}))+
      COS(RADIANS(#{lat}))*SIN(RADIANS(#{lng}))*COS(RADIANS(#{qualified_lat_column_name}))*SIN(RADIANS(#{qualified_lng_column_name}))+
      SIN(RADIANS(#{lat}))*SIN(RADIANS(#{qualified_lat_column_name}))))*#{args[ :multiplier ]}) as distance
     |.gsub("\n", '').strip
  end

end
