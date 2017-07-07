class CreateEarthQuakes < ActiveRecord::Migration[5.1]
  def change
    create_table :earth_quakes do |t|
      t.datetime :time
      t.float :latitude, index: true
      t.float :longitude, index: true
      t.float :depth
      t.float :mag, index: true
      t.string :mag_type
      t.string :nst
      t.string :gap
      t.string :dmin
      t.float :rms
      t.string :net
      t.string :earth_quake_id, uniq: true, index: true

      t.datetime :updated
      t.string :place
      t.string :kind, index: true

      t.string :horizontal_error
      t.string :depth_error
      t.string :mag_error
      t.string :mag_nst
      t.string :status
      t.string :location_source
      t.string :mag_source

      t.timestamps
    end
  end
end
