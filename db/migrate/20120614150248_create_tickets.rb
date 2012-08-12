class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :token
      t.boolean :active, :default => false
      t.boolean :visible, :default => true
      t.string :expire_start_at
      t.string :expire_end_at

      t.timestamps
    end
  end
end
