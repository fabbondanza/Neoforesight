library(shiny)


fluidPage(
  dateInput(inputId = 'date1', label = 'Date of your first scan'),
  numericInput(inputId = 'vol1', label = 'Volume (mm3) of your first scan', min = 0, max = 50),
  dateInput(inputId = 'date2', label = 'Date of your second scan'),
  numericInput(inputId = 'vol1', label = 'Volume (mm3) of your first scan', min = 0, max = 50)
  # checkboxInput(inputId = '')
)