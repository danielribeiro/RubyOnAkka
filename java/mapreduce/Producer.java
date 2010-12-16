package mapreduce;

import java.util.List;

import se.scalablesolutions.akka.actor.ActorRef;
import se.scalablesolutions.akka.actor.UntypedActor;

@SuppressWarnings("unchecked")
public class Producer extends UntypedActor {
	private List<String> input;
	private ActorRef mapActor;

	public Producer(ActorRef mapActor, List<String> input) {
		this.mapActor = mapActor;
		this.input = input;

	}

	@Override
	public void onReceive(Object arg0) throws Exception {
		for (String line : input) {
			mapActor.sendOneWay(line);
		}
	}

}
