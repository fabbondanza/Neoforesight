VDT <- function(date1,date2,diam1,diam2) {
  
  v2 = pi*((diam2^3)/6) # in cm
  v1 = pi*((diam1^3)/6) #in cm
  diff_time=as.Date(strptime(date2, "%Y-%m-%d"))-as.Date(strptime(date1, "%Y-%m-%d"))
  diff_time=as.numeric(diff_time)
  
  vdt = ((diff_time)*log(2))/(log(v2/v1)) # volume doubling time in days
  diamt=exp(1)^(log(diam2/diam1)/diff_time) 
  t_scan2=log(diam2/diamt) 
  #here we are calculating days it will take to get from current stage to next since the 2nd scan performed
  if(diam2 < 1 ) {
    stagescan2="T1a"
    t_T1A = 1.01 / diamt # days it takes to reach to 1cm size given the exponential rate of growth in size in a day
    t<-t_T1A - t_scan2
  } else if (diam2 <= 2) {
    stagescan2="T1b"
    t_T1b = 2.01 / diamt
    t<-t_T1b - t_scan2
  } else if (diam2 <= 3) {
    stagescan2="T1c"
    t_T1c = 3.01 / diamt
    t = t_T1c - t_scan2
  } else if (diam2 <= 4) {
    stagescan2="T2a"
    t_T2a = 4.01 / diamt
    t = t_T2a - t_scan2
  } else if (diam2 <= 5) {
    stagescan2="T2b"
    t_T2b = 5.01 / diamt
    t = t_T2b - t_scan2
  } else if (diam2 <= 7) {
    stagescan2="T3"
    t_T3 = 7.01 / diamt
    t = t_T3 - t_scan2
  }else if (diam2 > 7) {
    stagescan2="T4"
  }
  
  return(list(floor(vdt), stagescan2,floor(t)))
}



shinyServer(function(input, output) {
  library(ggplot2)
  library(plotly)
  output$vdt <- VDT(date1 = input$date1, date2 = input$date2, diam1 = input$diam1, diam2 = input$diam2)
  output$plot <- renderPlot(plotly(ggplot(output$vdt) +
                                     geom_line()))
    
})

v2 = pi*((6^3)/6) #in cm
v1 = pi*((3^3)/6) #in cm

VDT(date1 ="2012-07-01", date2 = "2012-09-01", diam1 = 3, diam2 = 6)
