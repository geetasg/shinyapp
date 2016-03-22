# ui.R
shinyUI(fluidPage( 
  theme = "bootstrap.css",
  
  
  h2("Building Permits"),    
  h4("Dramatic increase in building permits indicates job growth"),
  hr(),
  uiOutput("choose_dataset"),
  
  hr(),
  h4("Building Permits predict job growth"),
  helpText("Building permits is a relatively early indicator of growth. 
           In the motion chart below, y axis indicates Software jobs per year. 
           The size of the bubble indicates number of building permits. 
           If the building permits increase dramatically, the color of the bubble becomes green."),
  helpText("San Jose is kept in the chart as a comparison point."),
       
  
 
  htmlOutput("view")
  
  
))
