library(shiny)


shinyServer(function(input, output) {
  
  cal <- reactive({
    
    h <- read.csv("C:/Users/DIVYA/Desktop/College/CSV files/House_train.csv")
    h = h[complete.cases(h), ]
    
    name<- c( "BsmtFinSF1", "GrLivArea","TotalBsmtSF","MasVnrArea","WoodDeckSF")
    for (i in name){
      outlier1 <- boxplot.stats(h[,i])$out
      h <- h[-which(h[,i] %in% outlier1 ),]
    }
    
    model1 <- lm(SalePrice~GrLivArea+GarageCars+TotalBsmtSF+MasVnrArea+WoodDeckSF+OverallQual+I(Neighborhood =="NoRidge" ) + I(Neighborhood == "NridgHt")+I(Neighborhood == "ClearCr")+I(Neighborhood == "CollgCr")+I(Neighborhood == "Crawfor")+I(Neighborhood == "Somerst")+I(Neighborhood == "StoneBr")+I(Neighborhood == "Timber")+I(Neighborhood == "Veenker")+BsmtQual+I(GarageFinish=="RFn")+I(GarageFinish=="Unf")+I(FireplaceQu=="Gd ")+I(FireplaceQu=="no")+I(FireplaceQu=="Po")+I(FireplaceQu=="TA")+
                   TotRmsAbvGrd+YearRemodAdd+BsmtFinSF1+HeatingQC+MasVnrType, data = h)
    
    a <- c(model1$coefficients)
    i <- a[1]
    a <- a[-1]
    price = switch(input$neigh, "1" = 60008.84491, "2" =40747.35807 , "3" =26436.59614,"4"= 14264.90260,"5"= 31843.25627,"6"= 20252.68084,"7"=55213.55257,"8"=15549.47139  ,"9"=36916.52406 )+
      switch (input$bsmtql,"1	" =0,"2"=-36957.46899 ,"3" = -32945.50345, "4" = -34881.89423,"5"=0,"6"=-33235.42371)+
      switch(input$Mnstype,"1"=0,"2"=5533.51972,"3"=0,"4" =12525.46870,"5"=7478.20899 )+
      switch(input$garage,"1"=0,"2"=-5097.00842 ,"3"=-9343.19345,"4"=0)+
      switch(input$fireqc,"1"=0,"2"=0,"3"=-668.18032 ,"4"=0,"5"=-2840.47459 ,"6"=-8535.22192)+
      switch(input$hqc,"1"=0,"2"=-3755.89523 ,"3"= -4200.86743 ,"4"=-8831.15687,"5"=-17006.77418)+
      switch(input$garage_car,"1"=0,"2"=1,"3"=2,"4"=3)*a[[2]]+
      switch(input$roomabgr,"1"=1,"2"=2,"3"=3 ,"4"=4,"5"=5,"6"=6,"7"=7,"8"=8,"9"=9,"10"=10,"11"=11,"12"=12,"13"=13,"14"=14)*2038.92820
    switch(input$ovrl,"1"=1,"2"=2,"3"=3 ,"4"=4,"5"=5,"6"=6,"7"=7,"8"=8,"9"=9,"10"=10)*a[[7]]+
      input$grla*a[[1]]+
      input$bstarea*a[[3]]+
      input$mansarea*a[[4]]+
      input$woodeck*a[[5]]+
      input$Bsmtfa*15.85787
    if(price <0 ) { price = price*-1}
    return(price)
  })
  
  cities <- read.csv(textConnection("
City,Lat,Long,Pop
Northridge,42.047769,-93.646541,60008.84491
Northridge Heights,42.0598,-93.6644352,40747.35807
Clear Creek,42.029659,-93.659803,26436.59614
College Creek,42.019904,-93.68581,14264.90260
Crawford,42.028973,-93.607174,31843.25627
Somerset, 42.05087,-93.639511,20252.68084
Stone Brooke,42.059073,-93.635441,55213.55257
Timberland,41.999605,-93.649645,15549.47139
Veenker,42.556712,-94.51578 ,36916.52406
"))

  output$plot <- renderLeaflet(
    { leaflet(cities) %>%
        addTiles() %>%  # Add default OpenStreetMap map tiles
        addCircles(lng = ~Long, lat = ~Lat, weight = 1,
                   radius = ~sqrt(Pop), popup = ~City)
    })
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Estimated Sale Price",
      footer = modalButton("Re-Enter the features"),
      renderText(cal()),
      easyClose = TRUE
    ))
  })
  
  
  observeEvent(input$submit, {
    if(input$num <= cal()){
    insertUI(selector = "#play",
             where = "afterEnd",
             ui = tags$audio(src = "negative.mp3", type = "audio/mp3", autoplay = NA, controls = NA, style="display:none;")  
    )}
    else
    {
      insertUI(selector = "#play",
               where = "afterEnd",
               ui=tags$audio(src = "positive.mp3", type = "audio/mp3", autoplay = NA, controls = NA, style="display:none;"))
    }
      })
})