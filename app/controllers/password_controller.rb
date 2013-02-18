# encoding: utf-8

class PasswordController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :assert_reset_token_passed, :only => :edit

  def index
    @user = User.new
    render :layout => false
  end

  def create
    @user = User.send_reset_password_instructions(params[:user])

    if @user.errors.empty?
      render 'index', :layout => false, :notice => 'Инструкции отправленны' # TODO показывать уведомления
    else
      render 'index', :layout => false
    end
  end

  def edit #edit pass
    @user = User.find(params[:id])
    @user.reset_password_token = params[:reset_password_token]
    render :layout => false
  end

  def update # update pass
    @user = User.reset_password_by_token(params[:user])

    if @user.errors.empty?
      #flash_message = user.active_for_authentication? ? :updated : :updated_not_active
      #set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(User, @user)
      redirect_to root_path
    else
      render 'edit', :layout => false
    end
  end

  private

    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        redirect_to new_user_session_path
      end
    end

end
