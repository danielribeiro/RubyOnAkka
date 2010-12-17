require 'akka'
Actors.spawn { |m| puts "!!! Acted on: #{m}" }.sendOneWay "hello actor world"
Actors.delayedShutdown 1