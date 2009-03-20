class CreateTickets < Sequel::Migration
  def up
    create_table :tickets do
      primary_key :id
      integer   :importance, :null => false, :default => 0
      integer   :emergency,  :null => false, :default => 0
      string    :title,      :null => false, :default => ""
    end
  end

  def down
    drop_table :tickets
  end
end
