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
    tickets = Ticket.filter(:deleted => false).all

    '(' +
    tickets.map{|ticket|
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

  def rename
    raise "must be via POST" unless request.post?
    ticket = Ticket.find(:id => request["id"])
    raise "ticket not found" unless ticket

    ticket.update(:title => request["title"])
    "#t"
  end
end

Ramaze.start
