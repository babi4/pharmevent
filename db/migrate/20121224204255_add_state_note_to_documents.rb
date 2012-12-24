class AddStateNoteToDocuments < ActiveRecord::Migration
  def change
    add_column :documents_beznal_rashods, :state_note, :text
    add_column :documents_beznal_schets, :state_note, :text
    add_column :documents_nal_prihods, :state_note, :text
    add_column :documents_nal_rashods, :state_note, :text
  end
end
