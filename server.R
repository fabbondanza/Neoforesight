VDT <- function(date1,date2,diam1,diam2) {
  
  v2 = diam2^3/2 # in cm
  v1 = diam1^3/2 #in cm
  # date_strings = c("14.01.2013", "26.03.2014")
  # datetimes = strptime(date_strings, format = "%d.%m.%Y") # convert to datetime objects
  # diff_time <- difftime(datetimes[2], datetimes[1], units = 'days')
  diff_time=as.Date(strptime(date2, "%Y-%m-%d"))-as.Date(strptime(date1, "%Y-%m-%d"))
  diff_time=as.numeric(diff_time)
  
  vdt = ((diff_time)*log(2))/(log(v2/v1))# volume doubling time in days
  diamt= ((diam2-diam1)/diff_time)^(diff_time)
  t_scan2= diam2/diamt
  #here we are calculating days it will take to get from current stage to next since the 2nd scan performed
  if(diam2 < 1 ) {
    stagescan2="T1a"
    t_T1A = 1.01 / y # days it takes to reach to 1cm size given the exponential rate of growth in size in a day
    t<-t_T1A - t_scan2
  } else if (diam2 < 2) {
    stagescan2="T1b"
    t_T1b = 2.01 / y
    t<-t_T1b - t_scan2
  } else if (diam2 < 3) {
    stagescan2="T1c"
    t_T1c = 3.01 / y
    t = t_T1c - t_scan2
  } else if (diam2 < 4) {
    stagescan2="T2a"
    t_T2a = 4.01 / y
    t = t_T2a - t_scan2
  } else if (diam2 < 5) {
    stagescan2="T2b"
    t_T2b = 5.01 / y
    t = t_T2b - t_scan2
  } else if (diam2 < 7) {
    stagescan2="T3"
    t_T3 = 7.01 / y
    t = t_T3 - t_scan2
  }else if (diam2 > 7) {
    stagescan2="T4"
  }
  
  return(vdt, stagescan2,t)
}

shinyServer(function(input, output) {
  library(ggplot2)
  library(plotly)
  output$vdt <- VDT(date1 = input$date1, date2 = input$date2, diam1 = input$diam1, diam2 = input$diam2)
  output$plot <- renderPlot(plotly(ggplot(output$vdt) +
                                     geom_line()))
    
})

# growth rate[mm/day] = (scan2 - scan1)/(time2 - time1) ==== scan in mm / time in days 
# y = growth rate^time 
# if y[] = stage1
# return x[time]
# else if y = stage2
# return x[time]
# .
# .
# .


# t_scan1 = scan1 / y
# 
# if( scan1 < 10 ) {
#   t_T1A = 10 / y # 10mm T1a'deki buyukluk
#   t = t_T1A - t_scan1
#   return t 
# } else if (scan < 20) {
#   t_T1b = 20 / y
#   return t
# } else if (scan < 30) {
#   t_T1c = 30 / y
#   return t }
# }