# RailsAdmin config file. Generated on November 15, 2012 02:23
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.authorize_with :cancan

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Pharm Event', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Client, Company, CompanyMember, CouriersCompany, CouriersTask, DocumentBeznalSchet, DocumentsBeznalRashod, DocumentsNalPrihod, DocumentsNalRashod, Event, Role, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Client, Company, CompanyMember, CouriersCompany, CouriersTask, DocumentBeznalSchet, DocumentsBeznalRashod, DocumentsNalPrihod, DocumentsNalRashod, Event, Role, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Client do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :birthday, :date 
  #     configure :passport_number, :string 
  #     configure :zagran_passport_number, :string 
  #     configure :zagran_passport_use_before, :date 
  #     configure :degree, :string 
  #     configure :position, :string 
  #     configure :work, :string 
  #     configure :notes, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Company do
  #   # Found associations:
  #     configure :events, :has_many_association 
  #     configure :company_members, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :company_type, :string 
  #     configure :short_name, :string 
  #     configure :ur_zip_code, :string 
  #     configure :ur_city, :string 
  #     configure :ur_street, :string 
  #     configure :ur_hous, :string 
  #     configure :ur_stroenie, :string 
  #     configure :ur_office, :string 
  #     configure :ur_post_equal, :string 
  #     configure :post_zip_code, :string 
  #     configure :post_city, :string 
  #     configure :post_street, :string 
  #     configure :post_house, :string 
  #     configure :post_stroenie, :string 
  #     configure :post_office, :string 
  #     configure :telephone, :string 
  #     configure :fax, :string 
  #     configure :email, :string 
  #     configure :inn, :integer 
  #     configure :kpp, :string 
  #     configure :ogrn, :string 
  #     configure :okpo, :string 
  #     configure :okved, :string 
  #     configure :ispolnitel, :string 
  #     configure :osnovanie_ispolnitel, :string 
  #     configure :bank_account, :string 
  #     configure :bank_corr_account, :string 
  #     configure :bank_name, :string 
  #     configure :bank_zip, :string 
  #     configure :bank_city, :string 
  #     configure :bank_street, :string 
  #     configure :bank_house, :string 
  #     configure :bank_stroenie, :string 
  #     configure :bank_office, :string 
  #     configure :bank_bik, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model CompanyMember do
  #   # Found associations:
  #     configure :company, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :company_id, :integer         # Hidden 
  #     configure :name, :string 
  #     configure :telephone, :string 
  #     configure :position, :string 
  #     configure :email, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model CouriersCompany do
  #   # Found associations:
  #     configure :to_couriers_tasks, :has_many_association 
  #     configure :from_couriers_tasks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :zip_code, :string 
  #     configure :city, :string 
  #     configure :street, :string 
  #     configure :house, :string 
  #     configure :stroenie, :string 
  #     configure :office, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model CouriersTask do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :from_couriers_company, :belongs_to_association 
  #     configure :to_couriers_company, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :name, :string 
  #     configure :telephone, :string 
  #     configure :from_date, :string 
  #     configure :to_date, :string 
  #     configure :status, :string 
  #     configure :to_person, :string 
  #     configure :from_couriers_company_id, :integer         # Hidden 
  #     configure :to_couriers_company_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model DocumentBeznalSchet do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :company, :string 
  #     configure :description, :string 
  #     configure :name, :string 
  #     configure :telephone, :string 
  #     configure :num_schet, :string 
  #     configure :date_schet, :string 
  #     configure :summ, :string 
  #     configure :dogovor_num, :integer 
  #     configure :dogovor_date, :string 
  #     configure :info_schet_factura, :string 
  #     configure :info_act, :string 
  #     configure :info_date_schet, :datetime 
  #     configure :info_date_act, :datetime 
  #     configure :info_state_act, :string 
  #     configure :info_return_date, :datetime 
  #     configure :info_return_act_type, :datetime 
  #     configure :info_name_sender, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model DocumentsBeznalRashod do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :type_company, :string 
  #     configure :company, :string 
  #     configure :description, :string 
  #     configure :name, :string 
  #     configure :telephone, :string 
  #     configure :num_schet, :string 
  #     configure :date_schet, :string 
  #     configure :summ, :string 
  #     configure :nds, :string 
  #     configure :dogovor_num, :string 
  #     configure :dogovor_date, :string 
  #     configure :lectors, :string 
  #     configure :entire, :string 
  #     configure :info_pp, :string 
  #     configure :info_schet_factura, :string 
  #     configure :info_act, :string 
  #     configure :info_date_pay, :string 
  #     configure :info_date_schet, :string 
  #     configure :info_date_act, :string 
  #     configure :info_state_act, :string 
  #     configure :info_return_date, :datetime 
  #     configure :info_return_act_type, :string 
  #     configure :info_name_sender, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model DocumentsNalPrihod do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :company, :string 
  #     configure :description, :string 
  #     configure :name, :string 
  #     configure :telephone, :string 
  #     configure :summ, :string 
  #     configure :date, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model DocumentsNalRashod do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :company, :string 
  #     configure :description, :string 
  #     configure :name, :string 
  #     configure :telephone, :string 
  #     configure :summ, :string 
  #     configure :date, :datetime 
  #     configure :lectors, :string 
  #     configure :entire, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Event do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :company, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :user_id, :integer         # Hidden 
  #     configure :company_id, :integer         # Hidden 
  #     configure :date_start, :date 
  #     configure :date_end, :date 
  #     configure :city, :string 
  #     configure :state, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Role do
  #   # Found associations:
  #     configure :users, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :roles, :has_and_belongs_to_many_association 
  #     configure :events, :has_many_association 
  #     configure :couriers_tasks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :name, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
