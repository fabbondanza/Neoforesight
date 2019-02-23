library(shiny)


shinyUI(fluidPage(
  titlePanel('Calcualtion VDT'),
  
  sidebarLayout(
    sidebarPanel(
      sidebarnput(
          dateInput(inputId = 'date1', label = 'Date of your first scan'),
          numericInput(inputId = 'diam1', label = 'Diameter (cm) of your first scan', min = 0, max = 50),
          dateInput(inputId = 'date2', label = 'Date of your second scan'),
          numericInput(inputId = 'diam2', label = 'Diameter (cm) of your first scan', min = 0, max = 50),
          output$vdt
          out
  # checkboxInput(inputId = '')
  
    ))),
  
  mainPanel(
    plotOutput('vdt_plot')
  )
  
))