require 'rubygems'
require 'ramaze'
require 'model/ticket'

class MainController < Ramaze::Controller
  def index
  end
end

class TicktesController < Ramaze::Controller
  map '/tickets'

  def list
    #Ticket.new(:title => "foo", :importance => 0, :emergency => 0).save
    #Ramaze::Log.debug Ticket.new(:title => "bar").save
    Ticket.all.inspect
  end
end

Ramaze.start
