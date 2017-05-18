class GroupsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: [:index, :show]

  def index
    @groups = Group.all
  end

  def new
    @group = current_user.owned_groups.build
    @categories = Category.all.map do |category|
      [category.name, category.id]
    end
  end

  def create
    @group = current_user.owned_groups.build group_params
    if @group.save
      flash[:success] = t ".created"
      redirect_to root_path
    else
      flash[:error] = t ".not_created"
      render :new
    end
  end

  def show
  end

  private

  def group_params
    params.require(:group).permit :title, :category_id, :time, :address, :size
  end
end
