
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :encParams

  private
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
  
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

  def isMobileDevice
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return true if agent.match(m)
    end
    return false
  end

  helper_method :isMobileDevice
  def encrypt(message)
       encryptor = ActiveSupport::MessageEncryptor.new('jsiuyq349889UCQaj09Mq30948293jhjajshfjaHJKHQIWEGLKJEGWKELJ545383545455455F')
     return  encryptor.encrypt(message)
    end
    def decrypt(encrypted)
       encryptor = ActiveSupport::MessageEncryptor.new('jsiuyq349889UCQaj09Mq30948293jhjajshfjaHJKHQIWEGLKJEGWKELJ545383545455455F')
     return  encryptor.decrypt(encrypted)
    end
  def encParams
     #if request.get? #&& params[:rp].nil?
      pars = params.reject{ |k| k == 'rp' }.reject{|k| k == 'controller'}.reject{|k| k == 'action'}
        if pars.length > 0
          enc = encrypt(Marshal.dump(pars))
          path = request.original_fullpath.split("?")[0]  
          redir_path = path + "?rp="+Base64.encode64(enc)
          redirect_to redir_path
        end
    #end
  end

end
