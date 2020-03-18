package uk.ac.open.osb.servicematrix;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;
import java.util.zip.GZIPInputStream;

/**
 * Creates a ServiceMatrix by reading all the entries in a netscaler log file
 * held within a GZip file. The GZip file is often held in a folder of other
 * GZip files
 * 
 * <p>
 * Copy the GZip files from \\nsweblogs\soa-osb-live to a local folder and then
 * read from that local location
 * </p>
 * 
 * @author Simon Cutts
 * 
 */
public class ServiceMatrix {
	private Matrix matrix;

	/**
	 * Read all the GZip files from a folder
	 * 
	 * @param absolutePathname
	 */
	public void readGZipFilesFromFolder(String absolutePathname) {
		matrix = new Matrix();
		File folder = new File(absolutePathname);
		File[] listOfFiles = folder.listFiles();

		// Read all the files in the directory
		for (File file : listOfFiles) {
			if (file.isFile()) {
				readGZipFile(file.getAbsolutePath());
			}
		}
		System.out.println(matrix);
	}

	/**
	 * Read the contents of a individual GZip file
	 * 
	 * @param absolutePathname
	 */
	private void readGZipFile(String absolutePathname) {
		try {
			GZIPInputStream gzip = new GZIPInputStream(new FileInputStream(
					absolutePathname));

			// Use a Scanner to read the file contents
			Scanner scanner = null;
			try {
				scanner = new Scanner(new InputStreamReader(gzip));
				read(scanner);
			} finally {
				scanner.close();
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Read the contents of a individual file
	 * 
	 * @param absolutePathname
	 */
	protected void read(String absolutePathname) {

		File file = new File(absolutePathname);
		if (!file.exists()) {
			throw new RuntimeException("File not found: " + absolutePathname);
		}

		// Use a Scanner to read the file contents
		Scanner scanner = null;
		try {
			scanner = new Scanner(file);
			read(scanner);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		} finally {
			scanner.close();
		}
	}

	/**
	 * Use a Scanner to read the entreis in the netscaler log
	 * 
	 * @param scanner
	 */
	private void read(Scanner scanner) {

		while (scanner.hasNextLine()) {
			String line = scanner.nextLine();

			// ignore comment lines
			if (!line.startsWith("#")) {
				int count = 0;
				String[] tokens = line.split(" ");
				Line req = new Line();

				// Get each item in the line of the log, separated by a space,
				// for instance:
				// 2014-02-28 00:00:01 soa-osb-live.open.ac.uk 137.108.140.126
				// ....
				for (String token : tokens) {
					count++;
					if (count < 4) {
						continue;
					} else if (count == 4) {
						req.setSourceIp(token);
					} else if (count == 5) {
						continue;
					} else if (count == 6) {
						req.setTargetIp(token);
					} else if (count == 7) {
						req.setTargetPort(token);
					} else if (count == 8) {
						continue;
					} else if (count == 9) {
						req.setUrl(token);
					} else if (count > 9) {
						continue;
					}
				}
				matrix.add(req);
			}
		}
	}

	public static void main(String[] args) {
		ServiceMatrix fs = new ServiceMatrix();
		// fs.read("ex140222.log");
		// fs.readGZipFile("ex140222.log.gz");
		fs.readGZipFilesFromFolder("C:/OULocal/temp/netscaler");
	}
}