package uk.ac.open.osb.statistics.web;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import uk.ac.open.osb.statistics.CollectorTask;
import uk.ac.open.osb.statistics.Log;

/**
 * Initiates the collection of Statistics from the OSB. Needs to be deployed to
 * the Admin server, otherwise the ServiceDomainMBean cannot be generated from
 * the InitialContext
 * 
 * @author Simon Cutts
 * 
 */
public class SessionLifeCycleEvent implements ServletContextListener {
	private Timer timer;

	/**
	 * Start the CollectorTask Timer
	 */
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		Log.info("Statistics Collector starting");

		String directory = sce.getServletContext()
				.getInitParameter("directory");

		timer = CollectorTask.getTimer(directory);
	}

	/**
	 * Stop the CollectorTask Timer
	 */
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		if (timer != null) {
			timer.cancel();
		}
		Log.info("Statistics Collector stopped");
	}
}
