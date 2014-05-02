module ApplicationHelper
  def form_auth_token
    "<input type='hidden' name='authenticity_token'
      value='#{form_authenticity_token}'>".html_safe
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end
end
