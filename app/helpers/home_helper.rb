load 'application_helper.rb'
module HomeHelper
	def testselect
		return procedure_select_all("select * from sys.procedures")
	end
end
