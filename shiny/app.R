library(shiny)
library(dplyr)

checkboxGroupInputWithAllSelector <- function(inputId, label, choices = NULL, selected = NULL, inline = FALSE, 
                                  width = NULL, choiceNames = NULL, choiceValues = NULL, allSelectorLabel = "All/None"){
  
  choicesWithAllSelector <- c(allSelectorLabel, choices)
  if (!is.null(selected) & all(selected %>% sort() == choices %>% sort)) {
    selectedWithAllSelector <- c(selected, allSelectorLabel)
  } else {
    selectedWithAllSelector <- selected
  }

  checkboxGroupInputNew <- checkboxGroupInput(
    inputId = inputId, label = label, choices = choicesWithAllSelector, selected = selectedWithAllSelector, inline = inline,
    width = width, choiceNames = choiceNames, choiceValues = choiceValues
  )
  
  allSelectorCheckbox <- checkboxGroupInputNew$children[[2]]$children[[1]][[1]]
  allSelectorCheckbox <- allSelectorCheckbox %>% 
    modifyAllSelectorCheckbox(inputId)
  checkboxGroupInputNew <- checkboxGroupInputNew %>% 
    addAllSelectorCheckboxToCheckboxGroup(allSelectorCheckbox)
  
  checkboxGroupInputNew
}

modifyAllSelectorCheckbox <- function(allSelectorCheckbox, inputId){
  allSelectorCheckbox$children[[1]]$children[[1]]$attribs$class <- "allOrNoneSelector"
  allSelectorCheckbox$children[[1]]$children[[1]]$attribs$onclick <- "selectOrDeselectAllOfInputId(this.name, this.checked)"
  allSelectorCheckbox$children[[1]]$children[[1]]$attribs$name <- paste0(inputId,"_allSelector")
  allSelectorCheckbox
}

addAllSelectorCheckboxToCheckboxGroup <- function(checkboxGroupInputNew, allSelectorCheckbox){
  checkboxGroupInputNew$children[[2]]$children[[1]][[1]] <- NULL
  checkboxGroupInputNew$children <- list(
    checkboxGroupInputNew$children[[1]]
    , allSelectorCheckbox
    , checkboxGroupInputNew$children[[2]]
  )
  checkboxGroupInputNew
}

ui <- fluidPage(

    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      , tags$script(src = "custom.js")
    ),
  
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInputWithAllSelector(
              inputId = "test1"
              , label = "label1"
              , choices = LETTERS[1:10]
            )
        ),

        mainPanel(
           textOutput("test11")
        )
    )
)

server <- function(input, output) {

    output$test11 <- renderText({
        paste(input$test1, collapse = ", ")
    })
}

shinyApp(ui = ui, server = server)
