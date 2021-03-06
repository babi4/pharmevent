# encoding: utf-8

class BeznalRashodsController < ApplicationController

  def update_state
    update_document_state(@documents_beznal_rashod, params[:transaction], params[:state_note])

    redirect_path =
      if special_redirect_after_update?
        documents_path
      else
        root_or_current_path(@event)
      end

    respond_to do |format|
      format.html { redirect_to redirect_path }
      format.json { head :no_content }
    end
  end


  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_beznal_rashods }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_beznal_rashod }
    end
  end

  def new
    @documents_beznal_rashod[:type_rashod] = RASHOD_TYPES.keys.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_beznal_rashod }
    end
  end

  def edit
  end

  def create
    @documents_beznal_rashod[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_beznal_rashod.save
        format.html { redirect_to root_or_current_path(@event), notice: 'Безналичный расход создан.' }
        format.json { render json: @documents_beznal_rashod, status: :created, location: @documents_beznal_rashod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_beznal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @documents_beznal_rashod.update_attributes(params[:documents_beznal_rashod])
        format.html { redirect_to root_or_current_path(@event), notice: 'Безналичный расход изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_beznal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_beznal_rashod.destroy

    respond_to do |format|
      format.html { redirect_to root_or_current_path(@event) }
      format.json { head :no_content }
    end
  end

  private

    def special_redirect_after_update?
      return false if params[:transaction] != 'sign'

      referer = request.referrer
      return false unless referer

      path = URI.parse(referer).path
      return false unless %w[/documents/search /documents /documents/].include? path

      current_ability.redirect_documents_after_sign?
    end

end
