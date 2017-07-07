# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170630042058) do

  create_table "earth_quakes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "time"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.float "depth", limit: 24
    t.float "mag", limit: 24
    t.string "mag_type"
    t.string "nst"
    t.string "gap"
    t.string "dmin"
    t.float "rms", limit: 24
    t.string "net"
    t.string "earth_quake_id"
    t.datetime "updated"
    t.string "place"
    t.string "kind"
    t.string "horizontal_error"
    t.string "depth_error"
    t.string "mag_error"
    t.string "mag_nst"
    t.string "status"
    t.string "location_source"
    t.string "mag_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["earth_quake_id"], name: "index_earth_quakes_on_earth_quake_id"
    t.index ["kind"], name: "index_earth_quakes_on_kind"
    t.index ["latitude"], name: "index_earth_quakes_on_latitude"
    t.index ["longitude"], name: "index_earth_quakes_on_longitude"
    t.index ["mag"], name: "index_earth_quakes_on_mag"
  end

end
