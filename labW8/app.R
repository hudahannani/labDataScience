#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Shiny Text"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "dataset",
                        label = "Choose a dataset:",
                        choices = c("human", "abalone","heart", "Iris")),
            numericInput(inputId = "obs",
                         label = "number of observation to view",
                         value = 10)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Summary",verbatimTextOutput("Summary")),
                tabPanel("Table",tableOutput("view")), 
                tabPanel("Plot", plotOutput("plot"))
            )
            ,
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   human <- read.csv('human.csv', stringsAsFactors = FALSE)
   abalone <- read.csv('abalone.csv', stringsAsFactors = FALSE)
   heart <- read.csv('heart.csv', stringsAsFactors = FALSE)
   Iris <- read.csv('Iris.csv', stringsAsFactors = FALSE)
   
   datasetInput <- reactive({
       switch(input$dataset,
              "human"= human,
              "abalone"= abalone,
              "heart" = heart,
              "Iris"= Iris)
   })
   
   output$summary <- renderPrint({
       dataset <- datasetInput()
       summary(datasetInput())
   })
   
   output$view <- renderTable({
       head(datasetInput(), n = input$obs)
   })
   
   output$hist <- renderPlot({
      hist <- (human$weight)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
