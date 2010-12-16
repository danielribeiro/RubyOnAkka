package mapreduce;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;

public class WordCount {
	public Map<String, Integer> count(String str) {
		Map<String, Integer> ret = new HashMap<String, Integer>();
		for (String w : str.split("\\s+")) {
			countWord(ret, w);
		}
		return ret;
	}


	private void countWord(Map<String, Integer> ret, String w) {
		String n = normalize(w);
		if (n.length() == 0) {
			return;
		}
		if (ret.containsKey(n)) {
			ret.put(n, ret.get(n) + 1);
			return;
		}
		ret.put(n, 1);
	}
	private static final String PONCTUATION = "[.,'\":;*\\[\\]!?()/\\\\]";
	private String normalize(String w) {
		return w.toLowerCase().replaceAll("\\B" + PONCTUATION, "").replaceAll(PONCTUATION + "\\B", "").trim();
	}
	
	public static void main(String[] args) throws IOException {
		String str = FileUtils.readFileToString(new File("shakespeare.txt"));
		long start = System.currentTimeMillis();
		Map<String, Integer> out = new WordCount().count(str);
		long finish = System.currentTimeMillis();
		System.out.println(out.get("shakespeare"));
		System.out.printf("Took %.2f s \n", (finish + 0.0 - start) / 1000);
	}
}
