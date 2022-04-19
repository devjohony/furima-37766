class ApplicationController < ActionController::Base
  before_action :basic_auth


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '8888'
    end
  end
  
  protected

  def configure_permittied_parameters
    devicse_paramater_sanitizer.permit(:sign_up, key: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday])
end
end