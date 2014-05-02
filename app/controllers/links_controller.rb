class LinksController < ApplicationController
  include LinksHelper

  before_action :require_login, except: [:index, :show]
  before_action :require_submitter, only: [:edit, :update]

  def index
  end

  def new
    @link = Link.new
    @subs = Sub.all
  end

  def create
    @link = current_user.submitted_links.new(link_params)
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
    @comment = current_user.authored_comments.new
    @comment.link_id = @link.id

    @comments = @link.comments_by_parent_id
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end
  end

  def upvote
    create_vote(true)
  end

  def downvote
    create_vote(false)
  end

  private
  def link_params
    params.require(:link).permit(:title, :url, :text, parent_sub_ids: [])
  end

  def create_vote(bool)
    @vote = UserVote.new(
      user_id: current_user.id,
      link_id: params[:id],
      upvote: bool
      )
    unless @vote.save
      flash[:errors] = ["Sorry, I didn't register that vote"]
    end
    redirect_to link_url(@vote.link)
  end
end
