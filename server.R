# interview app
rm(list=ls())

# packages required for this app
pkgs <- c("shiny","ncdf", "ggplot2", "zoo", "RColorBrewer", "ggmap", "ggvis")
pkgs <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]
# check if all the packages are installed (if not, install them)
if(length(pkgs)) install.packages(pkgs,repos="http://cran.cs.wwu.edu/")

# load the packages
require(shiny); require(ncdf); require(ggplot2); require(zoo); require(RColorBrewer); require(ggmap); require(ggvis)

# set up some variables
#indir="E:/data/coughcl/Documents/R/toolboxApp/data/"
mypalette<-rev(brewer.pal(10,"Spectral"))

shinyServer(function(input, output) {
    
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## Reactive Functions
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    ## Get geocode
    #map.geocode <- reactive({
    #    suppressMessages(data.frame(geocode = geocode(paste(input$poi, "UK"))))
    #})
    
    
    
    
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## Output - map
    ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    output$map <- renderPlot({

        #temp.geocode<-map.geocode()
        temp.geocode <- suppressMessages(data.frame(geocode = geocode(paste("Norfolk","UK"))))
        
        ## get df
        #df <- create.df()
        
        # create a data from for the map center (point of interest)
        #center.df <- data.frame(temp.geocode, location = input$poi)
        #colnames(center.df) <- c("lon", "lat", "location")
        
        # download basemap using ggmap
        # note that a .png file "ggmapTemp.png" will be created
        # the .png is not needed
        
        # define colour and scale of basemap
        if (input$bw) temp.color <- "bw" else temp.color <- "color"
        if (input$res) temp.scale <- 2 else temp.scale <- 1
        
        map.base <- get_googlemap(
            as.matrix(temp.geocode),
            maptype = input$type,
            #markers = temp.geocode,
            zoom = input$zoom, 
            color = temp.color, 
            scale = temp.scale
            )
        
        # convert the base map into a ggplot object
        # added cartesain coordinates to enable more geom options later on
        map.base <- ggmap(map.base, extend = "panel") + coord_cartesian() + coord_fixed(ratio = 1.5)
        
#         if (input$datatype == "tide gauges" | input$datatype == "all") {
#             ## read tide locations
#             df_tidelocs <- read.table("./data/tide_locations.txt", sep="\t", header=TRUE)
#             ## plot tide locations
#             map.base <- map.base + geom_point(df_tidelocs, aes(x = Lat.N, y = Lon.E))  }
        
        map.final <- map.base +
            
            ## Configure the scale and panel
            #scale_fill_gradient(low = input$low, high = input$high) +
            #scale_alpha(range = input$alpharange) +
            
        ## Title and lables
            labs(x = "Longitude", y = "Latitude") +
            ggtitle(paste("need title", "to go here")) +
            
            ## other theme settings
            theme_bw() + 
            theme(
                plot.title = element_text(size = 26, face = 'bold', vjust = 2),
                axis.text = element_blank(),
                axis.title = element_blank(),
                axis.ticks = element_blank(),
                legend.position = "none",
                strip.background = element_rect(fill = 'grey80'),
                strip.text = element_text(size = 18)
            )
        
        
#         # Use Watermark?  
#         if (input$watermark) {
#             #if (input$facet == "none") {
#             map.final <- map.final + annotate("text", x = center.df$lon, y = -Inf, 
#                                                   label = "http://clare.shinyapps.io/interviewApp",
#                                                   vjust = -1.5, col = "steelblue", 
#                                                   cex = 10,
#                                                   fontface = "bold", alpha = 0.5)
#         }


        ## display ggplot2 object
        print(map.final)
        
    }, width = 900, height = 900)
    
})
