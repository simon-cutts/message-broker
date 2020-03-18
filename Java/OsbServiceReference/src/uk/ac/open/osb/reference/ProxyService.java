package uk.ac.open.osb.reference;


/**
 * Representation of an OSB proxy service
 * 
 * @author Simon Cutts
 * 
 */
public class ProxyService extends Resource {

	public ProxyService(String structure) {
		super(structure);
		type = getType();
	}

	@Override
	public String getType() {
		return "Proxy";
	}

}
