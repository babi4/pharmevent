# encoding: utf-8

class DocumentsBeznalSchetsController < ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :documents_beznal_schet, :through => :event

  def update_state
    update_document_state(@documents_beznal_schet, params[:transaction], params[:state_note])

    respond_to do |format|
      format.html { redirect_to @event }
      format.json { head :no_content }
    end
  end


  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_beznal_schets }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_beznal_schet }
    end
  end

  def new
    date_now = DateTime.now.strftime("%d.%m.%Y")
    @documents_beznal_schet.attributes =
      {
        date_schet: date_now,
        dogovor_date: date_now,
        payment_date: date_now,
        info_date_schet: date_now,
        info_date_act: date_now,
        info_return_date: date_now,
        num_schet: DocumentsBeznalSchet.next_num_schet
      }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_beznal_schet }
    end
  end

  def edit
  end

  def create
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
    @documents_beznal_schet.destroy

    respond_to do |format|
      format.html { redirect_to @event }
      format.json { head :no_content }
    end
  end
end
