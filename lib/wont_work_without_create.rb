require 'java'
module Akka
  include_package 'se.scalablesolutions.akka.actor'
end

class PingActor < Akka::UntypedActor
  # Must be like this. initialize will not work
#  def self.new(name)
#    ret = super()
#    ret.instance_variable_set(:@name, name)
#    ret
#  end

  def initialize(name)
    @name = name
  end

  def self.create(*args)
    self.new(*args)
  end
  
  def onReceive(message)
    puts "!!! I(#{@name}) Acted on: #{message}"
  end
end

actor = Akka::UntypedActor.actorOf { PingActor.new('lala') }.start()
actor.sendOneWay("hello actor world")

sleep 1
Akka::ActorRegistry.shutdownAll()
