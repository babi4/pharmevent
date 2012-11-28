# encoding: utf-8

class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @new_event = Event.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    @prihod_summ =
      @event.documents_nal_prihods.sum(:summ) +
      @event.documents_beznal_schets.sum(:summ)
    @rashod_summ =
      @event.documents_nal_rashods.sum(:summ) +
      @event.documents_beznal_rashods.sum(:summ)

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def edit
  end

  def create
    @event[:user_id] = current_user[:id]

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url, notice: 'Мероприятие создано.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Мероприятие отредактировано.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
