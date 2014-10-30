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

ActiveRecord::Schema.define(version: 20141030191208) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenant_id"
  end

  add_index "activities", ["tenant_id"], name: "index_activities_on_tenant_id"

  create_table "assignments", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["task_id"], name: "index_assignments_on_task_id"
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id"

  create_table "categories", force: true do |t|
    t.string  "color"
    t.string  "title"
    t.integer "tenant_id"
  end

  add_index "categories", ["tenant_id"], name: "index_categories_on_tenant_id"

  create_table "channels", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",          default: true
    t.integer  "tenant_id"
    t.string   "slug"
    t.datetime "last_message_at"
    t.integer  "messages_count",  default: 0
  end

  add_index "channels", ["slug"], name: "index_channels_on_slug"
  add_index "channels", ["tenant_id"], name: "index_channels_on_tenant_id"
  add_index "channels", ["title"], name: "index_channels_on_title", unique: true

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ends_at"
    t.boolean  "all_day"
    t.integer  "category_id"
    t.string   "location"
    t.text     "schedule"
    t.integer  "tenant_id"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id"
  add_index "events", ["created_at"], name: "index_events_on_created_at"
  add_index "events", ["tenant_id"], name: "index_events_on_tenant_id"

  create_table "memberships", force: true do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["tenant_id"], name: "index_memberships_on_tenant_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["channel_id"], name: "index_messages_on_channel_id"
  add_index "messages", ["created_at"], name: "index_messages_on_created_at"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenant_id"
    t.boolean  "startpage",  default: false
    t.string   "slug"
  end

  add_index "pages", ["created_at"], name: "index_pages_on_created_at"
  add_index "pages", ["slug"], name: "index_pages_on_slug"
  add_index "pages", ["tenant_id"], name: "index_pages_on_tenant_id"

  create_table "participations", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["event_id"], name: "index_participations_on_event_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "read_marks", force: true do |t|
    t.integer  "readable_id"
    t.integer  "user_id",                  null: false
    t.text     "readable_type", limit: 20, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], name: "index_read_marks_on_user_id_and_readable_type_and_readable_id"

  create_table "settings", force: true do |t|
    t.string   "var",         null: false
    t.text     "value"
    t.integer  "target_id",   null: false
    t.string   "target_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true

  create_table "subscriptions", force: true do |t|
    t.integer  "channel_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "muted",      default: false
  end

  add_index "subscriptions", ["channel_id"], name: "index_subscriptions_on_channel_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.date     "due_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed",  default: false
    t.integer  "tenant_id"
  end

  add_index "tasks", ["created_at"], name: "index_tasks_on_created_at"
  add_index "tasks", ["tenant_id"], name: "index_tasks_on_tenant_id"

  create_table "tenants", force: true do |t|
    t.string   "name"
    t.string   "hostname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note"
    t.integer  "tenant_id"
  end

  add_index "uploads", ["tenant_id"], name: "index_uploads_on_tenant_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_sign_in_at"
    t.string   "jabber_id"
    t.string   "jabber_otr_fingerprint"
    t.string   "access_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "approved",               default: false
    t.integer  "role",                   default: 0
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true
  add_index "users", ["approved"], name: "index_users_on_approved"
  add_index "users", ["created_at"], name: "index_users_on_created_at"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
