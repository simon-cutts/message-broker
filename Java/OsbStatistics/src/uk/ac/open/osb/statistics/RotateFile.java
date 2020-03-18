package uk.ac.open.osb.statistics;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Writes out to a file that rotates every 24 hours
 * 
 * @author Simon Cutts
 * 
 */
public class RotateFile {

	private static final long ONE_HOUR = 60 * 60 * 1000;

	private long expiry = 0;
	private String directory;
	private final SimpleDateFormat dateFormat = new SimpleDateFormat(
			"yyyy_MM_dd-HH_mm_ss");
	private FileWriter out;
	private Date fileDate;
	private Date rolloverDate;
	private String fileName;

	/**
	 * Create an instance of RotateFile at the directory. Rolls over every 24
	 * hours
	 * 
	 * @param directory
	 */
	public RotateFile(String directory) {
		super();
		if (directory == null) {
			directory = "";
		}
		this.directory = directory;
		makeFilename();
	}

	/**
	 * Create an instance of RotateFile at the directory with required expiry
	 * time in milliseconds
	 * 
	 * @param directory
	 */
	RotateFile(String directory, long expiry) {
		super();
		this.directory = directory;
		this.expiry = expiry;
		makeFilename();
	}

	/**
	 * Write out a line to the file
	 * 
	 * @param line
	 * @throws IOException
	 */
	public void write(String line) throws IOException {
		if (out == null) {
			out = new FileWriter(new File(fileName), true);
		}
		out.write(line);
	}

	/**
	 * Flush the contents of the buffer. Also closes the file
	 * 
	 * @throws IOException
	 */
	public void flush() throws IOException {
		out.flush();
		out.close();
		out = null;
		if (hasExpired()) {
			makeFilename();
		}
	}

	/**
	 * Make a file name based on the current data and time. File always begins
	 * with OsbStatistics_
	 */
	private void makeFilename() {

		// If directory not found, then set to empty string so that the file is
		// written to the default location
		if (directory != null) {
			if (!new File(directory).isDirectory()) {
				System.out
						.println("Information: Directory not found for OsbStatistics "
								+ directory);
				directory = "";
			}
		}

		fileDate = new Date(System.currentTimeMillis());

		// If an expiry has been entered, use that, otherwise rollover every day
		if (expiry == 0) {
			rolloverDate = new Date(fileDate.getTime() + (24 * ONE_HOUR));
		} else {
			rolloverDate = new Date(fileDate.getTime() + expiry);
		}
		fileName = directory + "OsbStatistics_" + dateFormat.format(fileDate)
				+ ".log";
		Log.info("Writing to file " + fileName);
	}

	/**
	 * Has the time to rollover to a new file name expired?
	 * 
	 * @return
	 */
	private boolean hasExpired() {
		Date now = new Date(System.currentTimeMillis());
		return now.after(rolloverDate);
	}

	public static void main(String[] args) {
		RotateFile rf = new RotateFile("", 1);
		try {
			rf.write("111111\n");
			rf.write("2222222\n");
			Thread.sleep(2000);
			rf.flush();
			rf.write("aaaaa\n");
			rf.write("bbbbb\n");
			rf.flush();
			Log.info("Stop");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
