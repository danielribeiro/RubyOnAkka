package mapreduce;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import se.scalablesolutions.akka.actor.ActorRegistry;
import se.scalablesolutions.akka.actor.UntypedActor;

@SuppressWarnings("unchecked")
public class ReduceActor extends UntypedActor {
	private int linesToRead;
	private long start;
	private Map<String, Integer> values;

	public ReduceActor(int linesToRead) {
		this.linesToRead = linesToRead;
		this.start = System.currentTimeMillis();
		this.values = new HashMap<String, Integer>();
	}

	@Override
	public void onReceive(Object message) throws Exception {
		linesToRead--;
		Map<String, Integer> hash = (Map<String, Integer>) message;
		for (Entry<String, Integer> entry : hash.entrySet()) {
			String key = entry.getKey();
			Integer cur = values.get(key);
			if (cur == null) {
				values.put(key, entry.getValue());
			} else {
				values.put(key, cur + entry.getValue());
			}
		}
		if (linesToRead == 0) {
			long finish = System.currentTimeMillis();
			Integer value = values.get("shakespeare");
			System.out
					.println(">> All over: Just to say we used any computed value: "
							+ value);
			System.out.printf("Took %.2f s \n", (finish + 0.0 - start) / 1000);
			ActorRegistry.shutdownAll();
		}
	}
}
