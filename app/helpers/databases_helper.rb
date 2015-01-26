load 'application_helper.rb'
module DatabasesHelper
	def getFilesDetails
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_files_details @p_dbid='#{dbId}'").to_a;
	end
	def getFilegroupDetails
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_filegroup_details @p_dbid='#{dbId}'").to_a;
	end
	def getDatabaseSize
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_database_size").to_a;
	end
	def getDatabaseById
		databaseId = params["databaseId"]
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_databases_by_id @p_dbid ='#{databaseId}'").to_a;
	end
	def getDatabasesForBackupHistory
		return procedure_select_all("select name from [SD_DBAMON].[vw_get_databases_for backup_history]")
	end
	def getBackupHistory
		databaseName=''
		if params["databaseName"].nil?
			databaseName = -1
		else 
			databaseName = params["databaseName"]
		end
		return procedure_select_all("exec DBMON.sa_dbamon.usp_get_backup_history @p_dbname= '#{databaseName}'")
	end
end
