class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  private

    def update_document_state(document, transaction, state_note)
      transactions_collection = %w(send_to_sign sign send_for_revision pay block_payment remove)

      if transactions_collection.include?( transaction ) && can?( transaction.to_sym, document )
        document.send transaction
      end

      document.update_attributes(state_note: state_note)

    end

end
