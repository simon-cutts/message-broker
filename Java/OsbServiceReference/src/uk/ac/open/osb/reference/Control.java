package uk.ac.open.osb.reference;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;

public class Control {
	ResourceFactory sf = ResourceFactory.getInstance();

	public Control() {
	}

	public Control(List<Resource> exclusions) {
		for (Resource e : exclusions) {
			sf.addExclusion(e);
		}
	}

	public void read(File f) {
		try {
			JarFile jar = new JarFile(f);
			ArrayList<ZipEntry> entries = jar.readEntries();
			for (ZipEntry entry : entries) {
				ResourceReference search = new ResourceReference(entry.toString());
				search.read(jar.stream(entry));
				// System.out.println(s.getName() + " " + s.references());
			}

			// Now build create statements
			CypherBuilder cb = new CypherBuilder();
			System.out.println(cb.createNodes(sf.getAllResources()));
			System.out.println(cb.createRelationships(sf
					.getAllResourcesWithRef()));
			// System.out.println(sf.toStringReferences());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static void main(String[] args) {
		// File f = new File("C:/OULocal/temp/sbconfig-acct.jar");
		File f = new File(System.getProperty("user.dir")
				+ "/test/sbconfig-small.jar");
		ArrayList<Resource> e = new ArrayList<Resource>();
		e.add(new ProxyService("Common/error/proxy/FaultHandler"));
		e.add(new ProxyService("Sams/proxy/ValidateSamsToken"));
		Control c = new Control(e);
		c.read(f);
	}
}
