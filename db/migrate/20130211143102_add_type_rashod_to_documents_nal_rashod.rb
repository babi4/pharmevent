class AddTypeRashodToDocumentsNalRashod < ActiveRecord::Migration
  def change
    add_column :documents_nal_rashods, :type_rashod, :integer
  end
end
