namespace :update do

  task :earth_quakes => :environment do

    # used to check if id exists and if updated is == to the csv row
    ids_and_updated = EarthQuake.select(:earth_quake_id, :updated).each_with_object({ }) do |row, hash|
      hash[ row.earth_quake_id ] = row.updated.getutc
    end

    CSV.parse(HTTParty.get(
      'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv'
    ).body, headers: true) do |row|
      next if ids_and_updated[ row[ 'id' ] ].to_s == DateTime.parse(row[ 'updated' ]).getutc.to_s

      earth_quake = EarthQuake.find_or_initialize_by(earth_quake_id: row[ 'id' ], kind: row[ 'type' ])

      earth_quake.assign_attributes(
        row.to_hash.except('id', 'type').each_with_object({ }) do |kev_value, output|
          output[ kev_value[ 0 ].underscore ] = kev_value[ 1 ]
        end
      )

      earth_quake.save if earth_quake.changed?

    end

  end

end