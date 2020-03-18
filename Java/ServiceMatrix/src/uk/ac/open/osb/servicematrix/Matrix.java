package uk.ac.open.osb.servicematrix;

import java.util.HashMap;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 * Collects a matrix of servers with requested URLs
 * 
 * @author Simon Cutts
 * 
 */
public class Matrix {
	HashMap<String, UrlSource> map = new HashMap<String, UrlSource>();
	private int count = 0;

	/**
	 * Add a Request to the Matrix using a Line from the log
	 * 
	 * @param req
	 */
	public void add(Line req) {
		UrlSource urlSource = map.get(req.getKey());
		if (urlSource == null) {
			map.put(req.getKey(), new UrlSource(req));
		} else {
			count = urlSource.increment();
		}
	}

	@Override
	public String toString() {
		StringBuffer buf = new StringBuffer("");
		SortedSet<String> keys = new TreeSet<String>(map.keySet());
		for (String key : keys) {
			UrlSource urlSource = map.get(key);
			buf.append(urlSource + "\n");
		}
		buf.append("\nTotal requests: " + count + "\n");
		return buf.toString();
	}
}
