library(shiny)
library(shinyIncubator)

shinyUI(pageWithSidebar(
  
  headerPanel("Eingabe Test"),
  
  sidebarPanel(textInput("TwitterInput", "Twitter-Suchbegriff:", ""),
               br(),
               actionButton("saveButton", "Einfügen"), uiOutput("reload")),
  
  mainPanel(imageOutput("plot"))
  
))