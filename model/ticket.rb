require 'sequel'
require 'sequel/extensions/migration'
Sequel::Model.plugin(:schema) # for table_exists?

$db = Sequel.sqlite(Tickets::Config::DB_PATH)

class Ticket < Sequel::Model(:tickets)
  @@last_shook = Time.now

  def self.needs_shaking?
    (Time.now - @@last_shook) > 5 #Tickets::Config::SHAKE_INTERVAL*60*60
  end

  def self.shake!
    Ticket.each do |ticket|
      pos = ticket.emergency
      center = Tickets::Config::BOARD_HEIGHT / 2
      dir = (ticket.importance < center ? 1 : -1)
      newpos = pos + Tickets::Config::SHAKE_DISTANCE * dir

      ticket.update(:emergency => newpos)
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
