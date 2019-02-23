library(shiny)


shinyUI(fluidPage(
  titlePanel('Calcultion VDT'),
  
  sidebarLayout(
    sidebarPanel(
      wellPanel(
          dateInput(inputId = 'date1', label = 'Date of your first scan'),
          numericInput(inputId = 'diam1', label = 'Diameter (cm) of your first scan',
                       value = NULL, min = 0, max = 50, step = 0.01),
          dateInput(inputId = 'date2', label = 'Date of your second scan'),
          numericInput(inputId = 'diam2', label = 'Diameter (cm) of your first scan',
                       value = NULL, min = 0, max = 50, step = 0.01),
          submitButton(text = 'Calculate VDT')),
          textOutput('values1'),
          br(),
          textOutput('values2'),
          br(),
          textOutput('values3')),
  

  mainPanel(
    plotOutput('plot')
  ))
  
))
