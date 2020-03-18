package uk.ac.open.osb.reference;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

/**
 * Factory implementation for all Resources
 * 
 * @author Simon Cutts
 * 
 */
public class ResourceFactory {
	public static final String BIZ_SERVICE = ".BusinessService";
	public static final String PROXY_SERVICE = ".ProxyService";
	public static final String WSDL = ".WSDL";
	public static final String XSD = ".XMLSchema";
	private static final ResourceFactory INSTANCE = new ResourceFactory();

	// A map of all the Resources
	private static final HashMap<String, Resource> RESOURCES = new HashMap<String, Resource>();
	// A map of all the Resources to exclusions
	private static final HashMap<String, Resource> EXCLUSIONS = new HashMap<String, Resource>();

	private ResourceFactory() {
	}

	/**
	 * Get the Singleton instance of ResourceFactory
	 * 
	 * @return
	 */
	public static ResourceFactory getInstance() {
		return INSTANCE;
	}

	public Resource findByStructure(String structure) {
		String noSuffix = stripSuffix(structure);
		return RESOURCES.get(noSuffix);
		// if (s == null) {
		// s = createService(noSuffix);
		// addService(s);
		// }
		// return s;
	}

	public void addExclusion(Resource s) {
		EXCLUSIONS.put(s.getStructure(), s);
	}

	/**
	 * Get Resource, based on name. Retrieves the Resource from the cache. If a
	 * Resource is not found, then creates it
	 * 
	 * @param name
	 * @return
	 */
	public Resource get(Resource service) {
		Resource s = RESOURCES.get(service.getStructure());
		if (s == null) {
			addResource(service);
			return service;
		} else {
			return s;
		}
	}

	/**
	 * Should this Resource be excluded?
	 * 
	 * @param service
	 * @return
	 */
	public boolean exclude(Resource service) {
		Resource s = EXCLUSIONS.get(service.getStructure());
		return (s != null);
	}

	/**
	 * Create a Resource, based on structure.
	 * 
	 * @param structure
	 * @return
	 */
	public Resource createResource(String structure) {
		// if (structure
		// .startsWith("ServiceRepository/Utilities/sams/ValidateSamsToken")) {
		// System.out.println("");
		// }
		String noSuffix = stripSuffix(structure);
		Resource s = RESOURCES.get(noSuffix);
		if (s == null) {
			if (structure.endsWith(PROXY_SERVICE)) {
				s = new ProxyService(noSuffix);
			} else if (structure.endsWith(BIZ_SERVICE)) {
				s = new BizService(noSuffix);
			} else if (structure.endsWith(WSDL)) {
				s = new Wsdl(noSuffix);
			} else if (structure.endsWith(XSD)) {
				s = new Xsd(noSuffix);
			}
			if (s != null) {
				addResource(s);
			}
		}
		return s;
	}

	/**
	 * Get all the Resources held in this factory
	 * 
	 * @return
	 */
	public Collection<Resource> getAllResources() {
		return RESOURCES.values();
	}

	/**
	 * Get all the Resources held in this factory that hold references to other
	 * Resources
	 * 
	 * @return
	 */
	public Collection<Resource> getAllResourcesWithRef() {
		ArrayList<Resource> refs = new ArrayList<Resource>();
		Collection<Resource> services = RESOURCES.values();
		for (Resource s : services) {
			if (s.hasRefs()) {
				refs.add(s);
			}
		}
		return refs;
	}

	public String toString() {
		String str = new String();
		for (Resource s : RESOURCES.values()) {
			str += s + "\n";
		}
		return str;
	}

	public String toStringReferences() {
		String str = new String();
		for (Resource s : RESOURCES.values()) {
			if (s.hasRefs()) {
				str += s + "\n";
			}
		}
		return str;
	}

	private void addResource(Resource s) {
		if (!RESOURCES.containsKey(s.getStructure())) {
			RESOURCES.put(s.getStructure(), s);
		}
	}

	/**
	 * Strip the suffixes from the zip entry file name of the resource
	 * 
	 * @param structure
	 * @return
	 */
	private String stripSuffix(String structure) {
		int end = 0;
		if (structure.endsWith(PROXY_SERVICE)) {
			end = structure.indexOf(PROXY_SERVICE);
			return structure.substring(0, end);
		} else if (structure.endsWith(BIZ_SERVICE)) {
			end = structure.indexOf(BIZ_SERVICE);
			return structure.substring(0, end);
		} else if (structure.endsWith(XSD)) {
			end = structure.indexOf(XSD);
			return structure.substring(0, end);
		} else if (structure.endsWith(WSDL)) {
			end = structure.indexOf(WSDL);
			return structure.substring(0, end);
		} else {
			return structure;
		}
	}
}
