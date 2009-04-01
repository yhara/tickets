class AddDeletedToTickets < Sequel::Migration
  def up
    alter_table :tickets do
      add_column :deleted, :boolean, :null => false, :default => false
    end
  end

  def down
    alter_table :tickets do
      drop_column :deleted
    end
  end
end
