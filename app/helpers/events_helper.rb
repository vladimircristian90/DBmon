load 'application_helper.rb'
module EventsHelper
	def getAllErrors
		dbId=''
		startDate = params["startDate"]
		endDate = params["endDate"]
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		if startDate.nil? && !endDate.nil? && endDate.length > 0
			queryParams = ", @p_end_date = '#{endDate}'"
		elsif !startDate.nil? && startDate.length > 0 && endDate.nil?
			queryParams = ", @p_start_date = '#{startDate}'"
		elsif !startDate.nil? && !endDate.nil?
			queryParams = (startDate.length == 0 ? '' : ", @p_start_date = '#{startDate}'").to_s + (endDate.length == 0 ? '' : ", @p_end_date = '#{endDate}'").to_s
		end

		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_errors @p_dbid='#{dbId}'#{queryParams}").to_a;
	end
	def getAllErrorsByType
		dbId=''
		startDate = params["startDate"]
		endDate = params["endDate"]
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		if startDate.nil? && !endDate.nil? && endDate.length > 0
			queryParams = ", @p_end_date = '#{endDate}'"
		elsif !startDate.nil? && startDate.length > 0 && endDate.nil?
			queryParams = ", @p_start_date = '#{startDate}'"
		elsif !startDate.nil? && !endDate.nil?
			queryParams = (startDate.length == 0 ? '' : ", @p_start_date = '#{startDate}'").to_s + (endDate.length == 0 ? '' : ", @p_end_date = '#{endDate}'").to_s
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_errors_by_type @p_dbid=#{dbId}#{queryParams}").to_a;
	end
	def getDeadlocks
		startDate = params["startDate"]
		endDate = params["endDate"]
		queryParams = ''
		if startDate.nil? && !endDate.nil? && endDate.length > 0
			queryParams = "@p_end_date = '#{endDate}'"
		elsif !startDate.nil? && startDate.length > 0 && endDate.nil?
			queryParams = "@p_start_date = '#{startDate}'"
		elsif !startDate.nil? && !endDate.nil?
			queryParams = (startDate.length == 0 ? '' : "@p_start_date = '#{startDate}'").to_s + (endDate.length == 0 ? '' : (startDate.length == 0 ? '': ', ')+" @p_end_date = '#{endDate}'").to_s
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_deadlocks #{queryParams}")
	end
		
	def getRunningProcesses
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_running_processes")
	end
	def getSqlServerLog
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_sql_server_log")
	end
	def getStatementLog
		dbId=''
		if params["databaseId"].nil?
			dbId = -1
		else 
			dbId = params["databaseId"]
		end
		startDate = params["startDate"]
		endDate = params["endDate"]
		queryParams = ''
		if startDate.nil? && !endDate.nil? && endDate.length > 0
			queryParams = ", @p_end_date = '#{endDate}'"
		elsif !startDate.nil? && startDate.length > 0 && endDate.nil?
			queryParams = ", @p_start_date = '#{startDate}'"
		elsif !startDate.nil? && !endDate.nil?
			queryParams = (startDate.length == 0 ? '' : ", @p_start_date = '#{startDate}'").to_s + (endDate.length == 0 ? '' : ", @p_end_date = '#{endDate}'").to_s
		end
		return procedure_select_all("exec dbmon.sa_dbamon.usp_get_statement_log @p_dbid = #{dbId}#{queryParams}")
	end
end
