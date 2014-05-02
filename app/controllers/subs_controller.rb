class SubsController < ApplicationController
  include SubsHelper

  before_action :require_login, except: [:index, :show]
  before_action :require_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @links = @sub.links.sort_by(&:vote_count).reverse
  end

  def new
    @sub = Sub.new
    5.times { @sub.links.build }
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)
    @sub.links.new(link_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      (5 - @sub.links.length).times { @sub.links.build }
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:name)
  end

  def link_params
    params.permit(link: [:title, :url, :text] )
          .require(:link)
          .values
          .reject{ |link| link.values.all?(&:blank?) }
          .map { |link| link.submitter_id = current_user.id }
  end
end
