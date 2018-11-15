library(shiny)
library(tidyverse)
bcl <- readr::read_csv("bcl-data.csv")

ui <- fluidPage(
  titlePanel(
    "BC Liquor Price",
    "BCL APP"
  ),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
        min = 0, max = 100, value = c(15, 30), pre = "$"
      ),
      radioButtons("typeInput", "Select you beverage type.",
        choices = unique(bcl$Type), # Notice we can use R code in the arguments
          #c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
        selected = "WINE"
      )
    ),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  )
)

server <- function(input, output) {
  #observe(print(input$typeInput))
  bcl_filtered <- reactive({
    bcl %>%
      filter(
        Price < input$priceInput[2],
        Price > input$priceInput[1],
        Type == input$typeInput
      )
  })

  output$price_hist <- renderPlot({
    bcl_filtered() %>%
      ggplot(aes(Price)) +
        geom_histogram(bins = 30)
  })
  output$bcl_data <- renderTable({
    bcl_filtered()
  })
}
shinyApp(ui = ui, server = server)
