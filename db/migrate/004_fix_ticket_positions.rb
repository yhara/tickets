require 'model/ticket.rb'

class FixTicketPositions < Sequel::Migration
  def up
    Ticket.each do |ticket|
      x = ticket.emergency
      y = ticket.importance
      
      x -= 300
      y -= 300
      ticket.update(:emergency => x, :importance => y)
    end
  end

  def down
    Ticket.each do |ticket|
      x = ticket.emergency
      y = ticket.importance

      x += 300
      y += 300
      ticket.update(:emergency => x, :importance => y)
    end
  end
end
