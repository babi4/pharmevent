# encoding: utf-8

class DocumentsBeznalSchetsController < ApplicationController
  authorize_resource
  before_filter :detect_event

  def index
    @documents_beznal_schets = @event.documents_beznal_schets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_beznal_schets }
    end
  end

  def show
    @documents_beznal_schet = @event.documents_beznal_schets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_beznal_schet }
    end
  end

  def new
    date_now = DateTime.now.strftime("%d.%m.%Y")
    @documents_beznal_schet = DocumentsBeznalSchet.new(
      {
        date_schet: date_now,
        dogovor_date: date_now,
        payment_date: date_now,
        info_date_schet: date_now,
        info_date_act: date_now,
        info_return_date: date_now,
        num_schet: DocumentsBeznalSchet.maximum(:num_schet) + 1
      }
    )

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_beznal_schet }
    end
  end

  def edit
    @documents_beznal_schet = @event.documents_beznal_schets.find(params[:id])
  end

  def create
    @documents_beznal_schet = @event.documents_beznal_schets.new(params[:documents_beznal_schet])
    @documents_beznal_schet[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_beznal_schet.save
        format.html { redirect_to @event, notice: 'Безналичный счет создан.' }
        format.json { render json: @documents_beznal_schet, status: :created, location: @documents_beznal_schet }
      else
        puts @documents_beznal_schet.errors.inspect
        format.html { render action: "new" }
        format.json { render json: @documents_beznal_schet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @documents_beznal_schet = @event.documents_beznal_schets.find(params[:id])

    respond_to do |format|
      if @documents_beznal_schet.update_attributes(params[:documents_beznal_schet])
        format.html { redirect_to @event, notice: 'Безналичный счет изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_beznal_schet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_beznal_schet = @event.documents_beznal_schets.find(params[:id])
    @documents_beznal_schet.destroy

    respond_to do |format|
      format.html { redirect_to @event }
      format.json { head :no_content }
    end
  end
end
