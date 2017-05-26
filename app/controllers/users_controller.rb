class UsersController < ApplicationController
  before_action :load_genders, only: :edit

  load_and_authorize_resource
  skip_authorize_resource only: [:show]

  def show
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

  private

  def user_params
    params.require(:user).permit profile_attributes: [:name, :birthday,
      :gender, :address, :job, :phonenumber, :avatar, :description]
  end

  def load_genders
    @select_genders = Profile.gender_attributes_for_select
  end
end
