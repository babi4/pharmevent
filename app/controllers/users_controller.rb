# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :new_password

  def change_pass
    authorize! :manage, :user_passwords

    if @user.reset_password!( params[:user][:password], params[:user][:password_confirmation])
      notice = 'Пароль обновлён!'
      alert  = nil
    else
      alert  = 'Пароль НЕ обновлён!'
      notice = @user.errors.messages.inspect
    end
    redirect_to users_path, :notice => notice, :alert => alert
  end

  def new_password
    @current_user = current_user
    if params[:user]
      if @current_user.reset_password!( params[:user][:password], params[:user][:password_confirmation])
        notice = 'Пароль обновлён!'
        alert  = nil
        sign_in @current_user, :bypass => true
      else
        alert  = 'Пароль НЕ обновлён!'
        notice = @current_user.errors.messages.inspect
      end
      redirect_to root_path, :notice => notice, :alert => alert
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Пользователь создан.' }
        format.json { render json: @user, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    params[:user].delete :password

    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "Пользователь сохранен."
    else
      redirect_to users_path, :alert => "Не удалось сохранить пользователя."
    end
  end
    
  def destroy
    if @user == current_user
      redirect_to users_path, :notice => "Вы не можете удалить себя."
    else
      @user.destroy
      redirect_to users_path, :notice => "Пользователь удален."
    end
  end
end
