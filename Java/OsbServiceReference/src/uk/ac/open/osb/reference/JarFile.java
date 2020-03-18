package uk.ac.open.osb.reference;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.logging.Logger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * Representation of a Jar file, that uses the conventional
 * java.util.zip.ZipFile format. Inspects the contents of the file, looking for
 * WSDL, XSD, ProxyService and BusinessServices entries
 * 
 * @author Simon Cutts
 * 
 */
public class JarFile {
	private static final ResourceFactory SERVICE_FACTORY = ResourceFactory
			.getInstance();
	private static final Logger LOG = Logger.getLogger(JarFile.class.getName());

	private ZipFile zf;

	/**
	 * Create an instance of JarFile for the File
	 * 
	 * @param f
	 */
	public JarFile(File f) {
		try {
			zf = new ZipFile(f);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Read only ProxyService and BusinessServices Jar file entries. Creating
	 * new Service instances as they are discovered
	 * 
	 * @param f
	 * @return
	 */
	public ArrayList<ZipEntry> readEntries() {
		ArrayList<ZipEntry> files = new ArrayList<ZipEntry>();
		try {
			Enumeration<? extends ZipEntry> entries = zf.entries();
			while (entries.hasMoreElements()) {
				ZipEntry ze = entries.nextElement();

				if (!ze.isDirectory()) {
					if (ze.getName().endsWith(ResourceFactory.PROXY_SERVICE)
							|| ze.getName()
									.endsWith(ResourceFactory.BIZ_SERVICE)
							|| ze.getName().endsWith(ResourceFactory.WSDL)
							|| ze.getName().endsWith(ResourceFactory.XSD)) {
						files.add(ze);
						LOG.fine(ze.getName());
						// Create the service
						SERVICE_FACTORY.createResource(ze.getName());
					}
				}

			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return files;
	}

	/**
	 * Get the InputStream for this ZipEntry
	 * 
	 * @param ze
	 * @return
	 */
	public InputStream stream(ZipEntry ze) {
		try {
			return zf.getInputStream(ze);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public static void main(String[] args) {
		File f = new File(
				"C:/OULocal/temp/workspace-2.1/export/CamelMsgReceiver/CamelMsgReceiver_sbconfig.jar");

		try {
			JarFile rz = new JarFile(f);
			rz.readEntries();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}