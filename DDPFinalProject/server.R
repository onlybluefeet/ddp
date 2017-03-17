#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

data(diamonds)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # use the sample size input to filter the size of the dataset
    dataset <- reactive({
        diamonds[sample(nrow(diamonds), input$sampleSize), ]
    })
    
    # generate the plot based on user input
    plot <- ggplot(dataset(), aes_string(x = input$x_axis, y = input$y_axis, color = input$color, size = input$size, shape = input$shape)) %>%
                 + geom_point()
    
    # if facets have been selected, then add that to the plot
    if (input$show_facet == TRUE) {
        user_facets <- paste(input$facet_row, '~', input$facet_col)
        if(user_facets != ". ~ .")
            plot <- plot + facet_grid(user_facets)
    }
    
    print(plot)
    
  }, height = 800, units="px")
  
})


