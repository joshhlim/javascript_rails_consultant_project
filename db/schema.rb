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

ActiveRecord::Schema.define(version: 20140626195343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "default_requirements", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "requirement_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["requirement_item_id"], name: "index_default_requirements_on_requirement_item_id", using: :btree
    t.index ["service_id", "requirement_item_id"], name: "index_default_service_requirements_unique", unique: true, using: :btree
    t.index ["service_id"], name: "index_default_requirements_on_service_id", using: :btree
  end

  create_table "feature_requests", force: :cascade do |t|
    t.integer  "feature_id"
    t.integer  "user_id"
    t.boolean  "is_guest"
    t.string   "ip_address"
    t.string   "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["feature_id"], name: "index_feature_requests_on_feature_id", using: :btree
    t.index ["user_id"], name: "index_feature_requests_on_user_id", using: :btree
  end

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intervals", force: :cascade do |t|
    t.integer  "first_service_miles"
    t.integer  "interval_miles"
    t.integer  "interval_months"
    t.boolean  "is_inactive",         default: false
    t.boolean  "is_deleted",          default: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "replaced_id"
    t.integer  "replaced_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "makes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_makes_on_name", unique: true, using: :btree
  end

  create_table "microposts", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
  end

  create_table "model_year_service_interval_votes", force: :cascade do |t|
    t.integer  "model_year_service_id"
    t.integer  "user_id"
    t.integer  "vote_type_id"
    t.boolean  "is_guest"
    t.string   "ip_address"
    t.string   "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["model_year_service_id"], name: "index_mysiv_on_mys_id", using: :btree
    t.index ["user_id"], name: "index_mysiv_on_user_id", using: :btree
  end

  create_table "model_year_service_requirement_votes", force: :cascade do |t|
    t.integer  "model_year_service_requirement_id"
    t.integer  "user_id"
    t.integer  "vote_type_id"
    t.boolean  "is_guest"
    t.string   "ip_address"
    t.string   "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_year_service_requirements", force: :cascade do |t|
    t.integer  "requirement_item_id"
    t.integer  "model_year_service_id"
    t.integer  "requirement_category_id"
    t.integer  "quantity"
    t.string   "quantity_unit"
    t.integer  "user_confirmations"
    t.integer  "visitor_confirmations"
    t.integer  "user_rejections"
    t.integer  "visitor_rejections"
    t.integer  "user_optionals"
    t.integer  "visitor_optionals"
    t.text     "notes"
    t.integer  "substitute_requirement_item_id"
    t.integer  "net_confirmations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "needs_detail",                   default: false
    t.boolean  "needs_quantity",                 default: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "is_deleted",                     default: false
    t.boolean  "is_inactive",                    default: false
    t.integer  "replaced_id"
    t.integer  "replaced_by_id"
    t.index ["model_year_service_id", "requirement_category_id", "requirement_item_id", "quantity", "quantity_unit"], name: "index_model_year_service_requirements_unique", using: :btree
    t.index ["model_year_service_id"], name: "index_model_year_service_requirements_on_model_year_service_id", using: :btree
    t.index ["requirement_category_id"], name: "index_mysr_on_requirement_category_id", using: :btree
    t.index ["requirement_item_id"], name: "index_model_year_service_requirements_on_requirement_item_id", using: :btree
  end

  create_table "model_year_service_specifications", force: :cascade do |t|
    t.integer  "model_year_service_id"
    t.integer  "specification_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "is_deleted",            default: false
    t.boolean  "is_inactive",           default: false
    t.integer  "replaced_id"
    t.integer  "replaced_by_id"
    t.index ["model_year_service_id", "specification_id"], name: "index_model_year_service_specifications_unique", unique: true, using: :btree
    t.index ["model_year_service_id"], name: "index_myss_on_mys_id", using: :btree
    t.index ["specification_id"], name: "index_myss_on_specification_id", using: :btree
  end

  create_table "model_year_service_update_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "model_year_service_id"
    t.boolean  "is_guest"
    t.string   "session_id"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["model_year_service_id"], name: "index_mysur_on_model_year_service_id", using: :btree
    t.index ["user_id"], name: "index_mysur_on_user_id", using: :btree
  end

  create_table "model_year_service_videos", force: :cascade do |t|
    t.integer  "model_year_service_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["model_year_service_id"], name: "index_model_year_service_videos_on_model_year_service_id", using: :btree
    t.index ["video_id"], name: "index_model_year_service_videos_on_video_id", using: :btree
  end

  create_table "model_year_services", force: :cascade do |t|
    t.integer  "model_year_id"
    t.integer  "service_id"
    t.integer  "touch_count"
    t.integer  "view_count"
    t.string   "video_url"
    t.string   "mechanic_search_string"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_year_service_update_requests_count", default: 0
    t.integer  "interval_id"
  end

  create_table "model_year_update_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "model_year_id"
    t.boolean  "is_guest"
    t.string   "session_id"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["model_year_id"], name: "index_myur_on_model_year_id", using: :btree
    t.index ["user_id"], name: "index_myur_on_user_id", using: :btree
  end

  create_table "model_years", force: :cascade do |t|
    t.integer  "year"
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_year_update_requests_count", default: 0
    t.index ["model_id"], name: "index_model_years_on_model_id", using: :btree
  end

  create_table "models", force: :cascade do |t|
    t.string   "name"
    t.integer  "make_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["make_id", "name"], name: "index_models_on_make_id_and_name", unique: true, using: :btree
    t.index ["make_id"], name: "index_models_on_make_id", using: :btree
  end

  create_table "requirement_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_requirement_categories_on_name", unique: true, using: :btree
  end

  create_table "requirement_items", force: :cascade do |t|
    t.string   "name"
    t.string   "detail"
    t.text     "description"
    t.text     "link_for_sale"
    t.text     "link_for_img"
    t.integer  "substitute_requirement_item_id"
    t.integer  "requirement_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "needs_detail",                   default: false
    t.boolean  "needs_quantity",                 default: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "is_deleted",                     default: false
    t.boolean  "is_inactive",                    default: false
    t.integer  "detail_numbers"
    t.string   "detail_characters"
    t.string   "detail_downcase_no_whitespace"
    t.index ["requirement_category_id", "name", "detail"], name: "index_requirement_items_unique", unique: true, using: :btree
    t.index ["requirement_category_id"], name: "index_requirement_items_on_requirement_category_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "popularity"
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action"
    t.string   "item"
    t.string   "item_action_display"
    t.index ["name"], name: "index_services_on_name", unique: true, using: :btree
  end

  create_table "specification_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_quick_spec", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "is_deleted",    default: false
    t.boolean  "is_inactive",   default: false
  end

  create_table "specifications", force: :cascade do |t|
    t.integer  "model_year_id"
    t.integer  "specification_category_id"
    t.string   "single_value_str"
    t.string   "range_start_str"
    t.string   "range_end_str"
    t.boolean  "is_quick_spec",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "is_deleted",                default: false
    t.boolean  "is_inactive",               default: false
    t.integer  "replaced_id"
    t.integer  "replaced_by_id"
    t.index ["model_year_id"], name: "index_specifications_on_model_year_id", using: :btree
    t.index ["specification_category_id"], name: "index_specifications_on_specification_category_id", using: :btree
  end

  create_table "user_requirement_items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "requirement_item_id"
    t.integer  "quantity"
    t.string   "brand"
    t.string   "description"
    t.string   "upc"
    t.string   "asin"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["requirement_item_id"], name: "index_user_requirement_items_on_requirement_item_id", using: :btree
    t.index ["user_id"], name: "index_user_requirement_items_on_user_id", using: :btree
  end

  create_table "user_user_relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followed_id"], name: "index_user_user_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_user_user_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_user_user_relationships_on_follower_id", using: :btree
  end

  create_table "user_vehicles", force: :cascade do |t|
    t.integer  "model_year_id"
    t.integer  "user_id"
    t.string   "name"
    t.integer  "mileage"
    t.string   "image_url"
    t.string   "video_url"
    t.integer  "privacy_id"
    t.integer  "rating"
    t.integer  "views"
    t.integer  "touches"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["model_year_id"], name: "index_user_vehicles_on_model_year_id", using: :btree
    t.index ["user_id"], name: "index_user_vehicles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.string   "external_source"
    t.string   "external_id"
    t.string   "etag"
    t.string   "title"
    t.string   "description"
    t.string   "thumbnail_default_url"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vote_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "specification_id"
    t.integer  "user_id"
    t.integer  "vote_type_id"
    t.boolean  "is_guest"
    t.string   "ip_address"
    t.string   "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_year_service_specification_id"
    t.integer  "video_id"
    t.integer  "interval_id"
    t.index ["interval_id"], name: "index_votes_on_interval_id", using: :btree
    t.index ["model_year_service_specification_id"], name: "index_votes_on_model_year_service_specification_id", using: :btree
    t.index ["specification_id"], name: "index_votes_on_specification_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
    t.index ["video_id"], name: "index_votes_on_video_id", using: :btree
    t.index ["vote_type_id"], name: "index_votes_on_vote_type_id", using: :btree
  end

end
