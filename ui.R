#specify the packages of interest
packages = c("shiny","shinydashboard","plyr","dplyr","data.table","ggplot2","psymonitor")
#packages = c("shiny")



#use this function to check if each package is on the local machine
#if a package is installed, it will be loaded
#if any are not, the missing package(s) will be installed and loaded
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    #install.packages(x, dependencies = TRUE)
    require(x, character.only = TRUE)
  }
  
  #require(x, character.only = TRUE)
  
})

shinyUI(fluidPage(
  titlePanel("Housing Bubbles and Crises periods around the Globe"),
  sidebarLayout(
    sidebarPanel(
      h5("Hi 'bubble' guys. With this app it is possible to explore bubble periods in the house prices for different
         countries around the world. Data is obtained from the International House Price Database from the Dallas FED
         webpage. The methodology employed is described by Phillips, Shi and Yu (2015)"),
      h6("These results are only illustrative, not pretend to be accurate and do not compromise any Government
         institution."),
      h3("Country Selection"),
      h5("Select the country you want to explore"),
      selectInput("country", "Choose a Country code:",
                  list("AUS","BEL","CAN","CHE","DEU","DNK","ESP","FIN","FRA","UK","IRL","ITA","JPN","KOR","LUX","NLD",
                       "NOR","NZL","SWE","US","ZAF","HRV","ISR","WRD")),
      h3("Indicator Selection"),
      h5("Select between these two house prices indicators: the Real house price index (rhpi) or the Real House price
      to disposable income index (rhpi_rpdi)."),
      selectInput("hpindicator", "Choose a House Price indicator:",
                  list("rhpi","rhpi_rpdi")),
      actionButton("do", "Plot Bubbles")
    ),
    mainPanel(
      h3("Bubble periods"),
      dataTableOutput("bubtable"),
      h3("Bubble plot"),
      plotOutput("plot1")
      )
    )
  
    )
  )

