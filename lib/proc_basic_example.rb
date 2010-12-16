require 'akka'
actor = Actors.spawn do |message|
  puts "!!! Acted on: #{message}"
end
actor.sendOneWay "hello actor world"
sleep 1
Akka::ActorRegistry.shutdownAll