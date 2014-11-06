module ApplicationHelper
  def admin?
    session[:user_id] ? User.find(session[:user_id]).admin? : false
  end

  def verify_admin
    redirect_to root_path unless User.find(session[:user_id]).admin?
  end
end
