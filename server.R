library(shiny)
library(rCharts)
library(adehabitatHR)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {

  # Record visitor's IP informatin;  
#   observe({write(input$log, "www/log.txt", append = TRUE)})
  
  ## Parse URL;
  p <- reactiveValues()
  observe({
    p$species <- parseQueryString(session$clientData$url_search)$species
    updateTextInput(session, inputId = "bil", value = input$lang)
  })
  
  # Load data;
  load("Data//DAT.RData")
  D <-  read.csv("Data/dictionary.txt", stringsAsFactors = FALSE) 
  E2C <- function(en) {
    for (i in 1:length(en)) {
      id <- which(D$name_c %in% en[i])
      if (length(id) == 1) {
        if (!is.null(input$lang)) {
          if (input$lang == "en") en[i] <- D$name_e[id]
        }
      }
    }
    return(en)
  }
  
  # Source input and output;
  source("RScript//jsFun.R",  local = TRUE)
  source("RScript//input.R",  local = TRUE)
  source("RScript//output.R", local = TRUE)

})
