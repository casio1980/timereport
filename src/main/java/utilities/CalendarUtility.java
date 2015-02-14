package utilities;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CalendarUtility {
	
	private Calendar now = null;

	public CalendarUtility() {
		this.now = Calendar.getInstance();
	}

	public int getCurrentWeekNum() {
		return now.get(Calendar.WEEK_OF_YEAR);
	}

	public boolean isToday(Date date) {
		return now.getTime().compareTo(date) == 0;
	}	
	
	public Date getDate(int year, int weekNum, int dayNum) {
		Calendar dt = Calendar.getInstance();
		dt.set(Calendar.YEAR, year);
		dt.set(Calendar.WEEK_OF_YEAR, weekNum);
		dt.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY + dayNum);
		
		return dt.getTime();
	}

	public String weekToJson(int year, int weekNum) {
		final String jsonWeekFmt = "{\"date\": \"%s\", \"name\": \"%s\"}";

		Calendar dt = Calendar.getInstance();
		dt.set(Calendar.YEAR, year);
		dt.set(Calendar.WEEK_OF_YEAR, weekNum);

		SimpleDateFormat nameFormat = new SimpleDateFormat("E', 'dd MMM yyyy");

		String ret = "";
		String delimeter = "";

		for (int dayNum = 0; dayNum < 7; dayNum++) {
			dt.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY + dayNum);

			ret += delimeter;
			ret += String.format(jsonWeekFmt, dateToString(dt.getTime()),
					nameFormat.format(dt.getTime()));

			delimeter = ",";
		}

		return String.format("[%s]", ret);
	}
	
	public String dateToString(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		return dateFormat.format(date);		
	}

}
