package uk.ac.open.osb.reference;


/**
 * Representation of an OSB biz service
 * 
 * @author Simon Cutts
 * 
 */
public class BizService extends Resource {

	public BizService(String structure) {
		super(structure);
		type = getType();

	}

	@Override
	public String getType() {
		return "Biz";
	}
}
