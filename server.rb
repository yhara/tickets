require 'rubygems'
require 'ramaze'
require 'model/ticket'

class MainController < Ramaze::Controller
  def index
  end
end

class TicktesController < Ramaze::Controller
  map '/tickets'
  deny_layout :all

  def create
    ticket = Ticket.new
    ticket.save

    "(id . #{ticket.id})"
  end

  def list
    #Ticket.new(:title => "foo", :importance => 0, :emergency => 0).save
    #Ramaze::Log.debug Ticket.new(:title => "bar").save

    '(' +
    Ticket.all.map{|ticket|
      "(#{ticket.id} #{ticket.title.inspect} #{ticket.emergency} #{ticket.importance})"
    }.join(' ') +
    ')'
  end

  def move
    raise "must be via POST" unless request.post?

    ticket = Ticket.find(:id => request["id"])
    raise "ticket not found" unless ticket

    ticket.update(:emergency => request["x"],
                  :importance => request["y"])
    "#t"
  end

end

Ramaze.start
