class HomeController < ApplicationController

  def index
    if can? :root_path, :events
      redirect_to events_path
    else
      redirect_to documents_path
    end
  end

end
