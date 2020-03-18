package uk.ac.open.osb.sams;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 * Reads the SAMS credential from the file system. Caches the password when
 * first invoked. In a clustered environment, the managed servers will need
 * access to wherever the file is stored
 * 
 * @author Simon Cutts
 * 
 */
public class SamsCredential {

	/**
	 * Cache the password
	 */
	private static String password;

	private SamsCredential() {
	}

	/**
	 * Does the absolutePathname to the file exist?
	 * 
	 * @param absolutePathname
	 * @return
	 */
	public static String exists(String absolutePathname) {
		File file = new File(absolutePathname);
		return Boolean.toString(file.exists());
	}

	/**
	 * Get the SAMS password from the absolutePathname. When found will be
	 * cached for the duration of the class in memory
	 * 
	 * @param absolutePathname
	 * @return
	 */
	public static String getPassword(String absolutePathname) {
		if (password == null) {

			File file = new File(absolutePathname);
			if (!file.exists()) {
				throw new RuntimeException("File not found: "
						+ absolutePathname);
			}

			Scanner scanner = null;
			try {
				StringBuilder fileContents = new StringBuilder(
						(int) file.length());
				scanner = new Scanner(file);

				while (scanner.hasNextLine()) {
					fileContents.append(scanner.nextLine());
				}
				password = fileContents.toString();
			} catch (FileNotFoundException e) {
				throw new RuntimeException(e);
			} finally {
				scanner.close();
			}
		}
		return password;
	}
}
