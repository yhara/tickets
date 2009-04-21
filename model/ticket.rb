require 'sequel'
require 'sequel/extensions/migration'
Sequel::Model.plugin(:schema) # for table_exists?

$db = Sequel.sqlite(Tickets::Config::DB_PATH)

class Ticket < Sequel::Model(:tickets)
  @@last_shook = Time.now

  def self.needs_shaking?
    (Time.now - @@last_shook) > Tickets::Config::SHAKE_INTERVAL*60*60
  end

  def self.shake!
    Ticket.each do |ticket|
      pos = ticket.emergency
      center = Tickets::Config::BOARD_HEIGHT / 2
      dir = (ticket.importance < center ? 1 : -1)
      newpos = pos + Tickets::Config::SHAKE_DISTANCE * dir
      newpos %= Tickets::Config::BOARD_WIDTH

      ticket.update(:emergency => newpos)
      if newpos < 0
        ticket.update(:deleted => true)
      end
      ticket.save
    end
    @@last_shook = Time.now
  end
end

unless Ticket.table_exists?
  migration_dir = File.expand_path("../db/migrate/",
                                   File.dirname(__FILE__))
  Sequel::Migrator.apply($db, migration_dir)
end
