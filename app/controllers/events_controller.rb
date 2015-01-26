class EventsController < ApplicationController
	def index
	end
	def allErrors
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

		@query = procedure_select_all("exec dbmon.sa_dbamon.usp_get_errors @p_dbid='#{dbId}'#{queryParams}").to_a;
	end
end
