class CouriersTasksController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @couriers_tasks }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @couriers_task }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couriers_task }
    end
  end

  def edit
  end

  def create
    @couriers_task[:user_id] = current_user[:id]
    respond_to do |format|
      if @couriers_task.save
        format.html { redirect_to @couriers_task, notice: 'Couriers task was successfully created.' }
        format.json { render json: @couriers_task, status: :created, location: @couriers_task }
      else
        format.html { render action: "new" }
        format.json { render json: @couriers_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    params[:couriers_task][:user_id] = current_user[:id]
    respond_to do |format|
      if @couriers_task.update_attributes(params[:couriers_task])
        format.html { redirect_to @couriers_task, notice: 'Couriers task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @couriers_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @couriers_task.destroy
    respond_to do |format|
      format.html { redirect_to couriers_tasks_url }
      format.json { head :no_content }
    end
  end
end
