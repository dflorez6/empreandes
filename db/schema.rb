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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130423040115) do

  create_table "empresas", :force => true do |t|
    t.string "name"
    t.string "nit"
    t.string "desc"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.string   "bio"
    t.boolean  "admin"
    t.string   "oauth_token"
    t.datetime "oath_expires_at"
    t.string   "uid"
    t.boolean  "fb_connected"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
    t.string   "fb_image_link"
    t.string   "act_code"
    t.boolean  "activated"
    t.integer  "codigo"
    t.string   "programa"
    t.string   "estado"
    t.string   "apellido"
    t.string   "pagweb"
    t.string   "sector"
  end

  add_index "users", ["codigo"], :name => "index_users_on_codigo", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "users_empresas", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "empresa_id"
  end

end
