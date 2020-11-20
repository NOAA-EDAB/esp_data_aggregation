# this app requires survdat data, which is not in the git repository

library(shiny)

`%>%` <- dplyr::`%>%`

data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)

ui <- fluidPage(
  textInput(inputId = "SVSPP",
            label = "Enter the SVSPP (a 3-digit number between 000 and 998)",
            value = "000"),
  
  actionButton(inputId = "go", label = "Run report"),
  
  conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                   tags$div("Loading...", id="loadmessage")),
  
  uiOutput("markdown")
)

server <- function(input, output){
  new_SVSPP <- eventReactive(input$go, {input$SVSPP})
  
  output$markdown <- renderUI({
    rmarkdown::render(here::here("R", "survdat_report_template.Rmd"), 
                      params = list(species_ID = new_SVSPP(),
                                    data_source = data)) %>%
      markdown::markdownToHTML() %>%
      HTML()
  })
}

shinyApp(ui = ui, server = server)
