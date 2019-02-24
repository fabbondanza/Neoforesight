library(shiny)


shinyUI(fluidPage(
<<<<<<< HEAD
  titlePanel('Neo Trendz: Calculator for Lung Nodule VDT and Time to Next Tumor Stage'),
=======
  titlePanel('Neo Trendz: Calculator for VDT and Time to Next Tumor Stage'),
  
>>>>>>> 1620b4dfe927a6ab35d6f02ce3b6377d47297a18
  sidebarLayout(
    sidebarPanel(
      wellPanel(
        dateInput(inputId = 'date1', label = 'Date of the first scan'),
        numericInput(inputId = 'diam1', label = 'Diameter (cm) of the first scan',
                     value = NULL, min = 0, max = 50, step = 0.01),
        dateInput(inputId = 'date2', label = 'Date of the second scan'),
        numericInput(inputId = 'diam2', label = 'Diameter (cm) of the first scan',
                     value = NULL, min = 0, max = 50, step = 0.01),
        submitButton(text = 'Calculate')),
<<<<<<< HEAD
      textOutput('values1'),
      br(),
      textOutput('values2'),
      br(),
      textOutput('values3'),
      br(),
      textOutput('values4'),
      br(),
      textOutput('values5'),
      br(),
      textOutput('values6')),
    
    mainPanel(
     plotOutput('plot')
     ))
=======
        textOutput('values1'),
          br(),
          textOutput('values2'),
          br(),
          textOutput('values3'),
          br(),
          textOutput('values4'),
          br(),
          textOutput('values5'),
          br(),
          textOutput('values6')),
  
  mainPanel(
    plotOutput('plot')
  ))
>>>>>>> 1620b4dfe927a6ab35d6f02ce3b6377d47297a18
  
))