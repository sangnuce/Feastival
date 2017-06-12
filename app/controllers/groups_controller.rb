class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, only: [:new, :create]
  before_action :initialize_groups, only: [:new, :create]
  before_action :init_supports, except: :destory

  def index
  end

  def new
  end

  def create
    @group = current_user.created_groups.build group_params
    if @group.save
      current_user.group_users.create! group_id: @group.id
      flash[:success] = t ".created"
      redirect_to @group
    else
      flash[:error] = t ".not_created"
      render "shared/modal_group_form"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @group.update_attributes group_params
      redirect_to group_path @group
    else
      flash[:error] = t "error_update_group"
      render :edit
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html{redirect_to groups_path}
      format.js
    end
  end

  private
  def group_params
    params.require(:group).permit :title, :category_id, :time, :size,
      :address, :longitude, :latitude, :status
  end

  def initialize_groups
    @group = current_user.created_groups.build
  end

  def init_supports
    @group_supports = Supports::Group.new group: @group
  end
end
