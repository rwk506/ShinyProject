library(shiny)

# Define UI for miles per gallon application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Swiss Fertility Data"),
  
  # Sidebar with controls to select the variable to plot against
  # mpg and to specify whether outliers should be included
  sidebarLayout(
    sidebarPanel(
      titlePanel("Plotting"),
      selectInput("xvariable", "X axis:",
                  c("Agriculture" = "Agriculture",
                    "Fertility" = "Fertility",
                    "Infant Mortality" = "Infant.Mortality")),
      selectInput("yvariable", "Y axis:",
                  c("Agriculture" = "Agriculture",
                    "Fertility" = "Fertility",
                    "Infant Mortality" = "Infant.Mortality"),
                    selected = "Fertility"),
      radioButtons("radio", label = h3("Group By:"),
                   choices = list("Examination", "Education","Catholic")),
      selectInput("radio2", "Linear Fit",
                  list("Off" = "Off",
                       "On" = "On"))
    ),
    
    # Show the caption and plot of the requested variable against
    # mpg
    mainPanel(
      h3("The Well-Being of Switzerland in 1888"),
      br(),
      h4("Exploring Fertility and Socioeconomic Data of 1888 Switzerland"),
      p("This Shiny application is written in order to explore the 'swiss' dataset in the R library. The user can
        choose an X-variable to plot, a Y-variable to plot, and a variable on which to group (color) the data.
        A linear fit can also be chosen to be computed and the results will be displayed 
        (note that the linear fit is for the entire set of points, not by group)."
        ,style = "font-family: 'times'; font-si16pt"),
      br(),
      h4(textOutput("caption")),
      plotOutput("swissPlot"),
      p(textOutput("showfit")),
      p(textOutput("showfit2")),
      br(),
      p("Reference: Mosteller, F. and Tukey, J. W. (1977).",style = "font-family: 'times'; font-si16pt")
    )
  )
))