package uk.ac.open.osb.statistics;

/**
 * Abstract parent holding the statistics about an OSB service. Used to store
 * statistics and then print out as simple Strings
 * 
 * @author Simon Cutts
 * 
 */
public abstract class ServiceStatistic implements Comparable<ServiceStatistic> {
	/**
	 * Empyt pad of whitespace to format lines of the report
	 */
	private static final String PAD = "                                                  ";

	private String service;
	private long message;
	private long error;
	private long responseMin;
	private long responseMax;
	private long responseAvg;
	private long successRate;
	private long failureRate;
	private long validationErrors;
	private long wssErrors;

	/**
	 * Get the suffix of the service, i.e .proxy or .biz
	 * 
	 * @return
	 */
	protected abstract String getSuffix();

	/**
	 * Create and instance of the class, but leave it to the implementing class
	 * to dtermine the concrete type
	 * 
	 * @return
	 */
	protected abstract ServiceStatistic instance();
		
	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public long getMessage() {
		return message;
	}

	public void setMessage(long message) {
		this.message = message;
	}

	public long getError() {
		return error;
	}

	public void setError(long error) {
		this.error = error;
	}

	public long getResponseMin() {
		return responseMin;
	}

	public void setResponseMin(long responseMin) {
		this.responseMin = responseMin;
	}

	public long getResponseMax() {
		return responseMax;
	}

	public void setResponseMax(long responseMax) {
		this.responseMax = responseMax;
	}

	public long getResponseAvg() {
		return responseAvg;
	}

	public void setResponseAvg(long responseAvg) {
		this.responseAvg = responseAvg;
	}

	public long getSuccessRate() {
		return successRate;
	}

	public void setSuccessRate(long successRate) {
		this.successRate = successRate;
	}

	public long getFailureRate() {
		return failureRate;
	}

	public void setFailureRate(long failureRate) {
		this.failureRate = failureRate;
	}

	public long getValidationErrors() {
		return validationErrors;
	}

	public void setValidationErrors(long validationErrors) {
		this.validationErrors = validationErrors;
	}

	public long getWssErrors() {
		return wssErrors;
	}

	public void setWssErrors(long wssErrors) {
		this.wssErrors = wssErrors;
	}

	/**
	 * String containing the report title
	 * 
	 * @return
	 */
	public static String title() {
		StringBuffer buf = new StringBuffer(pad("", 50));
		buf.append(pad("Message", 9));
		buf.append(pad("Error", 9));
		buf.append(pad("Minimum", 9));
		buf.append(pad("Maximum", 9));
		buf.append(pad("Average", 9));
		buf.append(pad("Success", 9));
		buf.append(pad("Failure", 9));
		buf.append(pad("Validate", 9));
		buf.append(pad("WSS", 9) + "\n");

		buf.append(pad("Service", 50));
		buf.append(pad("Count", 9));
		buf.append(pad("Count", 9));
		buf.append(pad("Resp ms", 9));
		buf.append(pad("Resp ms", 9));
		buf.append(pad("Resp ms", 9));
		buf.append(pad("%", 9));
		buf.append(pad("%", 9));
		buf.append(pad("Error", 9));
		buf.append(pad("Error", 9));

		return buf.toString();
	}

	/**
	 * String containing the report line
	 * 
	 * @return
	 */
	public String reportLine() {
		StringBuffer buf = new StringBuffer(pad(shortService(), 50));
		buf.append(pad(message, 9));
		buf.append(pad(error, 9));
		buf.append(pad(getResponseMin(), 9));
		buf.append(pad(getResponseMax(), 9));
		buf.append(pad(getResponseAvg(), 9));
		buf.append(pad(successRate, 9));
		buf.append(pad(failureRate, 9));
		buf.append(pad(validationErrors, 9));
		buf.append(pad(wssErrors, 9));
		return buf.toString();
	}

	/**
	 * Assign the count statistics
	 * 
	 * @param name
	 * @param count
	 */
	public void assignCountStats(String name, long count) {
		if (name.equals("success-rate")) {
			setSuccessRate(count);

		} else if (name.equals("failure-rate")) {
			setFailureRate(count);

		} else if (name.equals("error-count")) {
			setError(count);

		} else if (name.equals("validation-errors")) {
			setValidationErrors(count);

		} else if (name.equals("wss-error")) {
			setWssErrors(count);

		} else if (name.equals("message-count")) {
			setMessage(count);
		}
	}

	@Override
	public String toString() {
		return "ServiceStatistic [service=" + service + ", message=" + message
				+ ", error=" + error + ", responseMin=" + responseMin
				+ ", responseMax=" + responseMax + ", responseAvg="
				+ responseAvg + ", successRate=" + successRate
				+ ", failureRate=" + failureRate + ", validationErrors="
				+ validationErrors + ", wssErrors=" + wssErrors + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((service == null) ? 0 : service.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		ServiceStatistic other = (ServiceStatistic) obj;
		if (service == null) {
			if (other.service != null) {
				return false;
			}
		} else if (!service.equals(other.service)) {
			return false;
		}
		return true;
	}

	@Override
	public int compareTo(ServiceStatistic o) {
		return this.shortService().compareTo(o.shortService());
	}


	/**
	 * Get the short service name with suffix, muinus the full pathname
	 * 
	 * @return
	 */
	private String shortService() {
		int last = service.lastIndexOf('/') + 1;
		return service.substring(last) + getSuffix();
	}

	/**
	 * Pad out an item to the required length
	 * 
	 * @param item
	 * @param length
	 * @return
	 */
	private static String pad(long item, int length) {
		return pad("" + item, length);
	}

	/**
	 * Pad out an item to the required length
	 * 
	 * @param item
	 * @param length
	 * @return
	 */
	private static String pad(String item, int length) {
		int padStart = item.length();
		return item + PAD.substring(padStart, length);
	}
}
