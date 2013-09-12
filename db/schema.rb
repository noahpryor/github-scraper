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

ActiveRecord::Schema.define(version: 20130911061637) do

  create_table "gemfiles", force: true do |t|
    t.integer  "repository_id"
    t.text     "url"
    t.text     "contents"
    t.datetime "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", force: true do |t|
    t.text     "repository_url"
    t.datetime "last_created"
    t.text     "owner_name"
    t.datetime "first_created"
    t.integer  "repo_size"
    t.datetime "repository_created"
    t.integer  "watchers"
    t.text     "forks"
    t.text     "last_push"
    t.integer  "feed_hits"
    t.boolean  "has_gemfile"
    t.text     "gemfile_contents"
    t.datetime "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repositories", ["repository_url"], name: "index_repositories_on_repository_url", using: :btree

  create_table "ruby_commits", id: false, force: true do |t|
    t.string   "repository_url",     null: false
    t.datetime "last_created",       null: false
    t.datetime "first_created",      null: false
    t.integer  "repo_size",          null: false
    t.datetime "repository_created", null: false
    t.integer  "watchers",           null: false
    t.integer  "forks",              null: false
    t.datetime "last_push",          null: false
    t.integer  "feed_hits",          null: false
  end

end
