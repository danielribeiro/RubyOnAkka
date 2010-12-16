package mapreduce;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FileUtils;

import se.scalablesolutions.akka.actor.ActorRef;
import se.scalablesolutions.akka.actor.UntypedActor;
import se.scalablesolutions.akka.actor.UntypedActorFactory;

public class Main {
	public static void main(String[] args) throws Exception {
		@SuppressWarnings("unchecked")
		final List<String> input = FileUtils.readLines(new File("shakespeare.txt"));
		final int size = input.size();
		final ActorRef reducerActor = UntypedActor.actorOf(new UntypedActorFactory() {
			  public UntypedActor create() {
				    return new ReduceActor(size);
				   }
				});
		
		final ActorRef mapActor = UntypedActor.actorOf(new UntypedActorFactory() {
			  public UntypedActor create() {
			    return new MapActor(reducerActor);
			   }
			});
		
		final ActorRef producer = UntypedActor.actorOf(new UntypedActorFactory() {
			  public UntypedActor create() {
			    return new Producer(mapActor, input);
			   }
			});
		for (ActorRef actor : Arrays.asList(reducerActor, mapActor, producer)) {
			actor.start();
		}
		producer.sendOneWay("start");
	}
}
