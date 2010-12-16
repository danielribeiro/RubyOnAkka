package helloakka;

import java.util.concurrent.TimeUnit;

import se.scalablesolutions.akka.actor.ActorRef;
import se.scalablesolutions.akka.actor.ActorRegistry;
import se.scalablesolutions.akka.actor.UntypedActor;
import se.scalablesolutions.akka.dispatch.Dispatchers;

@SuppressWarnings("unchecked")
public class PingActor extends UntypedActor {
	public static void main(String... args) throws Exception {
		ActorRef actor = actorOf(PingActor.class).start();
		actor.sendOneWay("hello actor world");
		TimeUnit.SECONDS.sleep(1);
		ActorRegistry.shutdownAll();
		Dispatchers.newExecutorBasedEventDrivenWorkStealingDispatcher("pooled-dispatcher");
	}
	
	@Override
	public void onReceive(Object message) throws Exception {
	    if (message instanceof String) {
	    	System.out.println("!!! Acted on: " + message);
	    }
	    else throw new IllegalArgumentException("Unknown message: " + message);
	}
	
}
