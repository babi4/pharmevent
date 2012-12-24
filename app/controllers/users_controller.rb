# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  load_and_authorize_resource

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
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    if @user == current_user
      redirect_to users_path, :notice => "Can't delete yourself."
    else
      @user.destroy
      redirect_to users_path, :notice => "User deleted."
    end
  end
end
