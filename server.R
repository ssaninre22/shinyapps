
shinyServer(
    function(input, output) {
      
        df2 <- eventReactive(input$do,{
          indicator <- input$hpindicator
          ctry <- input$country
          
          df2 <- df[variable==indicator&country==ctry,]
          return(df2)
        })
        
        bub.comp <- eventReactive(input$do,{
          y        <- df2()$value
          obs      <- length(y)
          swindow0 <- floor(obs*(0.01 + 1.8/sqrt(obs)))
          dim      <- obs - swindow0 + 1
          Tb       <- 24 + swindow0 - 1
          # Estimate PSY statistics and CVs
          bsadf          <- psymonitor::PSY(y, swindow0)
          quantilesBsadf <- psymonitor::cvPSYwmboot(y, swindow0, Tb=Tb, nboot = 50, nCores = 2)
          quantile95     <- quantilesBsadf %*% matrix(1, nrow = 1, ncol = dim)
          # locate bubble/crisis dates
          ind95        <- (bsadf > t(quantile95[3, ])) * 1
          monitorDates <- df2()$date[swindow0:obs]
          OT           <- psymonitor::locate(ind95, monitorDates)
          # Show bubble/crisis periods
          datebub <- psymonitor::disp(OT, obs)
          return(datebub)
        })
        
      output$bubtable <- renderDataTable({  
        if(is.null(bub.comp())){
          "No Model Found"
        } else {
          head(bub.comp())
        }
      })
      
      output$plot1 <- renderPlot({
        ggplot2::ggplot()+
        ggplot2::geom_line(data=df2(),aes(x=as.Date(date),y=value))+
          ggplot2::geom_rect(data=bub.comp(),aes(xmin=as.Date(start),xmax=as.Date(end)),ymin=-Inf,ymax=Inf,alpha=0.3,
                    fill="red")+
          ggplot2::scale_x_date(labels=scales::date_format("%Y-%m"),breaks=scales::date_breaks("4 year"))+  
          ggplot2::scale_y_continuous(limits = c(min(df2()$value)-20,max(df2()$value)+20))+
          ggplot2::theme_bw()+ggplot2::labs(title=paste("Housing bubbles or crises in: ",
                                      ctrycodes[country_code==input$country,country_name],sep=""),
                          x="",y=ifelse(input$hpindicator=="rhpi_rpdi","Real house price to income index",
                                        "Real house price index"))+
          ggplot2::theme(axis.text.x = element_text(angle = 90))
        
      })
      
})
