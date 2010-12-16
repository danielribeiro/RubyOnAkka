package mapreduce;

import se.scalablesolutions.akka.actor.ActorRef;
import se.scalablesolutions.akka.actor.UntypedActor;

@SuppressWarnings("unchecked")
public class MapActor extends UntypedActor {
	private ActorRef reduceActor;
	private WordCount wordCount;

	public MapActor(ActorRef reduceActor) {
		this.reduceActor = reduceActor;
		this.wordCount = new WordCount();
	}

	@Override
	public void onReceive(Object message) throws Exception {
		reduceActor.sendOneWay(wordCount.count((String) message));	
	}
	
}
