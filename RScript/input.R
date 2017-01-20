observe({
  if (is.null(p$species)) {
    
    output$uiOrder <- renderUI({
      selectInput(inputId = "iOrder", 
                  label   = E2C("目："), 
                  choices = E2C("鸡形目"))
    })
    
    output$uiFamily <- renderUI({
      Items <- sort(unique(DAT$family_c))
      names(Items) <- E2C(Items)
      selectInput(inputId = "iFamily", 
                  label   = E2C("科："), 
                  choices = Items)
    })
    
    output$uiGenus <- renderUI({
      if (!is.null(input$iFamily)) {
        Items <- sort(unique(DAT$genus_c[which(DAT$family_c == input$iFamily)]))
        names(Items) <- E2C(Items)
        selectInput(inputId = "iGenus", 
                    label   = E2C("属："), 
                    choices = Items)
      }
    })
    
    output$uiSpecies <- renderUI({
      if (!is.null(input$iGenus)) {
        Items <- sort(unique(DAT$name_c[which(DAT$genus_c == input$iGenus)]))
        names(Items) <- E2C(Items)
        selectInput(inputId = "iSpecies", 
                    label   = E2C("种："), 
                    choices = Items)
      }
    })
    
  }
})

output$uiLang <- renderUI({
  radioButtons(inputId  = "lang",  label = "", 
               choices  = c("English" = "en", "中文" = "cn"), 
               selected = "cn")
})

output$uiPercent <- renderUI({
  sliderInput(inputId = "iPercent", 
              label   = "", 
              min = 0, max = 100, step = 5, value = 90)
})

output$uiLevel <- renderUI({
  sliderInput(inputId = "iLevel", 
              label   = "", 
              min = 0, max = 100, step = 5, value = 90)
})

output$uiBoxPercent <- renderUI({
  checkboxInput(inputId = "boxPercent", 
                label   = E2C("最小凸多边形"),
                value = TRUE)
})

output$uiBoxLevel <- renderUI({
  checkboxInput(inputId = "boxLevel", 
                label   = E2C("核心区域"),
                value = TRUE)
})


output$uiPicture <- renderUI({
  if (!is.null(input$iSpecies)) {
    HTML(paste('<img src="img/', gsub("[[:punct:]]| |　", "", D$name_e[which(D$name_c == input$iSpecies)]), '.jpg"><br><br>', sep = ""))
  }
})



# output$uiMapType <- renderUI({
#   Items <- c("normal", "satellite", "terrain")
#   names(Items) <- E2C(c("地图", "卫星", "地形"))
#   radioButtons(inputId = "mapType", 
#                label   = "",
#                choice = Items)
# })
