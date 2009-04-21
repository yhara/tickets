class AddTimeoutedToTickets < Sequel::Migration
  def up
    alter_table :tickets do
      add_column :timeouted, :boolean, :null => false, :default => false
    end
  end

  def down
    alter_table :tickets do
      drop_column :timeouted
    end
  end
end
