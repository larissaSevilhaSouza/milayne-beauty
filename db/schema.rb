# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_01_14_143738) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", force: :cascade do |t|
    t.string "sumary"
    t.string "text"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adjustments", force: :cascade do |t|
    t.string "phone"
    t.string "adress"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adsenses", force: :cascade do |t|
    t.string "title"
    t.integer "ad_type"
    t.text "script"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "album_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.datetime "date_publish"
    t.text "description"
    t.string "slug"
    t.boolean "featured", default: false
    t.bigint "album_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_category_id"], name: "index_albums_on_album_category_id"
  end

  create_table "albums_posts", id: false, force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "post_id", null: false
    t.index ["album_id", "post_id"], name: "index_album_post"
    t.index ["post_id", "album_id"], name: "index_post_album"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "banners", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "link"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "format_ad_id"
    t.boolean "status"
    t.string "code_slot_adsense"
    t.string "code_client_adsense"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.string "file_ad"
    t.string "video"
    t.integer "category"
    t.index ["format_ad_id"], name: "index_banners_on_format_ad_id"
  end

  create_table "category_fonts", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
  end

  create_table "font_primaries", force: :cascade do |t|
    t.bigint "category_font_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_font_id"], name: "index_font_primaries_on_category_font_id"
  end

  create_table "font_secondaries", force: :cascade do |t|
    t.bigint "category_font_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_font_id"], name: "index_font_secondaries_on_category_font_id"
  end

  create_table "format_ads", force: :cascade do |t|
    t.string "title"
    t.string "width"
    t.string "height"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gallery_oxes", force: :cascade do |t|
    t.string "photo"
    t.bigint "oxoplastium_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oxoplastium_id"], name: "index_gallery_oxes_on_oxoplastium_id"
  end

  create_table "item_stories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "category_stores_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_stores_id"], name: "index_item_stories_on_category_stores_id"
  end

  create_table "link_tops", force: :cascade do |t|
    t.string "icon"
    t.string "link"
    t.string "name"
    t.boolean "new_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.boolean "active"
    t.boolean "active_link"
    t.boolean "active_sub_menu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordem"
  end

  create_table "oxoplastia", force: :cascade do |t|
    t.string "photo"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "photo_itens", force: :cascade do |t|
    t.string "photo"
    t.bigint "item_stories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_stories_id"], name: "index_photo_itens_on_item_stories_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "image"
    t.boolean "cover", default: false
    t.bigint "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_photos_on_album_id"
  end

  create_table "post_categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_post_categories_on_slug", unique: true
  end

  create_table "post_images", force: :cascade do |t|
    t.string "url"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_images_on_post_id"
  end

  create_table "post_views", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_post_views_on_created_at"
    t.index ["post_id"], name: "index_post_views_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "written_by"
    t.string "source"
    t.string "cover"
    t.string "slug"
    t.datetime "date_publish"
    t.text "content"
    t.boolean "featured", default: false
    t.boolean "is_published", default: false
    t.bigint "post_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date_publish"], name: "index_posts_on_date_publish"
    t.index ["post_category_id"], name: "index_posts_on_post_category_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "schedule_your_appointments", force: :cascade do |t|
    t.string "photo"
    t.string "description"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_colors", force: :cascade do |t|
    t.string "primary", default: "#FFFFFF"
    t.string "sencondary", default: "#FFFFFF"
    t.string "terciary", default: "#FFFFFF"
    t.string "logo_header"
    t.string "logo_footer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_media", force: :cascade do |t|
    t.string "facebook"
    t.string "instagram"
    t.string "whatsapp"
    t.text "insta_show"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "text"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_menus", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.boolean "new_page"
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_sub_menus_on_menu_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.boolean "admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.datetime "date_publish"
    t.string "url"
    t.string "description"
    t.string "slug"
    t.boolean "featured", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "albums", "album_categories"
  add_foreign_key "banners", "format_ads"
  add_foreign_key "font_primaries", "category_fonts"
  add_foreign_key "font_secondaries", "category_fonts"
  add_foreign_key "gallery_oxes", "oxoplastia"
  add_foreign_key "item_stories", "category_stores", column: "category_stores_id"
  add_foreign_key "permissions", "users"
  add_foreign_key "photo_itens", "item_stories", column: "item_stories_id"
  add_foreign_key "photos", "albums"
  add_foreign_key "post_images", "posts"
  add_foreign_key "post_views", "posts"
  add_foreign_key "posts", "post_categories"
  add_foreign_key "sub_menus", "menus"
end
