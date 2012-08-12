class AddOthersToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :name, :string
    add_column :customers, :tel, :string
    add_column :customers, :address, :string
    add_column :customers, :comp_name, :string
    add_column :customers, :info, :text
  end
end
