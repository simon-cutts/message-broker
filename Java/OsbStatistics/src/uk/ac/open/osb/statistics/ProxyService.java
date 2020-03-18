package uk.ac.open.osb.statistics;

/**
 * ProxyService implementation of ServiceStatitic
 * 
 * @author Simon Cutts
 * 
 */
public class ProxyService extends ServiceStatistic {

	@Override
	protected String getSuffix() {
		return ".proxy";
	}

	@Override
	protected ServiceStatistic instance() {
		return new ProxyService();
	}
}
