module ApplicationHelper
	$defaultRowsInPage = 20
	$defaultFirstPage = 1
	$defaultMinPages = 5
	def procedure_select_all(proc_name_with_parameters)
	    ActiveRecord::Base.connection.select_all(proc_name_with_parameters)
		rescue Exception => e
    	raise e
	end

  def procedure_execute(proc_name_with_parameters)
    ActiveRecord::Base.connection.execute(proc_name_with_parameters)
	rescue Exception => e
	raise e

  end

  def procedure_select_value(proc_name_with_parameters)
    ActiveRecord::Base.connection.select_value(proc_name_with_parameters)
	rescue Exception => e
		raise e
  end 

  def getDatabasesAll
		return procedure_select_all("select name from sd_dbamon.vw_get_databses").to_a;
  end
  def getDatabasesOnline
		return procedure_select_all("select name, database_id from sd_dbamon.vw_get_databses where state_desc = 'ONLINE'").to_a;
  end
  	def encrypt(message)
       encryptor = ActiveSupport::MessageEncryptor.new('jsiuyq349889UCQaj09Mq30948293jhjajshfjaHJKHQIWEGLKJEGWKELJ545383545455455F')
     return  encryptor.encrypt(message)
    end
    def decrypt(encrypted)
       encryptor = ActiveSupport::MessageEncryptor.new('jsiuyq349889UCQaj09Mq30948293jhjajshfjaHJKHQIWEGLKJEGWKELJ545383545455455F')
     return  encryptor.decrypt(encrypted)
    end

  def getParameter(paramName)
  	#return "-1"
  	#return Base64.decode64(params[:rp])
	#return decrypt(Base64.decode64(params[:rp]))
	if !params[:rp].nil?
		dec = Marshal.load(decrypt(Base64.decode64(params[:rp])))
		return dec[paramName] #(dec[paramName].nil? || dec[paramName].length == 0 ? nil : )
	end
	return nil
  end
end
