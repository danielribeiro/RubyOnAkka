require 'akka'
require 'pp'

# Implementation of Vicktor Lang's suggestion:  http://groups.google.com/group/akka-user/browse_thread/thread/c7a3c7076218ab60
class StopActor < Actors::Base
  def initialize
    @whenDone = nil
  end

  def onReceive(message)
    if message == :NotifyMeWhenDone
      @whenDone = getContext.getSenderFuture
    else
      @whenDone.get.completeWithResult('Done!!!')
      getContext.stop
    end
  end
end

main = StopActor.spawn
future = main.sendRequestReplyFuture :NotifyMeWhenDone
main.sendOneWay "you are done"
future.await
if future.isCompleted
  resultOption = future.result
  if resultOption.isDefined
    result = resultOption.get
    puts "Result is #{result}"
  end
end
# the actor stops itself. no need for: Akka::ActorRegistry.shutdownAll()