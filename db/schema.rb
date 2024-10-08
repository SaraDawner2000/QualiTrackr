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

ActiveRecord::Schema[7.0].define(version: 2024_08_01_204005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_enum :approval_options, [
    "ready",
    "sent",
    "approved",
    "rejected",
  ], force: :cascade

  create_enum :customers, [
    "sparky",
    "mctractor",
  ], force: :cascade

  create_enum :role_options, [
    "quality_manager",
    "quality_admin",
    "qc_tech",
    "prod_manager",
  ], force: :cascade

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "parts", force: :cascade do |t|
    t.string "number", null: false
    t.string "revision", null: false
    t.string "job"
    t.string "base_material"
    t.string "finish"
    t.boolean "measured_status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number", "revision"], name: "index_parts_on_number_and_revision", unique: true
  end

  create_table "quality_projects", force: :cascade do |t|
    t.bigint "part_id", null: false
    t.string "customer_request"
    t.string "purchase_order"
    t.boolean "report_approval"
    t.boolean "record_approval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "customer_approval", enum_type: "approval_options"
    t.enum "customer", null: false, enum_type: "customers"
    t.index ["part_id"], name: "index_quality_projects_on_part_id"
  end

  create_table "subcomponents", force: :cascade do |t|
    t.bigint "parent_id", null: false
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_subcomponents_on_child_id"
    t.index ["parent_id"], name: "index_subcomponents_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "role", default: "quality_admin", null: false, enum_type: "role_options"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "quality_projects", "parts"
  add_foreign_key "subcomponents", "parts", column: "child_id"
  add_foreign_key "subcomponents", "parts", column: "parent_id"
end
