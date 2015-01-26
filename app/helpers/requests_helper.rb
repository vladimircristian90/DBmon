module RequestsHelper
	def rebuildIndex
		database = params["database"]
		schema = params["schema"]
		table = params["table"]
		index = params["index"]
		guid = params["guid"]
		return procedure_select_all("exec [dbmon].[SA_DBAMON].[usp_rebuild_index]
			@p_database = '#{database}',
			@p_schema = '#{schema}',
			@p_table = '#{table}',
			@p_index = '#{index}',
			@p_index_guid = '#{guid}'").to_a
	end
	def getDrives
		return procedure_select_all("exec [dbmon].[SA_DBAMON].[usp_get_drives]").to_a
	end
	def getDirTree
		directory = params["directory"]
		guid = params["guid"]
		level = params["level"]
		return procedure_select_all("exec [dbmon].[SA_DBAMON].[usp_get_dir_tree] 
			@p_dir = '#{directory}',
			@p_parent_id = '#{guid}',
			@p_parent_level = #{level}").to_a
	end
	def backupDatabase
		databaseId = params["databaseId"]
		path = params["path"]
		return procedure_select_all("exec dbmon.sa_dbamon.usp_backup_database
			@p_dbid = #{databaseId}, 
			@p_path = '#{path}'");
	end
end
