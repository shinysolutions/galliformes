library(rCharts)
shinyUI(bootstrapPage(
  # Add custom CSS & Javascript;
  tagList(
    tags$head(
      tags$style("hr {margin: 5px 0;} html, body, #myMap {height: 100%;width: 100%;} .checkbox+.checkbox, .radio+.radio {margin-top: 10px;}"),
      tags$link(rel="stylesheet", type="text/css",href="style.css")
    )
  ),
  ## Language;
  
  # img(id = "layers", src = "layers.png"),
  # # img(id = "control", src = "control.png"),
  
  textInput(inputId = "log", label = "", value = ""),

  
  div(class = "control", 
      uiOutput("uiLang"),
      HTML("<br><hr></hr>"),
      uiOutput("uiOrder"),
      uiOutput("uiFamily"),
      uiOutput("uiGenus"),
      uiOutput("uiSpecies"),
      uiOutput("uiBoxPercent"),
      conditionalPanel("input.boxPercent == true", uiOutput("uiPercent")),
      uiOutput("uiBoxLevel"),
      conditionalPanel("input.boxLevel == true", uiOutput("uiLevel")),
      uiOutput("uiPicture")
      ),
  # div(class = "layers", 
  #     uiOutput("uiMapType")),
  showOutput("myMap", "leaflet"),
  
  tagList(
    tags$body(
      tags$script(type="text/javascript", src = "leaflet.ChineseTmsProviders.js"),
      tags$script(type="text/javascript", src = "switch.js")
    )
  )
  
))
