package uk.ac.open.osb.servicematrix;


/**
 * Links server with requested URL and holds a count. The primary object of
 * interest is this source of the URL request and the number of times it has
 * been sent
 * 
 * @author Simon Cutts
 * 
 */
public class UrlSource {
	private String server;
	private int count = 1;
	private String url;

	/**
	 * Create an instance of UrlSource
	 * 
	 * @param req
	 */
	public UrlSource(Line req) {
		server = req.getServer();
		url = req.getUrl();
	}

	public String getKey() {
		return url + server;
	}

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getCount() {
		return count;
	}

	/**
	 * Increment the count for every sourceIp and URL combination encountered
	 * 
	 * @return
	 */
	public int increment() {
		return ++count;
	}

	@Override
	public String toString() {
		return "UrlSource [url=" + url + ", server=" + server + ", count="
				+ count + "]";
	}
}
