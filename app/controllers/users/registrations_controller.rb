class Users::RegistrationsController < Devise::RegistrationsController
  before_action :load_genders, only: [:new, :create]

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new user_params
    if @user.save
      set_flash_message! :notice, :signed_up
      sign_up :user, @user
      redirect_to user_path @user
    else
      clean_up_passwords @user
      set_minimum_password_length
      respond_with @user
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password, :password_confirmation,
      profile_attributes: [:name, :birthday, :gender, :address, :job,
        :phonenumber, :avatar, :description]
  end

  def load_genders
    @select_genders = Profile.gender_attributes_for_select
  end
end
