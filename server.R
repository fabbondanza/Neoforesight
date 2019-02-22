
VDT <- function(date1,date2,diam1,diam2) {
  
  v2 = diam2^3/2 
  v1 = diam1^3/2
  # date_strings = c("14.01.2013", "26.03.2014")
  # datetimes = strptime(date_strings, format = "%d.%m.%Y") # convert to datetime objects
  # diff_time <- difftime(datetimes[2], datetimes[1], units = 'days')
  diff_time=as.Date(strptime(date2, "%Y-%m-%d"))-as.Date(strptime(date1 "%Y-%m-%d"))
  diff_time=as.numeric(diff_time)
  
  vdt = ((diff_time)*log(2))/(log(v2/v1))
  
  return(vdt)
}




# "The volume is calculated from the inserted values, according to the following formula(s):" +
#   "<ul>" +
#   "<li>X, Y and Z values:  X x Y x Z / 2" +
#   "<li>X and Y values: (X x Y x ( (X+Y)/2 )) / 2" +
#   "<li>Only X value: X<sup>3</sup> / 2" +
#   "<li>Typing in the volume directly will ignore the inserted dimensions" +
#   "</ul>" +
#   