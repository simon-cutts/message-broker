package uk.ac.open.osb.reference;

import java.util.Iterator;
import java.util.logging.Logger;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.events.Attribute;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

/**
 * Inspects an XML representation of an OSB Proxy and Biz resource looking for
 * references to other resources
 * 
 * @author Simon Cutts
 * 
 */
public class ServiceReference {
	private static final ResourceFactory SERVICE_FACTORY = ResourceFactory
			.getInstance();
	private static final Logger LOG = Logger.getLogger(ServiceReference.class
			.getName());

	private Resource resource;

	public ServiceReference(Resource resource) {
		super();
		this.resource = resource;
	}

	/**
	 * Read the XML events from the XMLEventReader
	 * 
	 * @param r
	 */
	public void read(XMLEventReader r) {
		try {
			while (r.hasNext()) {
				XMLEvent e = r.nextEvent();

				// Only care about XML startElements
				if (e.isStartElement()) {
					StartElement se = (StartElement) e;
					String name = se.getName().getLocalPart();

					// Examine references to WSDLs and XSDs
					if (name.equals("wsdl") || name.equals("schema")) {
						String ref = null;
						@SuppressWarnings("unchecked")
						Iterator<Attribute> atts = se.getAttributes();
						while (atts.hasNext()) {
							Attribute a = atts.next();
							if (a.getName().getLocalPart().equals("ref")) {

								// Update the service ref, based on name
								ref = a.getValue();
							}
						}
						if (ref != null) {
							Resource s = SERVICE_FACTORY.findByStructure(ref);
							if (s != null) {
								// System.out.println(service.getName() + " "
								// + s.getName());
								resource.ref(s);
							} else {
								System.out.println("NF " + name + " " + ref);
							}
						}

						// Examine references to other services
					} else if (name.equals("service")) {

						// Now look for these attributes: ref
						String ref = null;
						String type = null;
						@SuppressWarnings("unchecked")
						Iterator<Attribute> atts = se.getAttributes();
						while (atts.hasNext()) {
							Attribute a = atts.next();
							if (a.getName().getLocalPart().equals("ref")) {

								// Update the service ref, based on name
								ref = a.getValue();
							}
							if (a.getName().getLocalPart().equals("type")) {
								type = a.getValue();
							}
						}

						// Get Service from cache, if not found, create it
						if (ref == null || type == null) {
							LOG.info("Missing service info: "
									+ resource.getStructure() + " " + ref + " "
									+ type);
						} else {
							Resource s = SERVICE_FACTORY.findByStructure(ref);
							if (s == null) {
								if (type.endsWith("ProxyRef")) {
									s = new ProxyService(ref);
								} else {
									s = new BizService(ref);
								}
							}
							resource.ref(s);
						}
					}
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
