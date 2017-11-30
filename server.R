
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyServer(function(input, output) {
  output$selected_var <- renderText({
    paste('Viewing water quality data
          at', input$site, 'between', input$dates[1], 'and', 
          input$dates[2])
  })
  
  output$wqplot <- renderPlot({
    plotdata <- subset(Provo_River, SiteName==input$site &
                         DateTime >= input$dates[1] &
                         DateTime <= input$dates[2])
    ggplot()+
      geom_line(data = plotdata, aes(x=plotdata$DateTime, y=plotdata[,input$param],colour=input$param),size=1.2)+
      scale_color_manual(name="Parameter", values="blue")+
      geom_hline(aes(yintercept= 20, linetype = 'Maximimum Permited Water Temperatuare, 20C'), colour= 'red', size=1.2)+
      geom_hline(aes(yintercept=6.5, linetype='Minimum Permited Dissolved Oxygen, 6.5mg/L'), colour="orangered4", size = 1.2)+
      scale_linetype_manual(name = "Water Quality Thresholds", values = c(2,2), 
                            guide = guide_legend(override.aes = list(color = c("red", "orangered4"))))+
      xlab("Date")+ylab(input$param)+
      theme(axis.line.x = element_line(color="black", size = 0.7),
            axis.line.y = element_line(color="black", size = 0.7),
            axis.title = element_text(size=15, face="plain"),
            axis.text.x = element_text(colour = "black", size = 15, angle = 0, hjust = 1, face = "plain"),
            axis.text.y = element_text(colour = "black", size = 15, angle = 0, hjust = 1, face = "plain"))+
      theme(plot.title = element_text(hjust = 0.5))
  })
output$mymap <- renderLeaflet({
  sites <- subset(Provo_River, SiteName==input$site)
  leaflet()%>%
addTiles()%>%
addMarkers(lng=sites$Longitude, lat = sites$Latitude, popup = input$site)
})
  })


