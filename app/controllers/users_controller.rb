class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end
  
  def update
    if @user.update_attributes(params[:user], :as => :admin)
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
