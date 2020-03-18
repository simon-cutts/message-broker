package uk.ac.open.osb.reference;

import java.io.InputStream;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;

/**
 * Inspects an XML representation of an OSB resource looking for references to
 * other resources
 * 
 * @author Simon Cutts
 * 
 */
public class ResourceReference {
	private static final XMLInputFactory FACTORY = XMLInputFactory
			.newInstance();
	private static final ResourceFactory SERVICE_FACTORY = ResourceFactory
			.getInstance();

	private Resource resource;

	public ResourceReference(String serviceName) {
		super();
		resource = SERVICE_FACTORY.findByStructure(serviceName);
	}

	/**
	 * Read the contents of a service
	 * 
	 * @param is
	 *            the InputStream of the service to read
	 */
	public void read(InputStream is) {
		XMLEventReader r = null;
		try {
			r = FACTORY.createXMLEventReader(is);

			if (resource instanceof ProxyService
					|| resource instanceof BizService) {
				ServiceReference sf = new ServiceReference(resource);
				sf.read(r);
			} else {
				XmlReference rf = new XmlReference(resource);
				rf.read(r);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			try {
				r.close();
			} catch (XMLStreamException e) {
				throw new RuntimeException(e);
			}
		}
	}
}
