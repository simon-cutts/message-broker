package uk.ac.open.osb.reference;

import java.util.Iterator;
import java.util.logging.Logger;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.events.Attribute;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

/**
 * Inspects an XML representation of an OSB WSDL and XSD resource looking for
 * references to other resources
 * 
 * @author Simon Cutts
 * 
 */
public class XmlReference {
	private static final ResourceFactory SERVICE_FACTORY = ResourceFactory
			.getInstance();
	private static final Logger LOG = Logger.getLogger(XmlReference.class
			.getName());

	private Resource resource;

	public XmlReference(Resource resource) {
		super();
		if (resource instanceof Xsd || resource instanceof Wsdl) {
			this.resource = resource;
		} else {
			throw new RuntimeException("Must be Wsdl or Xsd resource");
		}
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

					// Examine references to XSDs and WSDLs
					if (name.equals("schemaRef") || name.equals("import")) {
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
								resource.ref(s);
							} else {
								System.out.println("NF " + name + " " + ref);
							}
						}

						// Examine references to other services
					}
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
