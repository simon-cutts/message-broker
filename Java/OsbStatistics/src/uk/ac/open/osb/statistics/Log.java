package uk.ac.open.osb.statistics;

import java.util.Date;

/**
 * Log class that writes out to System.out. When running within Weblogic, the
 * output from this class will be captured in AdminServer.out
 * 
 * @author Simon Cutts
 * 
 */
public class Log {

	private Log() {
	}

	public static void info(String text) {
		System.out.println("<" + new Date().toString() + "> <Information> "
				+ text);
	}

	public static void error(String text) {
		System.out.println("<" + new Date().toString() + "> <Error> " + text);
	}

	public static void main(String[] args) {
		Log.info("hhhh");
		Log.error("hhhh");
	}
}
