require 'akka'
class PingActor < Actors::Base
  def onReceive(message)
    puts "!!! Acted on: #{message}"
  end
end
actor = PingActor.spawn
actor.sendOneWay "hello actor world"
sleep 1
Akka::ActorRegistry.shutdownAll