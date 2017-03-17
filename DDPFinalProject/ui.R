#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

data(diamonds)

column_names <- colnames(diamonds)

shape_choices <- c("cut", "color", "clarity")
facet_choices <- c(None = ".", "cut", "color", "clarity")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diamonds Data"),
  
  # Sidebar with a slider input for sample size
  sidebarLayout(
    sidebarPanel(
        p("Dive into the Diamonds dataset by altering any of the parameters below. Check out how price increases as number of carets increase. Start by selecting the sample size to display:"),
       sliderInput("sampleSize",
                   "Sample Size:",
                   min = 1000,
                   max = nrow(diamonds),
                   value = 1000, 
                   step = 500),
       
       selectInput('x_axis', 'X Axis', choices = column_names, selected = "carat"),
       selectInput('y_axis', 'Y Axis', choices = column_names, selected = "price"),
       
       selectInput('color', 'Color Of Point', choices = column_names, selected = "clarity"),
       selectInput('size', 'Size Of Point ', choices = column_names, selected = "cut"),
       selectInput('shape', 'Shape Of Point', choices = shape_choices, selected = "cut"),

       checkboxInput("show_facet", "Do you want the data displayed in a facet?", FALSE),
       conditionalPanel(
           condition = "input.show_facet == true",
           selectInput('facet_row', 'Facet Row', facet_choices, selected = "color"),
           selectInput('facet_col', 'Facet Column', facet_choices, selected = "clarity")
           )

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
