# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101113145116) do

  create_table "material_actuals", :force => true do |t|
    t.string   "name"
    t.string   "unit"
    t.integer  "availableqty"
    t.integer  "consumptionqty"
    t.integer  "projid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.text     "assetnumber"
    t.text     "description"
    t.text     "capacity"
    t.float    "ifc"
    t.float    "scheduledhour"
    t.float    "unavailablehour"
    t.float    "utilizedhours"
    t.float    "theoreticaloutput"
    t.float    "actualoutput"
    t.float    "theoreticalconsumption"
    t.float    "actualconsumption"
    t.integer  "projid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projectdetails", :force => true do |t|
    t.date     "month"
    t.float    "OriginalBaselinePlan"
    t.float    "LreSite"
    t.float    "LrePmc"
    t.float    "Ac"
    t.float    "PercentageProgress"
    t.integer  "InternalIssues"
    t.integer  "ExternalIssues"
    t.integer  "projid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
