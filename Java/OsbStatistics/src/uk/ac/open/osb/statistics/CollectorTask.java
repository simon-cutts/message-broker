package uk.ac.open.osb.statistics;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Run the Collector class as a TimerTask
 * 
 * @author Simon Cutts
 * 
 */
public class CollectorTask extends TimerTask {
	private final static long ONE_HOUR_IN_MILLISECONDS = 60 * 60 * 1000;
	private final static long FIVE_MINS_IN_MILLISECONDS = 60 * 5 * 1000;
	private final static long THREE_MINS_IN_MILLISECONDS = 60 * 3 * 1000;
	private final Collector collector;

	/**
	 * Create an instance of CollectorTask with a Collector
	 * 
	 * @param col
	 */
	public CollectorTask(Collector col) {
		collector = col;
	}

	@Override
	public void run() {
		print();
	}

	/**
	 * When cancelled called, always collect the statistics before canceling the
	 * TimerTask
	 */
	@Override
	public boolean cancel() {
		print();
		return super.cancel();
	}

	/**
	 * Print the statistics
	 */
	private void print() {
		try {
			collector.print();
		} catch (Exception e) {
			Log.error(this.getClass().getName());
			StackTraceElement[] stes = e.getStackTrace();
			for (StackTraceElement ste : stes) {
				Log.error(ste.toString());
			}
		}
	}

	/**
	 * Get the Timer controlling the CollectorTask. Used when run as a regular
	 * class outside Java EE module
	 * 
	 * @param map
	 * @return
	 */
	public static Timer getTimer(HashMap<String, String> map) {
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new CollectorTask(new Collector(map)), 0,
				ONE_HOUR_IN_MILLISECONDS);
		return timer;
	}

	/**
	 * Get the Timer controlling the CollectorTask. Used when inside a Java EE
	 * module. The Timer waits 3 minutes before executing, to allow the Weblogic
	 * Lock to be released by the deployment of the WAR file
	 * 
	 * @param directory
	 *            where to write the file
	 * @return
	 */
	public static Timer getTimer(String directory) {
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new CollectorTask(new Collector(directory)),
				THREE_MINS_IN_MILLISECONDS, ONE_HOUR_IN_MILLISECONDS);
		return timer;
	}

	/**
	 * Collect timed statistics on business and proxy service deployed to a
	 * running instance of an OSB. Requires 5 parameters
	 * 
	 * <ul>
	 * <li>hostname</li>
	 * <li>port</li>
	 * <li>username</li>
	 * <li>password</li>
	 * <li>optional report location</li>
	 * </ul>
	 */
	public static void main(String[] args) {
		try {
			if (args.length == 4 || args.length == 5) {
				HashMap<String, String> map = Collector.getProperties(args);

				// long oneMinInMilliSec = 60 * 1000;

				// Start timer.
				getTimer(map);

			} else {
				Collector.parameterError();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
