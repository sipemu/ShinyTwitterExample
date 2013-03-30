library(shiny)
library(shinyIncubator)

shinyUI(pageWithSidebar(
  
  headerPanel("Rudimentärer Twitter Report"),
  
  sidebarPanel(h4('Einleitung'),
               helpText(
                 p("Die Grafik präsentiert die Anzahl der Tweets je Stunde und Tag zu einem Suchbegriff. Dabei 
    ist lediglich möglich die Daten bis zu 7 Tage zurück zu erhalten unundebugie Anzahl 
    der abrufbaren Tweets sind je Tag auf 1.500 beschränkt."), 
                        p("Shiny ist experimentell. Nutzung auf eigene Gefahr."),
                        p("Die Suche kann je nach Parameter lange dauern.")),
    br(),
    h4('Eingabe'), textInput("TwitterInput", "Twitter-Suchbegriff:", "Stuttgart"),
               numericInput("DaysInput", "Wieviel Tage zurück (max. 7):", value=0, min=0, max=7, step=1),
               numericInput("AmountInput", "Wieviele Tweets (max. 1500):", value=1, min=1, max=1500, step=1), br(),br(),
               div(class="row-fluid", div(class="span6", submitButton(text="Suchen")), 
                   downloadButton('downloadData', 'Download der Suche  als csv'))),
  
  mainPanel(tabsetPanel(
    tabPanel("Grafik", h4("Ausgabe"), imageOutput("plot"), 
             h4("Top-Ten-Twitterer"), tableOutput("values")),
    tabPanel("Über", wellPanel(includeMarkdown("ueber.Rmd"))) 
                        )      
            )
))