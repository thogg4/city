# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20120619141927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "body"
    t.text     "footer"
    t.text     "notes"
    t.integer  "article_status_id"
    t.integer  "site_id"
    t.string   "author"
    t.string   "tags"
    t.string   "permalink"
    t.datetime "published_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "includes", force: true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "layouts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "site_id"
    t.string   "redis_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "path"
    t.text     "body"
    t.integer  "site_id"
    t.integer  "layout_id"
    t.string   "redis_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "renders", force: true do |t|
    t.integer  "renderable_id"
    t.string   "renderable_type"
    t.text     "render"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.string   "title"
    t.string   "domain"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

end
