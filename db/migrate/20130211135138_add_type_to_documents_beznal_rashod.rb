class AddTypeToDocumentsBeznalRashod < ActiveRecord::Migration
  def change
    add_column :documents_beznal_rashods, :type, :integer
  end
end
