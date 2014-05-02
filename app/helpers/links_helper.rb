module LinksHelper
  def require_submitter
    @link = Link.find(params[:id])
    redirect_to link_url(@link) unless @link.submitter_id = current_user.id
  end
end
