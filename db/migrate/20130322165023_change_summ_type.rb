class ChangeSummType < ActiveRecord::Migration
  def up
    [:documents_beznal_schets, :documents_beznal_rashods, :documents_nal_prihods, :documents_nal_rashods].each do |t|
      change_column t, :summ, :decimal, :precision => 12, :scale => 2
    end

  end

  def down
    [:documents_beznal_schets, :documents_beznal_rashods, :documents_nal_prihods, :documents_nal_rashods].each do |t|
      change_column t, :summ, :integer
    end
  end
end
