library(shiny)
library(ggplot2)
library(ROAuth)

source("tools/twitteR.R")

shinyServer(function(input, output) {
  
  twit <- reactive({
    hour_dist(string = input$TwitterInput, 
              n      = input$AmountInput, 
              days   = input$DaysInput, 
              lang   = "de", 
              plot   = FALSE)
  })
 
  
  output$plot <- renderPlot({
     
       print(ggplot(twit()) + geom_histogram(aes(x=hourly.count), binwidth=1) + 
           facet_wrap(~date) + xlab("") + ylab("") + xlim(c(0,24)))    
  })
  
 
  output$values <- renderTable({
      tab <- sort(table(twit()$user), decreasing=T)[1:10]
      df <- data.frame(V1=names(tab), V2=tab)
      rownames(df) <- NULL
      names(df) <- c("Name des Twitterers", "Anzahl Tweets")
      df
  })
  
  
  output$downloadData <- downloadHandler(
      filename <- function() { paste('results.csv', sep='') },
      content <- function(file=filename) {
        write.csv(twit(), file)
      }
  )
})