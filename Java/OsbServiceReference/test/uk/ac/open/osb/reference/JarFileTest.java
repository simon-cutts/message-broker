package uk.ac.open.osb.reference;

import java.io.File;

import junit.framework.Assert;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class JarFileTest {

	private static final ResourceFactory SF = ResourceFactory
			.getInstance();

	@Test
	public void testCorrectRefCount() {
		File f = new File(System.getProperty("user.dir")
				+ "/test/sbconfig-small.jar");
		JarFile jf = new JarFile(f);
		jf.readEntries();
		Assert.assertEquals(20, SF.getAllResources().size());
	}

}
