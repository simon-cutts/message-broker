package uk.ac.open.osb.dependency;

import java.lang.reflect.Proxy;

import uk.ac.open.osb.statistics.ServiceDomainMBeanInvocationHandler;

import com.bea.wli.config.Ref;
import com.bea.wli.config.task.impl.DependencyQueryTask;
import com.bea.wli.monitoring.MonitoringException;
import com.bea.wli.monitoring.ServiceDomainMBean;

public class Dependency {
	private String hostname;
	private int port;
	private String username;
	private String password;
	private ServiceDomainMBean serviceDomainMbean;

	public Dependency(String hostname, int port, String username,
			String password) {
		super();
		this.hostname = hostname;
		this.port = port;
		this.username = username;
		this.password = password;
		createServiceDomainMBean();
	}


	private void createServiceDomainMBean() {
		ServiceDomainMBeanInvocationHandler handler = new ServiceDomainMBeanInvocationHandler(
				hostname, port, username, password);

		Object proxy = Proxy.newProxyInstance(
				ServiceDomainMBean.class.getClassLoader(),
				new Class[] { ServiceDomainMBean.class }, handler);

		serviceDomainMbean = (ServiceDomainMBean) proxy;
	}

	public void depedents() throws MonitoringException {
		Ref[] proxies = serviceDomainMbean.getMonitoredProxyServiceRefs();
		Ref[] parents = serviceDomainMbean.getMonitoredProxyServiceRefs();
		DependencyQueryTask t = new DependencyQueryTask(null);
		for (Ref ref : proxies) {
			System.out.println(ref.getLocalName());
			getDependents(ref, parents);
		}

	}

	private void getDependents(Ref proxy, Ref[] proxies) {
		for (Ref ref : proxies) {
			if (proxy.isDescendantOf(ref)) {
				System.out.println(ref.getLocalName() + " is descendent of "
						+ ref.getLocalName());
			}
		}
	}

	public static void main(String[] args) {
		Dependency d = new Dependency("soa-dev-1.open.ac.uk", 7001, "devadmin",
				"devadmin$");
		try {
			d.depedents();
		} catch (MonitoringException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
