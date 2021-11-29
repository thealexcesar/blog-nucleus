class ApplicationController < ActionController::Base

  protected
  # -------------------------------------------------------------------------
  def current_user
    @current_user ||= User.find_by_email_and_id(session[:email], session[:uid])
  rescue
    redirect_to login_admin_users_path, alert: "Erro inesperado"
    return false
  end
  # -------------------------------------------------------------------------

  def require_user
    unless current_user
      redirect_to login_admin_users_path, alert: "Voce precisa estar logado."
      return false
    end
  end
  
  def nivel_admin?
    if current_user.tipo != "admin"
      redirect_to login_admin_users_path, alert: "Acesso somente admin"
      return false
    else
      true
    end
  end
end
