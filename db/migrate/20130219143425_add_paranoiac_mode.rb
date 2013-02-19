class AddParanoiacMode < ActiveRecord::Migration
  def up
    [:events, :clients, :companies,
     :company_members, :couriers_companies,
     :couriers_company_members, :couriers_tasks,
     :users, :documents_beznal_rashods, :documents_beznal_schets,
     :documents_nal_prihods, :documents_nal_rashods].each do |table|
      add_column table, :deleted_at, :time
      add_index table, :deleted_at
    end

    [:clients, :companies, :company_members, :couriers_companies, :couriers_tasks].each do |table|
      add_index table, :name
    end

    add_index :events, [:user_id, :company_id, :archived]
    add_index :company_members, :company_id
    add_index :couriers_company_members, :couriers_company_id
    add_index :couriers_tasks, :user_id

    [:documents_beznal_rashods, :documents_beznal_schets,
      :documents_nal_prihods, :documents_nal_rashods].each do |table|
      add_index table, [:user_id, :event_id]
    end

  end

  def down

    [:documents_beznal_rashods, :documents_beznal_schets,
     :documents_nal_prihods, :documents_nal_rashods].each do |table|
      remove_index table, [:user_id, :event_id]
    end


    remove_index :events, [:user_id, :company_id, :archived]
    remove_index :company_members, :company_id
    remove_index :couriers_company_members, :couriers_company_id
    remove_index :couriers_tasks, :user_id

    [:clients, :companies, :company_members, :couriers_companies, :couriers_tasks].each do |table|
      remove_index table, :name
    end

    [:events, :clients, :companies,
     :company_members, :couriers_companies,
     :couriers_company_members, :couriers_tasks,
     :users, :documents_beznal_rashods, :documents_beznal_schets,
     :documents_nal_prihods, :documents_nal_rashods].each do |table|
      remove_index table, :deleted_at
      remove_column table, :deleted_at
    end
  end
end
