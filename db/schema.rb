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

ActiveRecord::Schema.define(version: 20141211065938) do

  create_table "abbrev", primary_key: "NDB_No", force: true do |t|
    t.string  "Shrt_Desc",   limit: 60
    t.float   "Water"
    t.integer "Energ_Kcal"
    t.float   "Protein"
    t.float   "Lipid_Tot"
    t.float   "Ash"
    t.float   "Carbohydrt"
    t.float   "Fiber_TD"
    t.float   "Sugar_Tot",               default: 0.0
    t.integer "Calcium"
    t.float   "Iron"
    t.float   "Magnesium",               default: 0.0
    t.integer "Phosphorus"
    t.integer "Potassium"
    t.integer "Sodium"
    t.float   "Zinc",                    default: 0.0
    t.float   "Copper",                  default: 0.0
    t.float   "Manganese",               default: 0.0
    t.float   "Selenium",                default: 0.0
    t.float   "Vit_C"
    t.float   "Thiamin",                 default: 0.0
    t.float   "Riboflavin",              default: 0.0
    t.float   "Niacin",                  default: 0.0
    t.float   "Panto_Acid",              default: 0.0
    t.float   "Vit_B6",                  default: 0.0
    t.float   "Folate_Tot",              default: 0.0
    t.float   "Folic_Acid",              default: 0.0
    t.float   "Food_Folate",             default: 0.0
    t.float   "Folate_DFE",              default: 0.0
    t.float   "Choline_Tot",             default: 0.0
    t.float   "Vit_B12",                 default: 0.0
    t.integer "Vit_A_IU"
    t.float   "Vit_A_RAE",               default: 0.0
    t.float   "Retinol",                 default: 0.0
    t.float   "Alpha_Carot",             default: 0.0
    t.float   "Beta_Carot",              default: 0.0
    t.float   "Beta_Crypt",              default: 0.0
    t.float   "Lycopene",                default: 0.0
    t.float   "Lut+Zea",                 default: 0.0
    t.float   "Vit_E",                   default: 0.0
    t.float   "Vit_D_mcg",               default: 0.0
    t.float   "ViVit_D_IU",              default: 0.0
    t.float   "Vit_K",                   default: 0.0
    t.float   "FA_Sat"
    t.float   "FA_Mono",                 default: 0.0
    t.float   "FA_Poly",                 default: 0.0
    t.integer "Cholestrl"
    t.float   "GmWt_1"
    t.string  "GmWt_Desc1",  limit: 120
    t.float   "GmWt_2",                  default: 0.0
    t.string  "GmWt_Desc2",  limit: 120
    t.integer "Refuse_Pct"
  end

  add_index "abbrev", ["Folic_Acid"], name: "Abbrev_Folic_Acid_Index", using: :btree
  add_index "abbrev", ["Panto_Acid"], name: "Abbrev_Panto_Acid_Index", using: :btree

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "active_nutrition_migrations", force: true do |t|
    t.integer  "sequence_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_src", id: false, force: true do |t|
    t.integer "DataSrc_ID"
    t.string  "Authors"
    t.string  "Title"
    t.string  "Year",        limit: 4
    t.string  "Journal",     limit: 135
    t.string  "Vol_city",    limit: 16
    t.string  "Issue_State", limit: 5
    t.string  "Start_Page",  limit: 5
    t.string  "End_Page",    limit: 5
  end

  add_index "data_src", ["DataSrc_ID"], name: "DataSrc_ID_Index", using: :btree

  create_table "datsrcln", id: false, force: true do |t|
    t.integer "NDB_No",               null: false
    t.integer "Nutr_No",              null: false
    t.string  "DataSrc_ID", limit: 6, null: false
  end

  add_index "datsrcln", ["NDB_No", "Nutr_No", "DataSrc_ID"], name: "Datsrcln_NDB_No_Nutr_No_DataSrc_ID_Index", unique: true, using: :btree

  create_table "deriv_cd", id: false, force: true do |t|
    t.integer "Deriv_CD"
    t.string  "Deriv_Desc", limit: 120
  end

  add_index "deriv_cd", ["Deriv_CD"], name: "Deriv_CD_Deriv_CD_Index", using: :btree

  create_table "fd_group", primary_key: "FdGrp_CD", force: true do |t|
    t.string "FdGrp_Desc", limit: 60
  end

  create_table "food_des", primary_key: "NDB_No", force: true do |t|
    t.string  "FdGrp_Cd",    limit: 4
    t.string  "Long_Desc",   limit: 200
    t.string  "Shrt_Desc",   limit: 60
    t.string  "ComName",     limit: 100
    t.string  "ManufacName", limit: 65
    t.string  "Survey",      limit: 1
    t.string  "Ref_Desc",    limit: 135
    t.integer "Refuse"
    t.string  "SciName",     limit: 65
    t.float   "N_Factor"
    t.float   "Pro_Factor"
    t.float   "Fat_Factor"
    t.float   "CHO_Factor"
  end

  create_table "footnote", id: false, force: true do |t|
    t.integer "NDB_No",                  null: false
    t.integer "Footnt_No"
    t.string  "Footnot_Typ", limit: 1
    t.integer "Nutr_No"
    t.string  "Footnot_Txt", limit: 200
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "serving_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.integer  "available_servings"
  end

  create_table "langdesc", id: false, force: true do |t|
    t.string "Factor_Code"
    t.string "Description", limit: 250
  end

  add_index "langdesc", ["Factor_Code"], name: "LangDesc_Factor_Code_Index", using: :btree

  create_table "langual", id: false, force: true do |t|
    t.integer "NDB_No",                null: false
    t.string  "Factor_Code", limit: 6, null: false
  end

  add_index "langual", ["NDB_No", "Factor_Code"], name: "Langual_NDB_No_Factor_Code_Index", unique: true, using: :btree

  create_table "nut_data", id: false, force: true do |t|
    t.integer "NDB_No",                   null: false
    t.integer "Nutr_No",                  null: false
    t.float   "Nutr_Val"
    t.integer "Num_Data_Pts"
    t.float   "Std_Error"
    t.string  "Src_Cd",        limit: 2
    t.string  "Deriv_Cd",      limit: 4
    t.integer "Ref_NDB_No"
    t.string  "Add_Nutr_Mark", limit: 1
    t.integer "Num_Studies"
    t.float   "Min"
    t.float   "Max"
    t.float   "DF"
    t.float   "Low_EB"
    t.float   "Up_EB"
    t.string  "Stat_Cmt",      limit: 10
    t.date    "AddMod_Date"
    t.string  "CC"
  end

  add_index "nut_data", ["NDB_No", "Nutr_No"], name: "Nut_Data_NDB_No_Nutr_No_Index", unique: true, using: :btree
  add_index "nut_data", ["Num_Data_Pts"], name: "Nut_Data_Num_Data_Pts_Index", using: :btree
  add_index "nut_data", ["Num_Studies"], name: "Num_Studies_Index", using: :btree

  create_table "nutr_def", primary_key: "Nutr_No", force: true do |t|
    t.string "Units",    limit: 7
    t.string "Tagname",  limit: 20
    t.string "NutrDesc", limit: 60
    t.string "Num_Dec",  limit: 1
    t.float  "SR_Order"
  end

  add_index "nutr_def", ["Num_Dec"], name: "Num_Dec_Index", using: :btree

  create_table "nutrients", force: true do |t|
    t.string   "name"
    t.integer  "Nutr_No"
    t.integer  "importance"
    t.string   "dv"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "customer_id"
    t.string   "street_address"
    t.string   "city"
    t.string   "state",                 default: "CA"
    t.string   "zip_code"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "stripe_charge_id"
    t.datetime "ordered_at"
    t.datetime "fulfilled_at"
    t.integer  "cook_id"
    t.datetime "pickedup_at"
    t.datetime "delivered_at"
    t.integer  "courier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.string   "phone_number"
    t.string   "full_name"
    t.string   "zone"
    t.text     "delivery_instructions"
  end

  create_table "recipe_ingredients", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.string   "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "src_cd", primary_key: "Src_Cd", force: true do |t|
    t.string "SrcCd_Desc", limit: 60
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_id"
    t.string   "phone_number"
    t.string   "full_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weight", id: false, force: true do |t|
    t.integer "NDB_No",                  null: false
    t.integer "Seq",                     null: false
    t.float   "Amount"
    t.string  "Msre_Desc",    limit: 80
    t.float   "Gm_Wgt"
    t.integer "Num_Data_Pts"
    t.float   "Std_Dev"
  end

  add_index "weight", ["NDB_No", "Seq"], name: "Weight_NDB_No_Seq_Index", unique: true, using: :btree
  add_index "weight", ["Num_Data_Pts"], name: "Weight_Num_Data_Pts_Index", using: :btree

  create_table "zones", force: true do |t|
    t.text     "boundaries"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "neighborhood"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
