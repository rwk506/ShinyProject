library(shiny)
library(datasets)
library(ggplot2)

shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression based on user-chosen x and y variables
  formulaText <- reactive({
    paste(input$yvariable,'~',input$xvariable)
  })
  
  Xvar <- reactive({
    #paste('swiss$',input$xvariable,sep="")
    paste(input$xvariable)
  })

  Yvar <- reactive({
    #paste('swiss$',input$yvariable,sep="")
    paste(input$yvariable)
  })
    
  # Return the formula text for printing as a caption at top of screen
  output$caption <- renderText({
    formulaText()
  })
  
  # Compute a reactive expression for the grouping of the data by color
  grouping <- reactive({
    switch(input$radio,
           Examination = "Examination",
           Education = "Education",
           Catholic = "Catholic")
  })
  
  output$swissPlot <- renderPlot({
    if(Xvar()=="Fertility"){Xv=swiss$Fertility}
    else if(Xvar()=="Infant.Mortality"){Xv=swiss$Infant.Mortality}
    else if(Xvar()=="Agriculture"){Xv=swiss$Agriculture}
    if(Yvar()=="Fertility"){Yv=swiss$Fertility}
    else if(Yvar()=="Infant.Mortality"){Yv=swiss$Infant.Mortality}
    else if(Yvar()=="Agriculture"){Yv=swiss$Agriculture}
    if(grouping()=="Catholic"){Grouping=swiss$Catholic}
    else if(grouping()=="Examination"){Grouping=cut(swiss$Examination,breaks=c(0,10,20,30))}#swiss$Examination}
    else if(grouping()=="Education"){Grouping=cut(swiss$Education,breaks=c(0,5,10,20,30))}#swiss$Education}
    G=vector(length=length(swiss$Catholic))
    df1=data.frame(Xv,Yv,Grouping,G)
    p = ggplot(data=df1, aes(Xv,Yv, color = Grouping, group=G))
    p = p + geom_point() + xlab(paste(Xvar())) + ylab(paste(Yvar()))
    if (input$radio2 == "On"){
      p = p + geom_smooth(method="lm",aes(Xv,Yv),data=df1)}
    print(p)
  })
  
  # Print out the results of the linear fit (if applicable)
  output$showfit <- renderPrint({
    if (input$radio2=="On"){
      paste(c("Linear Model = ",formulaText()))}
  })

  output$showfit2 <- renderPrint({
    if (input$radio2=="On"){
      model = lm(as.formula(formulaText()), data=swiss)
      paste(c("Slope =",round(model$coefficients[1],2),
              ",  Intercept =",round(model$coefficients[2],2),
              ", R^2 = ",round(summary(model)$r.squared,2)))}
  }) 
})  #end

