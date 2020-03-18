package uk.ac.open.osb.statistics;

import java.io.IOException;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.util.Hashtable;

import javax.management.MBeanServerConnection;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import weblogic.management.jmx.MBeanServerInvocationHandler;

import com.bea.wli.monitoring.ServiceDomainMBean;

/**
 * Invocation handler class for ServiceDomainMBean class.
 * 
 * @author Simon Cutts
 * 
 */
public class ServiceDomainMBeanInvocationHandler implements InvocationHandler {
	private static final String JMX_DOMAIN_RUNTIME = "java:comp/env/jmx/domainRuntime";
	private static final String JNDI_URL = "weblogic.management.mbeanservers.domainruntime";
	private static final String mbeanName = ServiceDomainMBean.NAME;
	private static final String type = ServiceDomainMBean.TYPE;

	private final String protocol = "t3";
	private String hostname = "localhost";
	private int port = 7001;
	private final String jndiRoot = "/jndi/";

	private String username = "weblogic";
	private String password = "welcome1";

	private JMXConnector jmxConnector;
	private Object actualMBean;
	private MBeanServerConnection connection;

	/**
	 * Create an instance of ServiceDomainMBeanInvocationHandler using the
	 * InitialContext. Use when called from within a Java EE module
	 * 
	 * @param context
	 */
	public ServiceDomainMBeanInvocationHandler(InitialContext context) {
		super();

		// Get the MBeanServerConnection
		try {
			connection = (MBeanServerConnection) context
					.lookup(JMX_DOMAIN_RUNTIME);
		} catch (NamingException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Create an instance of ServiceDomainMBeanInvocationHandler. Use when
	 * called from outside a Java EE module
	 * 
	 * @param hostName
	 * @param port
	 * @param userName
	 * @param password
	 */
	public ServiceDomainMBeanInvocationHandler(String hostName, int port,
			String userName, String password) {
		this.hostname = hostName;
		this.port = port;
		this.username = userName;
		this.password = password;

		// Get the MBeanServerConnection
		try {
			jmxConnector = initConnection();
			connection = jmxConnector.getMBeanServerConnection();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Invokes specified method with specified params on specified object.
	 * 
	 * @param proxy
	 * @param method
	 * @param args
	 * @return
	 * @throws Throwable
	 */
	@Override
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		if (actualMBean == null) {
			actualMBean = findServiceDomain(connection, mbeanName, type, null);
		}
		return method.invoke(actualMBean, args);
	}

	/**
	 * Gets JMX connection
	 * 
	 * @return JMX connection
	 * @throws IOException
	 * @throws MalformedURLException
	 */
	private JMXConnector initConnection() throws IOException,
			MalformedURLException {
		JMXServiceURL serviceURL = new JMXServiceURL(protocol, hostname, port,
				jndiRoot + JNDI_URL);
		Hashtable<String, String> h = new Hashtable<String, String>();

		if (username != null) {
			h.put(Context.SECURITY_PRINCIPAL, username);
		}
		if (password != null) {
			h.put(Context.SECURITY_CREDENTIALS, password);
		}

		h.put(JMXConnectorFactory.PROTOCOL_PROVIDER_PACKAGES,
				"weblogic.management.remote");
		return JMXConnectorFactory.connect(serviceURL, h);
	}

	/**
	 * Finds the specified MBean object
	 * 
	 * @param connection
	 *            - A connection to the MBeanServer.
	 * @param mbeanName
	 *            - The name of the MBean instance.
	 * @param mbeanType
	 *            - The type of the MBean.
	 * @param parent
	 *            - The name of the parent Service. Can be NULL.
	 * @return Object - The MBean or null if the MBean was not found.
	 * @throws MalformedObjectNameException
	 */

	private Object findServiceDomain(MBeanServerConnection connection,
			String mbeanName, String mbeanType, String parent)
			throws MalformedObjectNameException {
		ServiceDomainMBean serviceDomainbean = null;

		ObjectName on = new ObjectName(ServiceDomainMBean.OBJECT_NAME);
		serviceDomainbean = (ServiceDomainMBean) MBeanServerInvocationHandler
				.newProxyInstance(connection, on);

		return serviceDomainbean;
	}
}