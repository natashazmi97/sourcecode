install.packages("shinydashboard")
install.packages("proxy")
install.packages("recommenderlab")
install.packages("reshape2")
install.packages("dplyr")
install.packages("DT")
install.packages("RCurl")
library(shiny)
library(shinydashboard)
library(proxy)
library(recommenderlab)
library(reshape2)
library(plyr)
library(dplyr)
library(DT)
library(RCurl)

movies <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)
movies <- movies[with(movies, order(title)), ]

ratings <- read.csv("ratings100k.csv", header = TRUE)


shinyUI(dashboardPage(skin="blue",
                      dashboardHeader(title = "Movie Recommenders"),
                      dashboardSidebar(
                          sidebarMenu(
                              menuItem("Movies", tabName = "movies", icon = icon("star-o")),
                              menuItem("About", tabName = "about", icon = icon("question-circle")),
                              
                              menuItem(
                                  list(
                                      
                                      selectInput("select", label = h5("Choose Three Best Movie "),
                                                  choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                                  selectize = FALSE,
                                                  selected = "Toy Story (1995)"),
                                      selectInput("select2", label = NA,
                                                  choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                                  selectize = FALSE,
                                                  selected = "King Ralph (1991)"),
                                      selectInput("select3", label = NA,
                                                  choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                                  selectize = FALSE,
                                                  selected = "Underworld (2003)"),
                                      submitButton("Submit")
                                  )
                              )
                              
                          )
                      ),
                      
                      
                      dashboardBody(
                          tags$head(
                              tags$style(type="text/css", "select { max-width: 360px; }"),
                              tags$style(type="text/css", ".span4 { max-width: 360px; }"),
                              tags$style(type="text/css",  ".well { max-width: 360px; }")
                          ),
                          
                          tabItems(  
                              tabItem(tabName = "about",
                                      h2("About this Application"),
                                      
                                      HTML('<br/>'),
                                      
                                      fluidRow(
                                          box(title = "movie recomenders", background = "black", width=7, collapsible = TRUE,
                                              
                                              helpText(p(strong("This application a movie reccomnder app using dataset. User can choose three best movie and this application display the average rating based on selected movie"))),
                                              
                                              helpText(p("Introduction To Data Science Group Project")),
                                              
                                              helpText(p(" "
                                              ))
                                          )
                                      )
                              ),
                              tabItem(tabName = "movies",
                                      fluidRow(
                                          box(
                                              width = 6, status = "info", solidHead = TRUE,
                                              title = "Other Movies You Might Like",
                                              tableOutput("table")),
                                          valueBoxOutput("tableRatings1"),
                                          valueBoxOutput("tableRatings2"),
                                          valueBoxOutput("tableRatings3"),
                                          HTML('<br/>'),
                                          box(DT::dataTableOutput("myTable"), title = "Table of All Movies", width=12, collapsible = TRUE)
                                      )
                              )
                          )
                      )
)
)              

