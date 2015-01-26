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

ActiveRecord::Schema.define(:version => 0) do

  create_table "tbl_ddl_log", :id => false, :force => true do |t|
  end

  create_table "tbl_error_report", :id => false, :force => true do |t|
  end

  create_table "tbl_monitor_errorlog", :id => false, :force => true do |t|
  end

  create_table "tbl_protokol", :primary_key => "fld_id", :force => true do |t|
    t.string   "fld_procedure_name",  :limit => 250,                                 :default => ""
    t.decimal  "fld_srm_step",                        :precision => 18, :scale => 0, :default => -1
    t.decimal  "fld_srm_step_end",                    :precision => 18, :scale => 0, :default => -1
    t.decimal  "fld_log_level",                       :precision => 18, :scale => 0, :default => 0
    t.string   "fld_message",         :limit => 4000,                                :default => ""
    t.string   "fld_parameters",      :limit => 4000,                                :default => ""
    t.string   "fld_process_name",    :limit => 250,                                 :default => "isnull(app_name(),'"
    t.string   "fld_host_name",       :limit => 250,                                 :default => "isnull(host_name(),'"
    t.integer  "fld_db_id",                                                          :default => -1
    t.string   "fld_db_name",         :limit => 250,                                 :default => ""
    t.integer  "fld_schema_id",                                                      :default => -1
    t.string   "fld_schema_name",     :limit => 250,                                 :default => ""
    t.integer  "fld_object_id",                                                      :default => -1
    t.string   "fld_object_name",     :limit => 250,                                 :default => ""
    t.string   "fld_ecsuser",         :limit => 50,                                  :default => "[dbo].[uf_get_user_and_login_name]("
    t.string   "fld_original_login",  :limit => 250,                                 :default => "isnull(original_login(),'"
    t.string   "fld_user_name",       :limit => 250,                                 :default => "isnull(user_name(),'"
    t.string   "fld_current_user",    :limit => 250,                                 :default => "isnull(user_name(),'"
    t.string   "fld_session_user",    :limit => 250,                                 :default => "isnull(user_name(),'"
    t.string   "fld_system_user",     :limit => 250,                                 :default => "isnull(suser_sname(),'"
    t.decimal  "fld_error_number",                    :precision => 18, :scale => 0, :default => 0
    t.decimal  "fld_error_severity",                  :precision => 18, :scale => 0, :default => 0
    t.decimal  "fld_error_state",                     :precision => 18, :scale => 0, :default => 0
    t.decimal  "fld_error_line",                      :precision => 18, :scale => 0, :default => 0
    t.string   "fld_error_procedure", :limit => 250,                                 :default => "isnull(error_procedure(),'"
    t.string   "fld_error_message",   :limit => 4000,                                :default => "isnull(error_message(),'"
    t.datetime "fld_ins_date"
    t.datetime "fld_upd_date"
    t.integer  "fld_cc",                                                             :default => 0
  end

  create_table "tbl_protokol_err", :primary_key => "fld_id", :force => true do |t|
    t.string   "fld_procedure_name",  :limit => 250,                                 :default => ""
    t.decimal  "fld_srm_step",                        :precision => 18, :scale => 0, :default => -1
    t.decimal  "fld_srm_step_end",                    :precision => 18, :scale => 0, :default => -1
    t.decimal  "fld_log_level",                       :precision => 18, :scale => 0, :default => 0
    t.string   "fld_message",         :limit => 4000,                                :default => ""
    t.string   "fld_parameters",      :limit => 4000,                                :default => ""
    t.string   "fld_process_name",    :limit => 250,                                 :default => "isnull(app_name(),'"
    t.string   "fld_host_name",       :limit => 250,                                 :default => "isnull(host_name(),'"
    t.integer  "fld_db_id",                                                          :default => -1
    t.string   "fld_db_name",         :limit => 250,                                 :default => ""
    t.integer  "fld_schema_id",                                                      :default => -1
    t.string   "fld_schema_name",     :limit => 250,                                 :default => ""
    t.integer  "fld_object_id",                                                      :default => -1
    t.string   "fld_object_name",     :limit => 250,                                 :default => ""
    t.string   "fld_ecsuser",         :limit => 50,                                  :default => "[dbo].[uf_get_user_and_login_name]("
    t.string   "fld_original_login",  :limit => 250,                                 :default => "isnull(original_login(),'"
    t.string   "fld_user_name",       :limit => 250,                                 :default => "isnull(user_name(),'"
    t.string   "fld_current_user",    :limit => 250,                                 :default => "isnull(user_name(),'"
    t.string   "fld_session_user",    :limit => 250,                                 :default => "isnull(user_name(),'"
    t.string   "fld_system_user",     :limit => 250,                                 :default => "isnull(suser_sname(),'"
    t.decimal  "fld_error_number",                    :precision => 18, :scale => 0, :default => 0
    t.decimal  "fld_error_severity",                  :precision => 18, :scale => 0, :default => 0
    t.decimal  "fld_error_state",                     :precision => 18, :scale => 0, :default => 0
    t.decimal  "fld_error_line",                      :precision => 18, :scale => 0, :default => 0
    t.string   "fld_error_procedure", :limit => 250,                                 :default => "isnull(error_procedure(),'"
    t.string   "fld_error_message",   :limit => 4000,                                :default => "isnull(error_message(),'"
    t.datetime "fld_ins_date"
    t.datetime "fld_upd_date"
    t.integer  "fld_cc",                                                             :default => 0
  end

  create_table "tbl_query_analysis_1", :id => false, :force => true do |t|
  end

  create_table "tbl_query_analysis_2", :id => false, :force => true do |t|
  end

  create_table "tbl_query_analysis_3", :id => false, :force => true do |t|
  end

  create_table "tbl_query_analysis_4", :id => false, :force => true do |t|
  end

  create_table "tbl_query_analysis_5", :id => false, :force => true do |t|
  end

  create_table "tbl_query_analysis_6", :id => false, :force => true do |t|
  end

  create_table "tbl_query_analysis_7", :id => false, :force => true do |t|
  end

  create_table "tbl_trace_config", :id => false, :force => true do |t|
  end

  create_table "tbl_trace_config_desc", :id => false, :force => true do |t|
  end

end
