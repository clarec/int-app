shinyUI(pageWithSidebar(
    
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## Application title
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    headerPanel("Analysis and reporting of coastal processes field data"),
    
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## Sidebar Panel
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    sidebarPanel(
        
        conditionalPanel(
            condition = "input.tsp == 'Map'",
            helpText(HTML("<b>BASIC SETTINGS<b>")),
            
            #textInput("poi", "Enter a location of interest:", "Lowestoft"),
            #helpText("Examples: Lowestoft, "),
            radioButtons('datatype', "Point data sets:", 
                         c("tide gauges", "smart buoys", "all"), 
                         selected = "all")#,
            
            ),
        
        conditionalPanel(
            condition = "input.tsp == 'Map'",
            helpText(HTML("<b>MAP SETTINGS</b>")),
            
            #selectInput("facet", "Choose Facet Type:", choice = c("none","type", "month", "category")),
            selectInput("type", "Choose Google Map Type:", choice = c("roadmap", "satellite", "hybrid","terrain"), selected = "terrain"),    
            checkboxInput("res", "High Resolution?", TRUE),
            checkboxInput("bw", "Black & White?", FALSE),
            sliderInput("zoom", "Zoom Level (Recommended = 14):", 
                        min = 5, max = 15, step = 1, value = 5)
            ),
        
        #wellPanel(
        #    helpText(HTML("<b>MISC. SETTINGS</b>")),
        #    checkboxInput("watermark", "Use Watermark?", FALSE)
        #    ),
        
        width = 3
        
        ),
    
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## Main Panel
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    mainPanel(
        tabsetPanel(
            
            ## core tabs
            
            tabPanel("Map", plotOutput("map")),
            tabPanel("About"),
            id = "tsp"
            )
        )
))