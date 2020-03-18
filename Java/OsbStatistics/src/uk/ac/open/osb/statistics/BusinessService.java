package uk.ac.open.osb.statistics;

/**
 * BusinessService implementation of ServiceStatitic
 * 
 * @author Simon Cutts
 * 
 */
public class BusinessService extends ServiceStatistic {

	@Override
	protected String getSuffix() {
		return ".biz";
	}

	@Override
	protected ServiceStatistic instance() {
		return new BusinessService();
	}
}
