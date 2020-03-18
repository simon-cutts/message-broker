package uk.ac.open.osb.zip;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * Compares contents of zip file A to the contents of zip file B. Ultimately
 * this is realised as (zipA minus zipB). Used mostly to compare the contents of
 * sbconfig.jar files
 * 
 * @author Simon Cutts
 * 
 */
public class ZipCompare {

	/**
	 * Get only the files from the zip file, and return their pathnames as a
	 * list of strings in the list
	 * 
	 * @param f
	 * @return
	 */
	private ArrayList<String> getZipFiles(File f) {
		ArrayList<String> files = new ArrayList<String>();
		try {
			ZipFile zf = new ZipFile(f);
			Enumeration<? extends ZipEntry> entries = zf.entries();
			while (entries.hasMoreElements()) {
				ZipEntry ze = entries.nextElement();
				if (!ze.isDirectory()) {
					files.add(ze.getName());
				}

			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return files;
	}

	/**
	 * Compares contents of zip file A to the contents of zip file B
	 * 
	 * @param a
	 * @param b
	 */
	public void compare(File a, File b) {
		ArrayList<String> filesA = getZipFiles(a);
		ArrayList<String> filesB = getZipFiles(b);
		filesA.removeAll(filesB);
		for (String file : filesA) {
			System.out.println(file);
		}
	}

	public static void main(String[] args) {
		File a = new File(
				"C:/OULocal/temp/workspace-2.1/export/ServiceRepository/ServiceRepository_sbconfig.jar");
		File b = new File("C:/OULocal/temp/ServiceRepository_sbconfig.jar");

		ZipCompare rz = new ZipCompare();
		rz.compare(a, b);
	}
}