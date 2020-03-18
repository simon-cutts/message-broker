package uk.ac.open.osb.reference;


/**
 * Representation of an XSD
 * 
 * @author Simon Cutts
 * 
 */
public class Xsd extends Resource {

	public Xsd(String structure) {
		super(structure);
		type = getType();

	}

	@Override
	public String getType() {
		return "Xsd";
	}
}
