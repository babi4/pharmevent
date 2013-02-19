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
    render 'index', :layout => false
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

      if @user.errors.messages.has_key?(:password)
        if @user.errors.messages[:password].first == 'не совпадает с подтверждением'
          @user.errors.messages[:password][0] = 'Указанные пароли не совпадают.'
        elsif @user.errors.messages[:password].first == 'не может быть пустым'
          @user.errors.messages[:password][0] = 'Пароль не может быть пустым.'
        elsif @user.errors.messages[:password].first.include?('недостаточной длины')
          @user.errors.messages[:password][0] = 'В пароле должно быть больше 6 символов.'
        end
      end

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
