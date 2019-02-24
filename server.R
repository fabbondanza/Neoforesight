VDT <- function(date1,date2,diam1,diam2) {
  
  v2 = pi*((diam2^3)/6) # in cm^3
  v1 = pi*((diam1^3)/6) #in cm^3
  diff_time=as.Date(strptime(date2, "%Y-%m-%d"))-as.Date(strptime(date1, "%Y-%m-%d"))
  diff_time=as.numeric(diff_time)
  
  vdt = ((diff_time)*log(2))/(log(v2/v1)) # volume doubling time in days
  diamt=(((6*v2/pi)^(1/3))-((6*v1/pi)^(1/3)))/diff_time #diameters calculated from the formulas (4/3)*pi*(d1/2)^3
  t_scan2=diam2/diamt
  #here we are calculating days it will take to get from current stage to next since the 2nd scan performed
  if(diam2 < 1 ) {
    stagescan2="T1a"
    t_T1a= 1.01 /diamt # days it takes to reach to 1cm size given the exponential rate of growth in size in a day
    t<-t_T1a - t_scan2
  } else if (diam2 <= 2) {
    stagescan2="T1b"
    t_T1b = 2.01 / diamt
    t<-t_T1b - t_scan2
  } else if (diam2 <= 3 ){
    stagescan2="T1c"
    t_T1c = 3.01 /diamt
    t = t_T1c - t_scan2
  } else if (diam2 <= 4) {
    stagescan2="T2a"
    t_T2a = 4.01 /diamt
    t = t_T2a - t_scan2
  } else if (diam2 <= 5) {
    stagescan2="T2b"
    t_T2b = 5.01 /diamt
    t = t_T2b - t_scan2
  } else if (diam2 <= 7) {
    stagescan2="T3"
    t_T3 = 7.01 /diamt
    t = t_T3 - t_scan2
  }else if (diam2 > 7) {
    stagescan2="T4"
  }
  
  return(list(floor(vdt), stagescan2,floor(t)))
}

## TODO
# Accept only date 2 if later than date 1
# Go to next 2-3 stages


function(input, output) {
  library(ggplot2)
  #library(plotly)

  
  vdt <- reactive({
    req(input$date1)
    req(input$diam1)
    req(input$date2)
    req(input$diam2)
    VDT(date1 = input$date1, date2 = input$date2, diam1 = input$diam1,
                                diam2 = input$diam2)
  })

prob2 <- reactive({
    # list1 <- list("T1a","T1b","T1c","T2a","T2b","T3","T4")
    # vect <- c(90,85,80,73,66,63,57)
    
    if (vdt()[[2]] == "T1a" ) {prob2=90}
    else if (vdt()[[2]] == "T1b") {prob2=85}
    else if (vdt()[[2]] == "T1c") {prob2=80}
    else if (vdt()[[2]] == "T2a") {prob2=73}
    else if (vdt()[[2]] == "T2b") {prob2=66}
    else if (vdt()[[2]] == "T3")  {prob2=63}
    else if (vdt()[[2]] == "T4")  {prob2=57}
  })

prob3 <- reactive({
  # list1 <- list("T1a","T1b","T1c","T2a","T2b","T3","T4")
  # vect <- c(90,85,80,73,66,63,57)
  
  if (vdt()[[2]] == "T1a" ) {prob3=85}
  else if (vdt()[[2]] == "T1b") {prob3=80}
  else if (vdt()[[2]] == "T1c") {prob3=73}
  else if (vdt()[[2]] == "T2a") {prob3=66}
  else if (vdt()[[2]] == "T2b") {prob3=63}
  else if (vdt()[[2]] == "T3")  {prob3=57}
})

sizetime<-reactive({
  req(input$date1)
  req(input$diam1)
  req(input$date2)
  req(input$diam2)
  
  sizetime <- data.frame(s = c(input$diam1, input$diam2, new_diam(vdt())),
                         t = c(input$date1, input$date2, (input$date2 + vdt()[[3]])))
})

new_diam <- function(vdt){
  if (vdt[[2]] == "T1a" ) {next_stage=1.1}
  else if (vdt[[2]] == "T1b") {next_stage=2.1}
  else if (vdt[[2]] == "T1c") {next_stage=3.1}
  else if (vdt[[2]] == "T2a") {next_stage=4.1}
  else if (vdt[[2]] == "T2b") {next_stage=5.1}
  else if (vdt[[2]] == "T3")  {next_stage=6.1}
  
  return(next_stage)
}



  output$values1 <- renderText({paste('Your stage is ', vdt()[[2]], sep = '')})
  output$values2 <- renderText({paste('The current survival is ',prob2(),'%', sep = '')})
  output$values3 <- renderText({paste('Your VDT is ', vdt()[[1]], sep = '')})
  output$values4 <- renderText({paste('Days to the next stage ', vdt()[[3]],sep = '')})
  output$values5 <- renderText({paste('Survival at next stage ', prob3(), '%',sep = '')})
  output$values6 <- renderText({paste('The loss in survival is: ', prob2()-prob3(), '%', sep = '')})
  
  # next_stage
  
  output$plot <- renderPlot({ggplot2::ggplot(sizetime(), aes(t,s)) +
                                      geom_line() +
                                      xlab('Time') +
      #                                 geom_text(aes(x=sizetime()[]) +
      # geom_text(aes(x = 'Initial', hjust = -5, y = 0.177, label = '**')) +
      
                                      ylab('Growth of tumour in centimeters') +
                                      ylim(c(sizetime()[1,1], sizetime()[3,1] + 1))+
                                      xlim(c(sizetime()[1,2], sizetime()[3,2] + 5)) +
                                      # geom_vline(xintercept = next_stage) +
                                      geom_vline(xintercept = input$date2)+
                                      geom_vline(xintercept = sizetime()[3,2], colour='red')})

}
