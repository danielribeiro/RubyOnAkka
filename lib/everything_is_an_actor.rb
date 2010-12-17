require 'akka'
class HelloWord
  def hi
    puts "hello actor world"
  end
end
Actors.actorOf(HelloWord.new).hi
Actors.delayedShutdown 1