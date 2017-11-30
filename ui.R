
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyUI(fluidPage(

  # Application title
  titlePanel("Middle and Lower Provo River Compliance App"),

  # Sidebar with user input controls
  sidebarLayout( 
    sidebarPanel(
      selectInput(inputId="site",
                  label = "Site",
                  choices = unique(Provo_River$SiteName),
                  selected = NULL,
                  multiple = FALSE,
                  selectize = TRUE,
                  width = NULL,
                  size = NULL),
      checkboxGroupInput(inputId='param', label=h3("Parameter to Plot"),
                         choices = list('Temperature (C)'= 'Temperature_C',
                                        'Flow (cfs)'='Flow_cfs',
                                        'Dissolved Oxygen (mg/L)'= 'Dissolved_Oxy'),
                         selected = 1),
      hr(),
      dateRangeInput("dates", label = h3("Date range"))
     
    ),

    # Show outputs, text, etc. in the main panel
    mainPanel(
      textOutput("selected_var"),
      plotOutput("wqplot"),
      leafletOutput("mymap"),
      p()
      
    )              
  )
))
