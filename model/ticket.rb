require 'sequel'

DB = Sequel.sqlite("db/tickets.db")

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

Sequel::Migrator.apply(DB, "./db/migrate/") unless Ticket.table_exists?
