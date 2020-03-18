package uk.ac.open.osb.reference;

import java.util.Collection;
import java.util.HashMap;

/**
 * Abstract parent of all OSB resources
 * 
 * @author Simon Cutts
 * 
 */
public abstract class Resource {
	private static final String PAD = "  ";
	private static final ResourceFactory SERVICE_FACTORY = ResourceFactory
			.getInstance();
	private static int uniqueIdCount = 1;

	private String structure;
	private String name;
	private String uniqueId;
	protected String type;

	// All resources that this resource instnace references
	private HashMap<String, Resource> references = new HashMap<String, Resource>();

	// Other resource instances that reference this resource
	private HashMap<String, Resource> referencedBy = new HashMap<String, Resource>();

	/**
	 * Instantiate a Resource with the structure (full pathname) of the resource
	 * 
	 * @param structure
	 */
	protected Resource(String structure) {
		super();
		this.structure = structure;

		// Assign a unique id
		uniqueId = "N" + uniqueIdCount++;

		// Build the name from the last occurrence of '/'
		name = structure.substring(structure.lastIndexOf("/") + 1);
	}

	public String getStructure() {
		return structure;
	}

	public String getUniqueId() {
		return uniqueId;
	}

	public String getName() {
		return name;
	}

	public abstract String getType();

	/**
	 * Create a reference in this resource to the resource passed in
	 * 
	 * @param resource
	 * @return
	 */
	public Resource ref(Resource resource) {
		// Do not reference this resource if it is excluded
		// if (SERVICE_FACTORY.exclude(resource)) {
		// return resource;
		// }
		Resource s = SERVICE_FACTORY.get(resource);
		references.put(s.getStructure(), s);
		s.refBy(this);
		return s;
	}

	public boolean hasRefs() {
		return references.size() > 0;
	}

	public Collection<Resource> references() {
		return references.values();
	}

	/**
	 * Record the resource that this service is referenced by
	 * 
	 * @param s
	 */
	public void refBy(Resource s) {
		referencedBy.put(s.getStructure(), s);
	}

	public String cypherNode() {
		return "CREATE (" + getUniqueId() + ":" + getType() + " {name:'"
				+ getName()
				+ "', structure:'" + getStructure() + "'})";
	}

	public String toString() {
		return printRef();
	}

	public String printRef() {
		String str = structure;
		if (references.size() > 0) {
			for (Resource s : references.values()) {
				str += "\n" + s.printRef(PAD);
			}
		}
		return str;
	}

	public String printRefBy() {
		String str = structure;
		if (referencedBy.size() > 0) {
			for (Resource s : referencedBy.values()) {
				str += "\n" + s.printRefBy(PAD);
			}
		}
		return str;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((structure == null) ? 0 : structure.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Resource other = (Resource) obj;
		if (structure == null) {
			if (other.structure != null)
				return false;
		} else if (!structure.equals(other.structure))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	private String printRef(String pad) {
		String str = pad + structure;
		if (references.size() > 0) {
			for (Resource s : references.values()) {
				str += "\n" + s.printRef(pad + PAD);
			}
		}
		return str;
	}

	private String printRefBy(String pad) {
		String str = pad + structure;
		if (referencedBy.size() > 0) {
			for (Resource s : referencedBy.values()) {
				str += "\n" + s.printRefBy(pad + PAD);
			}
		}
		return str;
	}
}
