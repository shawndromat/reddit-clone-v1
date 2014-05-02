module SubsHelper
  def require_moderator
    sub = Sub.find(params[:id])
    redirect_to subs_url unless sub.moderator_id == current_user.id
  end
end
