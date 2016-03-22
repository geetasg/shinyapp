# Contributed by Joe Cheng, February 2013
# Requires googleVis version 0.4.0 and shiny 0.4.0 or higher
# server.R
library(googleVis)
library(shiny)
metro_data <- read.csv("/Users/geetasg/shiny/App3/t.csv", stringsAsFactors = FALSE)
Permits_Increase <- 0;

for (i in 2:nrow(metro_data)) {
  if(metro_data$Metro[i] == metro_data$Metro[i-1])
  {
    Permits_Increase[i] <- metro_data$BP[i]/ metro_data$BP[i-1]
  }
}

metro_data <- cbind(metro_data, Permits_Increase)

metro_data$Dramatic_Increase<- metro_data$Permits_Increase > 1.3;

metro_data$Dramatic_Increase<- as.character(metro_data$Dramatic_Increase);

metro_data$Time <- as.numeric(metro_data$Year)


shinyServer(function(input, output) {

  output$choose_dataset <- renderUI({
    selectInput("dataset", "Metro", as.list(metro_data$Metro))
  })
  
  
  output$view <- renderGvis({
  
  if(is.null(input$dataset))
  {
    return()
  }
  
  myStateSettings <-'
        {
         "iconKeySettings":[{"trailStart":"2009","key":{"dim0":"San Jose-Sunnyvale-Santa Clara"}},{"trailStart":"2009","key":{"dim0":"ReplaceMe"}}],
         "nonSelectedAlpha":0,
         "sizeOption":"2",
         "xZoomedDataMin":1230768000000,
         "yLambda":1,"showTrails":true,
         "colorOption":"5",
         "dimensions":{"iconDimensions":["dim0"]},
         "yZoomedDataMax":113340,
         "xAxisOption":"_TIME",
         "orderedByX":false,
         "playDuration":15000,
         "xLambda":1,"xZoomedIn":false,
         "iconType":"BUBBLE",
         "uniColorForNonSelected":false,
         "yZoomedIn":false,
         "duration":{"multiplier":1,"timeUnit":"Y"},
         "time":"2009",
 
         "yZoomedDataMin":41560,
 
         "orderedByY":false,"yAxisOption":"3","xZoomedDataMax":1388534400000}
'
    
    myStateSettings <- gsub("ReplaceMe", input$dataset ,myStateSettings);
    
  
    gvisMotionChart(metro_data, "Metro",
                    timevar = "Year",
                    yvar = "Jobs",
                    xvar = "Time", 
                    colorvar = "Dramatic_Increase",
                    sizevar = "BP",
                    options=list( 
                                 colors="['black', 'green']", 
                                 width="800px", height="500px",
                                 showChartButtons = FALSE,
                                 showYMetricPicker = FALSE,
                                 showTrails = TRUE,
                                 showXMetricPicker = FALSE,
                                 showYMetricPicker = FALSE,
                                 showAdvancedPanel = FALSE,
                                 showSidePanel = FALSE,
                                 showSelectListComponent = FALSE,
                                 state = myStateSettings
                                 )
                    
                    
    )
  })
})
