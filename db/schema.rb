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

ActiveRecord::Schema.define(:version => 20130118183549) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.string   "passport_number"
    t.string   "zagran_passport_number"
    t.date     "zagran_passport_use_before"
    t.string   "degree"
    t.string   "position"
    t.string   "work"
    t.text     "notes"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "company_type"
    t.string   "short_name"
    t.string   "ur_zip_code"
    t.string   "ur_city"
    t.string   "ur_street"
    t.string   "ur_house"
    t.string   "ur_stroenie"
    t.string   "ur_office"
    t.boolean  "ur_post_equal"
    t.string   "post_zip_code"
    t.string   "post_city"
    t.string   "post_street"
    t.string   "post_house"
    t.string   "post_stroenie"
    t.string   "post_office"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "inn"
    t.string   "kpp"
    t.string   "ogrn"
    t.string   "okpo"
    t.string   "okved"
    t.string   "ispolnitel"
    t.string   "osnovanie_ispolnitel"
    t.string   "bank_account"
    t.string   "bank_corr_account"
    t.string   "bank_name"
    t.string   "bank_zip"
    t.string   "bank_city"
    t.string   "bank_street"
    t.string   "bank_house"
    t.string   "bank_stroenie"
    t.string   "bank_office"
    t.string   "bank_bik"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "okato"
  end

  create_table "company_members", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "telephone"
    t.string   "position"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "couriers_companies", :force => true do |t|
    t.string   "name"
    t.string   "zip_code"
    t.string   "city"
    t.string   "street"
    t.string   "house"
    t.string   "stroenie"
    t.string   "office"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "couriers_company_members", :force => true do |t|
    t.string  "name"
    t.integer "couriers_company_id"
    t.string  "telephone"
  end

  create_table "couriers_tasks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.date     "from_date"
    t.date     "to_date"
    t.string   "status"
    t.integer  "from_couriers_company_id"
    t.integer  "to_couriers_company_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "due_time"
    t.integer  "to_couriers_company_member_id"
    t.integer  "from_couriers_company_member_id"
    t.string   "note"
    t.string   "from_couriers_company_class"
    t.string   "to_couriers_company_class"
    t.string   "from_couriers_company_member_class"
    t.string   "to_couriers_company_member_class"
  end

  create_table "documents_beznal_rashods", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "type_company"
    t.string   "company"
    t.string   "description"
    t.string   "name"
    t.string   "telephone"
    t.integer  "num_schet"
    t.date     "date_schet"
    t.integer  "summ"
    t.integer  "nds"
    t.integer  "dogovor_num"
    t.date     "dogovor_date"
    t.boolean  "lectors",              :default => false, :null => false
    t.boolean  "entire",               :default => false, :null => false
    t.integer  "info_pp"
    t.string   "info_schet_factura"
    t.string   "info_act"
    t.date     "info_date_pay"
    t.date     "info_date_schet"
    t.date     "info_date_act"
    t.string   "info_state_act"
    t.date     "info_return_date"
    t.string   "info_type_return_act"
    t.string   "info_name_sender"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "state"
    t.text     "state_note"
  end

  create_table "documents_beznal_schets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "company_id"
    t.string   "description"
    t.string   "name"
    t.string   "telephone"
    t.integer  "num_schet"
    t.date     "date_schet"
    t.integer  "summ"
    t.integer  "nds"
    t.integer  "dogovor_num"
    t.date     "dogovor_date"
    t.date     "payment_date"
    t.string   "info_schet_factura"
    t.string   "info_act"
    t.date     "info_date_schet"
    t.date     "info_date_act"
    t.string   "info_state_act"
    t.date     "info_return_date"
    t.string   "info_type_return_act"
    t.string   "info_name_sender"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "state"
    t.text     "state_note"
  end

  create_table "documents_nal_prihods", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "company"
    t.string   "description"
    t.string   "name"
    t.string   "telephone"
    t.integer  "summ"
    t.date     "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "state"
    t.text     "state_note"
  end

  create_table "documents_nal_rashods", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "company"
    t.string   "description"
    t.string   "name"
    t.string   "telephone"
    t.integer  "summ"
    t.date     "date"
    t.boolean  "lectors",     :default => false, :null => false
    t.boolean  "entire",      :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "state"
    t.text     "state_note"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "company_id"
    t.date     "date_start"
    t.date     "date_end"
    t.string   "city"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "archived",   :default => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  add_index "roles", ["name"], :name => "index_roles_names", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.integer  "salary"
    t.integer  "percent",                :limit => 2
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id", :unique => true

end
