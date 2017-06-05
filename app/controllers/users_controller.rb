class UsersController < ApplicationController
  before_action :load_genders, only: :edit

  load_and_authorize_resource

  def index
    @users = User.not_admin.page(params[:page]).per Settings.per_page
  end

  def show
    @user_supports = Supports::User.new user: @user
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      redirect_to user_path @user
    else
      flash[:error] = t "error_update_profile"
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html{redirect_to users_path}
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit profile_attributes: [:name, :birthday,
      :gender, :address, :job, :phonenumber, :avatar, :description]
  end

  def load_genders
    @select_genders = Profile.gender_attributes_for_select
  end
end
