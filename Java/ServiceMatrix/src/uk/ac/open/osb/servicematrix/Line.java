package uk.ac.open.osb.servicematrix;

import java.util.Properties;

/**
 * Single request line in a Netscaler log. Only captures some items. Converts IP
 * addresses into server names
 * 
 * @author Simon Cutts
 * 
 */
public class Line {
	private String sourceIp;
	private String targetIp;
	private String targetPort;
	private String url;
	private static Properties servers;

	static {
		servers = new Properties();
		servers.put("137.108.140.74", "possom.open.ac.uk");
		servers.put("137.108.170.131", "mongoose.open.ac.uk");
		servers.put("137.108.141.173", "deer.open.ac.uk");
		servers.put("137.108.140.118", "baycat.open.ac.uk");
		servers.put("137.108.140.126", "wildcat.open.ac.uk");
		servers.put("137.108.141.75", "cougar.open.ac.uk");
		servers.put("137.108.141.76", "polecat.open.ac.uk");
		servers.put("137.108.141.81", "ratty.open.ac.uk");
		servers.put("137.108.141.185", "dumbbell.open.ac.uk");
		servers.put("137.108.141.192", "redbell.open.ac.uk");
		servers.put("137.108.141.193", "whitebell.open.ac.uk");
		servers.put("137.108.141.184", "doorbell.open.ac.uk");
		servers.put("137.108.170.125", "csr-iweb-live-a.open.ac.uk");
		servers.put("137.108.170.127", "csr-iweb-live-b.open.ac.uk");
	}

	public String getKey() {
		return getUrl() + getServer();
	}

	public String getSourceIp() {
		return sourceIp;
	}

	public String getServer() {
		return servers.getProperty(sourceIp) == null ? sourceIp : servers.getProperty(sourceIp) ;
	}

	public void setSourceIp(String sourceIp) {
		this.sourceIp = sourceIp;
	}

	public String getTargetIp() {
		return targetIp;
	}

	public void setTargetIp(String targetIp) {
		this.targetIp = targetIp;
	}

	public String getTargetPort() {
		return targetPort;
	}

	public void setTargetPort(String targetPort) {
		this.targetPort = targetPort;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "Request [sourceIp=" + sourceIp + ", targetIp=" + targetIp
				+ ", url=" + url + "]";
	}
}
