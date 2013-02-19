class AddTypeSchetToDocumentsBeznalSchets < ActiveRecord::Migration
  def change
    add_column :documents_beznal_schets, :type_schet, :integer
  end
end
