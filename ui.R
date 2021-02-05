library(shiny)
library("shinythemes")
library("shinyWidgets")
library(leaflet)

shinyUI(
  fluidPage
  (theme = shinytheme("slate"), 
    #setBackgroundImage(
    #  src  = 'https://wallpapercave.com/wp/wp2464244.jpg'
    #),
    titlePanel("Horcrux Housing Price"),
    tabsetPanel(id="navbar",
                
                #HOME TAB            
                tabPanel("HOME", 
                         #setBackgroundImage(src  = 'https://wallpapercave.com/wp/wp2464244.jpg'),
                         sidebarLayout(
                           sidebarPanel( width = 3,
                                         tags$h2("Welcome to Horcrux Housing  Price "),
                                         tags$img(src = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTBe2lbeZCb8LQ-Td927oPKObqaSXAxBTqR6ICzW_jGnDWbFJN1', height = "100%", width = "100%"),
                                         tags$img(src = 'https://adsk-designacademy-content-live.s3.amazonaws.com/s3fs-public/design_files/10%20a.png', height = "100%", width = "100%"),
                                         tags$img(src = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFhMc_X4Xk_PR3UKCLKxLVdaHjKLVeul9hJOmJvw5L7iJd1_ho', height = "100%", width = "100%") ),   
                           mainPanel(
                             strong(h1("Welcome to Horcrux Housing  Price", align = "center"),
                                    em(h3("Are you worried about how much price would it cost to buy your dream house?", align = "center",style = "color:blue")),
                                    h4("Here we are to help you - Pricing your home just right ", align = "center"),
                                    h3("About us"),
                                    h4("We the team of horcrux predicting the sale price for the given description of your dream house
                                                  To make user friendly app where they can estimate the budget of house right at your finger tips with more ease"),
                                    
                                    )  ,                                                  
                           
    
  ))),
    tabPanel("NEIGHBOURHOOD",
             sidebarLayout(
               sidebarPanel(width=3,
                            tags$h2("Select the neighborhood"),
                            tags$h4("The size of circle is proportional to the sale price of house in that locality")
               )
               ,
               mainPanel(
                 #actionButton("play", "Play the Audio"),
                 #actionButton("Play","Play"),
                 selectInput(inputId = "neigh",label = "Neighborhood",choices = list("Northridge" = 1,
                                                                                     "Northridge Heights" = 2,
                                                                                     "Clear Creek" = 3,
                                                                                     "College Creek" = 4,
                                                                                     "Crawford" = 5,
                                                                                     "Somerset" = 6,
                                                                                     "Stone Brook" = 7,
                                                                                     "Timberland" = 8,
                                                                                     "Veenker" = 9))
                  ,leafletOutput("plot",height = 500,width = 600)
               )
             )  
    ),
  tabPanel("Select Features",
           
           
           
           sidebarLayout(
             sidebarPanel( width = 3, h2("Please read the instructions"),
                           
                           h4("Above grade living area square feet - ** In square feet only"),
                           
                           h4("Total basement area - ** In square feet only"),
                           
                           h4("Wood deck area - ** In square feet only"),
                           
                           
                           h4("Masonry Veneer Area - ** In square feet only"),
                           
                           h4("Basement finished Area - ** In square feet only "),
                           
                           h4("Total Rooms above grade - ** In square feet only "),
                           
                           h4("Number of cars in garage - Enter the total number of cars the garage should accomodate"),
                           
                           h4("Fireplace Quality- THis has 6 options:
                                          Excellent - Exceptional Masonry Fireplace
                                          Good - Masonry Fireplace in main level
                                          Average - Prefabricated Fireplace in main living area or Masonry Fireplace in basement
       	                                  Fair - Prefabricated Fireplace in basement
                                          Poor - Ben Franklin Stove
                                        	No Fireplace"),
                           
                           h4("Overall rating of the house-  Each values respresents the condition below.Please select accordingly
                                       10	Very Excellent
                                       9	Excellent
                                       8	Very Good
                                       7	Good
                                       6	Above Average	
                                       5	Average
                                       4	Below Average	
                                       3	Fair
                                       2	Poor
                                       1	Very Poor"),
                           
                           h4("Interior finish of the garage"),
                           
                           h4("Masonry Veneer Type"),
                           
                           h4("Basement Quality"),
                           
                           h4("Heating quality and condition")
                           
                           
             ),
             mainPanel(
               em(h1("Please enter the expected features", align = "center",style = "color:White")),
               
               
               fluidRow(h1("SELECT THE INTERIOR FEATURES"),
                        
                        splitLayout(cellWidths = 700, 
                                    column(12, sliderInput("grla", label = h2("Above ground living area",style = "color:white"), min = 334,  max = 5642, value = 334)),
                                    
                                    
                                    
                                    selectInput("bsmtql", label = h2("Basement Quality",style = "color:white"), 
                                                choices = list("Excellent (100+ inches)	" = 1, 
                                                               "Good (90-99 inches)" = 2, 
                                                               "Typical (80-89 inches)" = 3,
                                                               "Fair (70-79 inches)" = 4,
                                                               "Poor (<70 inches" = 5,
                                                               "No Basement" = 6)
                                                ,selected = "No Basement"
                                    )
                        )),
               
               
               fluidRow(
                 
                 splitLayout(cellWidths = 700,
                             
                             column(12, sliderInput("Bsmtfa", label = h2("Basement finished Area ",style = "color:white"), min = 0, 
                                                    max = 5644, value = 0)),
                             
                             selectInput("hqc", label = h2("Heating quality and condition",style = "color:white"), 
                                         choices = list("Excellent" = 1, 
                                                        "Good" = 2, 
                                                        "Average/Typical" = 3,
                                                        "Fair" = 4,
                                                        "Poor " = 5)
                                         # , selected = 1 )
                             ))),
               
               
               fluidRow(
                 
                 splitLayout(cellWidths = 700,
                             
                             column(12, sliderInput("bstarea", label = h2("Total basement area ",style = "color:white"), min = 0, 
                                                    max = 1600, value = 0)),
                             
                             selectInput("fireqc", label = h2("Fireplace Quality ",style = "color:white"),
                                         choices = list("Excellent	" = 1,
                                                        "Good " = 2, 
                                                        "Average " = 3,
                                                        "Fair " = 4,
                                                        "Poor " = 5,
                                                        "No Fireplace" = 6))
                 )),
               
               
               fluidRow(
                 
                 splitLayout(cellWidths = 700,
                             radioGroupButtons("roomabgr", label = h2("Total rooms above grade",style = "color:white"),
                                               choices = list("1"=1,
                                                              "2" = 2,
                                                              "3" = 3,
                                                              "4" = 4,
                                                              "5" = 5,
                                                              "6" = 6,
                                                              "7" = 7,
                                                              "8" = 8,
                                                              "9" = 9,
                                                              "10" = 10,
                                                              "11" = 11,
                                                              "12" = 12,
                                                              "13" = 13,
                                                              "14" = 14)),
                             
                             selectInput("garage", label = h2("Interior finish of the garage",style = "color:white"), 
                                         choices = list("Finished" = 1, 
                                                        "Rough Finished	" = 2, 
                                                        "Unfinished" = 3,
                                                        "No Garage" = 4))
                             
                             
                 )),
               
               
               fluidRow(
                 
                 splitLayout(cellWidths = 700,
                             radioGroupButtons("garage_car", label = h2("Number of cars in Garage ",style = "color:white"), 
                                               choices = list( "0" = 1,
                                                               "1" = 2,
                                                               "2" = 3,
                                                               "3" = 4))
                             
                             
                 )),
               
               fluidRow(h1("SELECT THE EXTERIOR FEATURES"),
                        
                        
                        splitLayout(cellWidths = 700, 
                                    
                                    column(12, sliderInput("woodeck", label = h2("Wood deck area in square feet ",style = "color:white"), min = 0, 
                                                           max = 10000, value = 0)),
                                    
                                    selectInput("Mnstype", label = h3("Masonry veneer type", style = "color:white"),
                                                choices = list("Brick Common" = 1, 
                                                               "Brick Face" = 2, 
                                                               "Cinder Block" = 3,
                                                               "None" = 4,
                                                               "Stone" = 5), 
                                                selected = 1)
                                    
                        )),
               
               fluidRow(
                 splitLayout(cellwidths = 700,
                             
                             column(12, sliderInput("Mnstype", label = h2("Masonry Veneer Area",style = "color:white"), min = 0, 
                                                    max = 1600, value = 0)), 
                             
                             radioGroupButtons("ovrl", label = h2("Overall rating of the house ",style = "color:white"), #needs description
                                               choices = list("1" = 1,
                                                              "2" = 2,
                                                              "3" = 3,
                                                              "4" = 4,
                                                              "5" = 5,
                                                              "6" = 6,
                                                              "7" = 7,
                                                              "8" = 8,
                                                              "9" = 9,
                                                              "10" = 10))
                 )),
               numericInput("num",label = "Enter your price",value = 0),
               actionButton("play", "Play the Audio"),
               #textInput("num","Enter your Budget"),
               actionButton("submit", "SUBMIT"),
               #actionButton("dummy","Dummy")
               
             ))
           )

  
  
    )      
    
    
  )
)


