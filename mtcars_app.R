library(shiny)
library(datasets)

# We tweak the "am" field to have nicer factor labels. Since
# this doesn't rely on any user inputs we can do this once at
# startup and then use the value throughout the lifetime of the
# application
mpgData <- mtcars

# Define server logic required to plot various variables against
# mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is
  # shared by the output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste(input$yvariable,'~',input$xvariable)
  })
  
  groupText <- reactive({
    paste(input$group)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg and
  # only include outliers if requested
  output$mpgPlot <- renderPlot({
    plot(as.formula(formulaText()),
         data = mpgData,
         col = gear, #as.(groupText())
         pch=17,
         xlab=paste(input$xvariable),ylab=paste(input$yvariable)
    )
  })
})