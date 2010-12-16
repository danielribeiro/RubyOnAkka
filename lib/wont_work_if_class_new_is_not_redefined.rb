require 'java'
module Akka
  include_package 'se.scalablesolutions.akka.actor'
end

class PingActor < Akka::UntypedActor
  def onReceive(message)
    puts "!!! Acted on: #{message}"
  end
end

actor = Akka::UntypedActor.actorOf(PingActor).start()
actor.sendOneWay("hello actor world")

require 'pp'
sleep 1
Akka::ActorRegistry.shutdownAll()