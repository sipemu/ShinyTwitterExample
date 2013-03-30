library(shiny)
library(ggplot2)

source("tools/twitteR.R")

shinyServer(function(input, output) {
  
  output$plot <- renderImage({

    if (input$saveButton == 0)
      return()
    isolate({
       df <- hour_dist(string = input$TwitterInput, 
                       n      = 1200, 
                       days   = 6, 
                       lang   = "de", 
                       plot   = FALSE)
       
       png("out.png", width=600, height=400)
       ggplot(df) + geom_histogram(aes(x=hourly.count), binwidth=1) + 
           facet_wrap(~date) + xlab("") + ylab("") + xlim(c(0,24))
       dev.off()
       list(src = "out.png",
            alt = "This is alternate text")
    })
  })
  
 
  
  output$values <- renderTable({
    tabelle()
  }, deleteFile = TRUE)
})