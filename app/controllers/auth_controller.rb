class AuthController < ApplicationController
  skip_before_filter :authenticate_user!

  before_filter :validate_params!, :only => :create

  def new
    render :layout => false
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      user.remember_me = true
      sign_in(User, user)
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    sign_out(User)
    redirect_to new_user_session_path
  end

  private

    def validate_params!
      if params[:user][:email].blank? || params[:user][:password].blank?
        redirect_to new_user_session_path
      end
    end

end
