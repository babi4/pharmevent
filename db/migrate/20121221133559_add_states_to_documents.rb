class AddStatesToDocuments < ActiveRecord::Migration
  def change
    add_column :documents_beznal_rashods, :state, :string
    add_column :documents_beznal_schets, :state, :string
    add_column :documents_nal_prihods, :state, :string
    add_column :documents_nal_rashods, :state, :string
  end
end
