require 'akka'
class HelloWord
  def hi
    puts "hello actor world"
  end
end
o = Actors.actorOf HelloWord.new
o.hi
sleep 1
Akka::ActorRegistry.shutdownAll