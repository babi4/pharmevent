class CouriersTasksController < ApplicationController
  # GET /couriers_tasks
  # GET /couriers_tasks.json
  def index
    @couriers_tasks = CouriersTask.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @couriers_tasks }
    end
  end

  # GET /couriers_tasks/1
  # GET /couriers_tasks/1.json
  def show
    @couriers_task = CouriersTask.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @couriers_task }
    end
  end

  # GET /couriers_tasks/new
  # GET /couriers_tasks/new.json
  def new
    @couriers_task = CouriersTask.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couriers_task }
    end
  end

  # GET /couriers_tasks/1/edit
  def edit
    @couriers_task = CouriersTask.find(params[:id])
  end

  # POST /couriers_tasks
  # POST /couriers_tasks.json
  def create
    @couriers_task = CouriersTask.new(params[:couriers_task])

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

  # PUT /couriers_tasks/1
  # PUT /couriers_tasks/1.json
  def update
    @couriers_task = CouriersTask.find(params[:id])

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

  # DELETE /couriers_tasks/1
  # DELETE /couriers_tasks/1.json
  def destroy
    @couriers_task = CouriersTask.find(params[:id])
    @couriers_task.destroy

    respond_to do |format|
      format.html { redirect_to couriers_tasks_url }
      format.json { head :no_content }
    end
  end
end
