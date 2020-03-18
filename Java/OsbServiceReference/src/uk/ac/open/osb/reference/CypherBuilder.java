package uk.ac.open.osb.reference;

import java.util.Collection;

public class CypherBuilder {

	// CREATE (B1:Biz {name:'MyBiz1'})
	public String createNodes(Collection<Resource> services) {
		StringBuffer buf = new StringBuffer();
		if (services.size() == 0) {
			return buf.toString();
		}
		for (Resource s : services) {
			buf.append(s.cypherNode() + "\n");
		}
		return buf.toString();
	}

	// CREATE (p)-[:REFERENCES]->(b)
	public String createRelationships(Collection<Resource> services) {
		StringBuffer buf = new StringBuffer();
		if (services.size() == 0) {
			return buf.toString();
		}
		for (Resource s : services) {

			Collection<Resource> refs = s.references();
			for (Resource r : refs) {
				buf.append("CREATE (" + s.getUniqueId() + ")-[:refs]->("
						+ r.getUniqueId() + ")\n");
			}
		}
		return buf.toString();
	}

}
