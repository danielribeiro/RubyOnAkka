require 'akka'
class PingActor < Actors::Base
  def onReceive(message)
    puts "!!! Acted on: #{message}"
  end
end
PingActor.spawn.sendOneWay "hello actor world"
Actors.delayedShutdown 1