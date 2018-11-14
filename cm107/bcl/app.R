library(shiny)

#shinyApp(ui, server)

bcl <- readr::read_csv("bcl-data.csv")

ui <- fluidPage(
  titlePanel(
    "BC Liquor Price",
    "BCL APP (Window Title)"
  ),
  sidebarLayout(
    sidebarPanel("This text goes in the side bar"),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  )
)

server <- function(input, output) {
  output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
  output$bcl_data <- renderTable(bcl)
}
shinyApp(ui = ui, server = server)
