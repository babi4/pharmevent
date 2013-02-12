# encoding: utf-8

class NalRashodsController < ApplicationController

  def update_state
    update_document_state(@documents_nal_rashod, params[:transaction], params[:state_note])

    respond_to do |format|
      format.html { redirect_to @event }
      format.json { head :no_content }
    end
  end

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_nal_rashods }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_nal_rashod }
    end
  end

  def new
    @documents_nal_rashod[:type_rashod] = RASHOD_TYPES.first.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_nal_rashod }
    end
  end

  def edit
  end

  def create
    @documents_nal_rashod[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_nal_rashod.save
        format.html { redirect_to @event, notice: 'Наличный расход создан.' }
        format.json { render json: @documents_nal_rashod, status: :created, location: @documents_nal_rashod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_nal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @documents_nal_rashod.update_attributes(params[:documents_nal_rashod])
        format.html { redirect_to @event, notice: 'Наличный расход изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_nal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_nal_rashod.destroy

    respond_to do |format|
      format.html { redirect_to @event }
      format.json { head :no_content }
    end
  end
end
