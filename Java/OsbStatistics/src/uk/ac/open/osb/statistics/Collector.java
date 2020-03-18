package uk.ac.open.osb.statistics;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import com.bea.wli.config.Ref;
import com.bea.wli.monitoring.DomainMonitoringDisabledException;
import com.bea.wli.monitoring.MonitoringException;
import com.bea.wli.monitoring.ResourceStatistic;
import com.bea.wli.monitoring.ResourceType;
import com.bea.wli.monitoring.ServiceDomainMBean;
import com.bea.wli.monitoring.ServiceResourceStatistic;
import com.bea.wli.monitoring.StatisticType;
import com.bea.wli.monitoring.StatisticValue;

/**
 * Collect statistics on business and proxy service deployed to a running
 * instance of an OSB. Statistics are collected at a cluster level
 * <p>
 * This class gathers statistics and resets the statistics collection interval
 * in the process. It does not affect the aggregation interval set at the
 * service (business or proxy) level.
 * </p>
 * <p>
 * Operates either within a Java EE module, or as a regular Java class. If
 * within a Java EE module, then uses InitalContext to generate the
 * ServiceDomainMBean
 * </p>
 * <ul>
 * <li>Find business and proxy services enabled for monitoring</li>
 * <li>Get statistics for monitored business and proxy services</li>
 * <li>Reset the collection interval</li>
 * <li>Saves the statistics to a file</li>
 * </ul>
 * 
 * @author Simon Cutts
 * 
 */
public class Collector {
	private ServiceDomainMBean serviceDomainMbean;
	private String directory = "";
	private ArrayList<ServiceStatistic> statsList = new ArrayList<ServiceStatistic>();
	private RotateFile rotateFile;
	private Properties properties;

	/**
	 * Create an instance of Collector to collect statistics
	 * 
	 * @param directory
	 */
	public Collector(String directory) {
		super();
		this.directory = directory;
		Log.info("Statistics Collector started");
	}

	/**
	 * Create and instance of Collector to collect statistics
	 * 
	 * @param props
	 *            Properties required for initialization.
	 */
	public Collector(HashMap<String, String> props) {
		properties = new Properties();
		properties.putAll(props);
		directory = properties.getProperty("directory");
	}

	/**
	 * Print the statistics to file
	 * 
	 * @throws Exception
	 */
	public void print() throws Exception {

		// Always create a new instance of the ServiceDomainMBean in case the
		// server has been stopped
		createServiceDomainMBean();

		// Clear down the statistics list and collect a new lot
		// of figures
		statsList = new ArrayList<ServiceStatistic>();
		Ref[] bizRefs = getStatsOfMonitoredBizServices();
		Ref[] proxyRefs = getStatsOfMonitoredProxyServices();

		// Reset statistics
		Ref[] combined = concat(bizRefs, proxyRefs);
		serviceDomainMbean.resetStatistics(combined);

		// Write the stats to file
		if (rotateFile == null) {
			rotateFile = new RotateFile(directory);
		}

		try {
			// Create the collection information and write it
			String collectionDetail = "\nData collected on "
					+ statsList.size()
					+ " services at "
					+ new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
							.format(new Date()) + "\n\n";
			rotateFile.write(collectionDetail);

			// Write the title to the file
			rotateFile.write(ServiceStatistic.title() + "\n\n");

			// Write a line for every service statistic
			Collections.sort(statsList);
			for (ServiceStatistic ss : statsList) {
				rotateFile.write(ss.reportLine() + "\n");
			}

			// Write out to tag that a statistics collection has taken place
			// System.out.print(collectionDetail);

		} finally {
			rotateFile.flush();
		}
	}

	/**
	 * Retrieve statistics for all business services being monitored in the
	 * cluster
	 * 
	 * @throws Exception
	 */
	private Ref[] getStatsOfMonitoredBizServices() {
		Ref[] serviceRefs = null;
		try {
			serviceRefs = serviceDomainMbean.getMonitoredBusinessServiceRefs();

			// Create a bitwise map for desired resource types.
			int typeFlag = 0;
			typeFlag = typeFlag | ResourceType.SERVICE.value();

			// Get cluster-level statistics.
			HashMap<Ref, ServiceResourceStatistic> resourcesMap;
			resourcesMap = serviceDomainMbean.getBusinessServiceStatistics(
					serviceRefs, typeFlag, null);
			collect(resourcesMap, new BusinessService());

		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (DomainMonitoringDisabledException e) {
			e.printStackTrace();
		} catch (MonitoringException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return serviceRefs;
	}

	/**
	 * Retrieve statistics for all proxy services being monitored in the cluster
	 * 
	 * @throws Exception
	 */
	private Ref[] getStatsOfMonitoredProxyServices() throws Exception {
		Ref[] serviceRefs = null;
		try {
			serviceRefs = serviceDomainMbean.getMonitoredProxyServiceRefs();

			// Create a bitwise map for desired resource types.
			int typeFlag = 0;
			typeFlag = typeFlag | ResourceType.SERVICE.value();

			// Get cluster-level statistics.
			HashMap<Ref, ServiceResourceStatistic> resourcesMap = serviceDomainMbean
					.getProxyServiceStatistics(serviceRefs, typeFlag, null);

			collect(resourcesMap, new ProxyService());
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (DomainMonitoringDisabledException e) {
			e.printStackTrace();
		} catch (MonitoringException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return serviceRefs;
	}

	/**
	 * Saves statistics of all services from the specified map.
	 * 
	 * @param statsMap
	 *            Map containing statistics for one or more services of the same
	 *            type; i.e., business or proxy.
	 * @param resetReqTime
	 *            Reset request time. This information will be written at the
	 *            end of the file, provided it is not zero.
	 * @throws Exception
	 */
	private void collect(HashMap<Ref, ServiceResourceStatistic> statsMap,
			ServiceStatistic serviceStatistic) throws Exception {

		Set<Map.Entry<Ref, ServiceResourceStatistic>> set = statsMap.entrySet();

		// Print statistical information of each service
		for (Map.Entry<Ref, ServiceResourceStatistic> mapEntry : set) {

			ServiceStatistic ss = serviceStatistic.instance();
			statsList.add(ss);
			ss.setService(mapEntry.getKey().getFullName());

			ServiceResourceStatistic serviceStats = mapEntry.getValue();

			ResourceStatistic[] resStatsArray = serviceStats
					.getAllResourceStatistics();
			for (ResourceStatistic resStats : resStatsArray) {

				// Now get and print statistics for this resource
				StatisticValue[] statValues = resStats.getStatistics();
				for (StatisticValue value : statValues) {

					if (value.getName().equals("message-count")
							|| value.getName().equals("error-count")
							|| value.getName().equals("response-time")
							|| value.getName().equals("success-rate")
							|| value.getName().equals("failure-rate")
							|| value.getName().equals("validation-errors")
							|| value.getName().equals("wss-error")
							|| value.getName().equals("message-count")) {

						// Determine statistics type
						if (value.getType() == StatisticType.INTERVAL) {
							StatisticValue.IntervalStatistic is = (StatisticValue.IntervalStatistic) value;

							// Assign interval statistics values
							ss.setResponseMin(is.getMin());
							ss.setResponseMax(is.getMax());
							ss.setResponseAvg(is.getAverage());

						} else if (value.getType() == StatisticType.COUNT) {
							StatisticValue.CountStatistic cs = (StatisticValue.CountStatistic) value;

							// Assign count statistics
							ss.assignCountStats(value.getName(), cs.getCount());
						}
					}
				}
			}
		}
	}

	/**
	 * Creates an instance of ServiceDomainMBean from the weblogic server.
	 * 
	 * @throws Exception
	 */
	private void createServiceDomainMBean() {
		InvocationHandler handler = null;

		// If there are no properties then the class is called within a
		// Java EE module (i.e. web app) so use the InitialContext
		if (properties == null) {
			try {
				handler = new ServiceDomainMBeanInvocationHandler(
						new InitialContext());
			} catch (NamingException e) {
				throw new RuntimeException(e);
			}

			// Otherwise, use the properties because this class is not running
			// within a Java EE module
		} else {
			handler = new ServiceDomainMBeanInvocationHandler(
					properties.getProperty("hostname"),
					Integer.parseInt(properties.getProperty("port")),
					properties.getProperty("username"),
					properties.getProperty("password"));
		}

		Object proxy = Proxy.newProxyInstance(
				ServiceDomainMBean.class.getClassLoader(),
				new Class[] { ServiceDomainMBean.class }, handler);

		serviceDomainMbean = (ServiceDomainMBean) proxy;
	}

	/**
	 * Concatenate arrays
	 * 
	 * @param first
	 * @param second
	 * @return
	 */
	private <T> T[] concat(T[] first, T[] second) {
		T[] result = Arrays.copyOf(first, first.length + second.length);
		System.arraycopy(second, 0, result, first.length, second.length);
		return result;
	}

	/**
	 * Collect statistics on business and proxy service deployed to a running
	 * instance of an OSB. Requires 5 parameters
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
				HashMap<String, String> map = getProperties(args);

				Collector collector = new Collector(map);
				collector.print();

			} else {
				parameterError();

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Standard out error for incorrect parameters
	 */
	static void parameterError() {
		System.err
				.println("Usage: uk.ac.open.osb.statistics.Collector [hostname] "
						+ "[port] [username] [password] optional [directory]");
	}

	/**
	 * Get the a HashMap of the properties from the args
	 * 
	 * @param args
	 * @return
	 */
	static HashMap<String, String> getProperties(String[] args) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("hostname", args[0]);
		map.put("port", args[1]);
		map.put("username", args[2]);
		map.put("password", args[3]);

		// Add the directory, if supplied
		if (args.length == 5) {
			map.put("d" + "irectory", args[4] + "/");
		} else {
			map.put("directory", "");
		}
		return map;
	}
}