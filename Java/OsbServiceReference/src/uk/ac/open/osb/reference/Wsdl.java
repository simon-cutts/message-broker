package uk.ac.open.osb.reference;


/**
 * Representation of a WSDL
 * 
 * @author Simon Cutts
 * 
 */
public class Wsdl extends Resource {

	public Wsdl(String structure) {
		super(structure);
		type = getType();

	}

	@Override
	public String getType() {
		return "Wsdl";
	}
}
