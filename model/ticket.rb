require 'sequel'
require 'sequel/extensions/migration'
Sequel::Model.plugin(:schema) # for table_exists?

$db = Sequel.sqlite(Tickets::Config::DB_PATH)

class Ticket < Sequel::Model(:tickets)

#  def self.add(title, content)
#    create :title => title, :content => content,
#      :created => Time.now, :updated => Time.now
#  end
#
#  def update(title = title, content = content)
#    self.title, self.content, self.updated = title, content, Time.now
#    save
#  end
end

unless Ticket.table_exists?
  migration_dir = File.expand_path("../db/migrate/",
                                   File.dirname(__FILE__))
  Sequel::Migrator.apply($db, migration_dir)
end
