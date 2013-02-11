class AddInfoReturnStatusToDocumentsBeznalSchets < ActiveRecord::Migration
  def change
    add_column :documents_beznal_schets, :info_return_status, :string
  end
end
