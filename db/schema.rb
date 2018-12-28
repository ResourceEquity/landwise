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

ActiveRecord::Schema.define(version: 2018_11_16_235749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "guide_id"
    t.string "title"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id"], name: "index_articles_on_guide_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "countries", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guide_countries", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id", "guide_id"], name: "index_guide_countries_on_country_id_and_guide_id"
    t.index ["country_id"], name: "index_guide_countries_on_country_id"
    t.index ["guide_id", "country_id"], name: "index_guide_countries_on_guide_id_and_country_id"
    t.index ["guide_id"], name: "index_guide_countries_on_guide_id"
  end

  create_table "guide_subjects", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id", "subject_id"], name: "index_guide_subjects_on_guide_id_and_subject_id"
    t.index ["guide_id"], name: "index_guide_subjects_on_guide_id"
    t.index ["subject_id", "guide_id"], name: "index_guide_subjects_on_subject_id_and_guide_id"
    t.index ["subject_id"], name: "index_guide_subjects_on_subject_id"
  end

  create_table "guide_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id", "user_id"], name: "index_guide_users_on_guide_id_and_user_id"
    t.index ["guide_id"], name: "index_guide_users_on_guide_id"
    t.index ["user_id", "guide_id"], name: "index_guide_users_on_user_id_and_guide_id"
    t.index ["user_id"], name: "index_guide_users_on_user_id"
  end

  create_table "guides", force: :cascade do |t|
    t.string "title"
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_errors", force: :cascade do |t|
    t.string "message"
    t.string "field"
    t.integer "line"
    t.text "trace"
    t.text "row"
    t.bigint "import_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import_id"], name: "index_import_errors_on_import_id"
  end

  create_table "imports", force: :cascade do |t|
    t.integer "total", default: 0
    t.integer "complete", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_imports_on_user_id"
  end

  create_table "item_languages", force: :cascade do |t|
    t.bigint "language_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "language_id"], name: "index_item_languages_on_item_id_and_language_id"
    t.index ["item_id"], name: "index_item_languages_on_item_id"
    t.index ["language_id", "item_id"], name: "index_item_languages_on_language_id_and_item_id"
    t.index ["language_id"], name: "index_item_languages_on_language_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "record_id"
    t.string "title"
    t.integer "year"
    t.text "description"
    t.string "url"
    t.integer "position"
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_items_on_record_id"
  end

  create_table "jurisdictions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.integer "code"
    t.text "stdout"
    t.text "stderr"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_links_on_resource_type_and_resource_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.boolean "show_in_menu", default: false
    t.text "body"
    t.string "keywords"
    t.string "description"
    t.string "slug"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "record_countries", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id", "record_id"], name: "index_record_countries_on_country_id_and_record_id"
    t.index ["country_id"], name: "index_record_countries_on_country_id"
    t.index ["record_id", "country_id"], name: "index_record_countries_on_record_id_and_country_id"
    t.index ["record_id"], name: "index_record_countries_on_record_id"
  end

  create_table "record_topics", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id", "topic_id"], name: "index_record_topics_on_record_id_and_topic_id"
    t.index ["record_id"], name: "index_record_topics_on_record_id"
    t.index ["topic_id", "record_id"], name: "index_record_topics_on_topic_id_and_record_id"
    t.index ["topic_id"], name: "index_record_topics_on_topic_id"
  end

  create_table "record_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id", "user_id"], name: "index_record_users_on_record_id_and_user_id"
    t.index ["record_id"], name: "index_record_users_on_record_id"
    t.index ["user_id", "record_id"], name: "index_record_users_on_user_id_and_record_id"
    t.index ["user_id"], name: "index_record_users_on_user_id"
  end

  create_table "records", force: :cascade do |t|
    t.string "title"
    t.string "creator"
    t.text "description"
    t.boolean "published", default: true
    t.string "author"
    t.string "notes"
    t.bigint "category_id"
    t.bigint "jurisdiction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_records_on_category_id"
    t.index ["jurisdiction_id"], name: "index_records_on_jurisdiction_id"
  end

  create_table "redirects", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from"], name: "index_redirects_on_from", unique: true
  end

  create_table "responsibilities", force: :cascade do |t|
    t.string "title"
    t.boolean "locked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responsibility_records", force: :cascade do |t|
    t.bigint "responsibility_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id", "responsibility_id"], name: "index_responsibility_records_on_record_id_and_responsibility_id"
    t.index ["record_id"], name: "index_responsibility_records_on_record_id"
    t.index ["responsibility_id", "record_id"], name: "index_responsibility_records_on_responsibility_id_and_record_id"
    t.index ["responsibility_id"], name: "index_responsibility_records_on_responsibility_id"
  end

  create_table "responsibility_users", force: :cascade do |t|
    t.bigint "responsibility_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["responsibility_id", "user_id"], name: "index_responsibility_users_on_responsibility_id_and_user_id"
    t.index ["responsibility_id"], name: "index_responsibility_users_on_responsibility_id"
    t.index ["user_id", "responsibility_id"], name: "index_responsibility_users_on_user_id_and_responsibility_id"
    t.index ["user_id"], name: "index_responsibility_users_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "article_id"
    t.string "title"
    t.text "body"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_sections_on_article_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "user_id"], name: "index_user_categories_on_category_id_and_user_id"
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id", "category_id"], name: "index_user_categories_on_user_id_and_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_countries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id", "user_id"], name: "index_user_countries_on_country_id_and_user_id"
    t.index ["country_id"], name: "index_user_countries_on_country_id"
    t.index ["user_id", "country_id"], name: "index_user_countries_on_user_id_and_country_id"
    t.index ["user_id"], name: "index_user_countries_on_user_id"
  end

  create_table "user_favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id", "user_id"], name: "index_user_favorites_on_record_id_and_user_id"
    t.index ["record_id"], name: "index_user_favorites_on_record_id"
    t.index ["user_id", "record_id"], name: "index_user_favorites_on_user_id_and_record_id"
    t.index ["user_id"], name: "index_user_favorites_on_user_id"
  end

  create_table "user_jurisdictions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "jurisdiction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jurisdiction_id", "user_id"], name: "index_user_jurisdictions_on_jurisdiction_id_and_user_id"
    t.index ["jurisdiction_id"], name: "index_user_jurisdictions_on_jurisdiction_id"
    t.index ["user_id", "jurisdiction_id"], name: "index_user_jurisdictions_on_user_id_and_jurisdiction_id"
    t.index ["user_id"], name: "index_user_jurisdictions_on_user_id"
  end

  create_table "user_languages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id", "user_id"], name: "index_user_languages_on_language_id_and_user_id"
    t.index ["language_id"], name: "index_user_languages_on_language_id"
    t.index ["user_id", "language_id"], name: "index_user_languages_on_user_id_and_language_id"
    t.index ["user_id"], name: "index_user_languages_on_user_id"
  end

  create_table "user_topics", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id", "user_id"], name: "index_user_topics_on_topic_id_and_user_id"
    t.index ["topic_id"], name: "index_user_topics_on_topic_id"
    t.index ["user_id", "topic_id"], name: "index_user_topics_on_user_id_and_topic_id"
    t.index ["user_id"], name: "index_user_topics_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "contact"
    t.string "title"
    t.boolean "author", default: false
    t.text "bio"
    t.integer "notification_interval", default: 0
    t.datetime "last_notified", default: -> { "(CURRENT_TIMESTAMP - '31 days'::interval)" }
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "voltron_notification_email_notifications", force: :cascade do |t|
    t.string "to"
    t.string "from"
    t.string "subject"
    t.string "template_path"
    t.string "template_name"
    t.string "mailer_class"
    t.string "mailer_method"
    t.text "request_json"
    t.text "response_json"
    t.integer "notification_id"
  end

  create_table "voltron_notification_sms_notification_attachments", force: :cascade do |t|
    t.integer "sms_notification_id"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voltron_notification_sms_notifications", force: :cascade do |t|
    t.string "to"
    t.string "from"
    t.text "message"
    t.text "request_json"
    t.text "response_json"
    t.integer "notification_id"
    t.string "status"
    t.string "sid"
    t.string "error_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sid"], name: "index_voltron_notification_sms_notifications_on_sid", unique: true
  end

  create_table "voltron_notifications", force: :cascade do |t|
    t.string "notifyable_type"
    t.integer "notifyable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "articles", "guides"
  add_foreign_key "guide_countries", "countries"
  add_foreign_key "guide_countries", "guides"
  add_foreign_key "guide_subjects", "guides"
  add_foreign_key "guide_subjects", "subjects"
  add_foreign_key "guide_users", "guides"
  add_foreign_key "guide_users", "users"
  add_foreign_key "import_errors", "imports"
  add_foreign_key "imports", "users"
  add_foreign_key "item_languages", "items"
  add_foreign_key "item_languages", "languages"
  add_foreign_key "items", "records"
  add_foreign_key "record_countries", "countries"
  add_foreign_key "record_countries", "records"
  add_foreign_key "record_topics", "records"
  add_foreign_key "record_topics", "topics"
  add_foreign_key "record_users", "records"
  add_foreign_key "record_users", "users"
  add_foreign_key "records", "categories"
  add_foreign_key "records", "jurisdictions"
  add_foreign_key "responsibility_records", "records"
  add_foreign_key "responsibility_records", "responsibilities"
  add_foreign_key "responsibility_users", "responsibilities"
  add_foreign_key "responsibility_users", "users"
  add_foreign_key "sections", "articles"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_countries", "countries"
  add_foreign_key "user_countries", "users"
  add_foreign_key "user_favorites", "records"
  add_foreign_key "user_favorites", "users"
  add_foreign_key "user_jurisdictions", "jurisdictions"
  add_foreign_key "user_jurisdictions", "users"
  add_foreign_key "user_languages", "languages"
  add_foreign_key "user_languages", "users"
  add_foreign_key "user_topics", "topics"
  add_foreign_key "user_topics", "users"
end
