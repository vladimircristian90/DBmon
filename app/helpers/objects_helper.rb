load 'application_helper.rb'
module ObjectsHelper
	def getTableDetails
		dbId=''
		if params["databaseId"].nil? || params["databaseId"].length == 0
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_table_details @p_dbid='#{dbId}'").to_a;
	end
	def getViewsDetails
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_views_details @p_dbid='#{dbId}'").to_a;
	end
	def getTableIndexDetails
		dbId=''
		if params["databaseId"].nil? || params["databaseId"].empty?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_table_index_details @p_dbid='#{dbId}'").to_a;
	end
	def getProceduresDetails
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_procedures_details @p_dbid='#{dbId}'").to_a;
	end
	def getFunctionsDetails
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_functions_details @p_dbid='#{dbId}'").to_a;
	end
	def getTriggersDetails
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_triggers_details @p_dbid='#{dbId}'").to_a;
	end
end
