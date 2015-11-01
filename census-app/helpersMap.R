#helperMap.R
# These functions are meant to create maps for county level data using the map library
# Author: Sam West
#


# Note: percent map is designed to work with the counties data set
# It may not work correctly with other data sets if their row order does 
# not exactly match the order in which the maps package plots counties
percent_map <- function(var, color, legend.title="NI Data",limitRegion="",bins=5,mapTitle="NI Counties",legend=1) {
  if (is.null(var)) return(NULL)
  maxBins=100
  max=max(var)
  min=min(var)
  i=0
  if (bins>100 | bins < 1 ) {
    bins=5
  }
  
  colRange=floor(maxBins/bins)*bins
  gaps=floor(colRange/bins)
  shades <- colorRampPalette(c("white", color))(colRange)
  # constrain gradient to percents that occur between min and max
  colorsUsed=shades[1:(i+gaps)==(i+gaps)]
  
  percents <- as.integer(cut(var, bins, 
                             include.lowest = TRUE, ordered = TRUE))
  fills <- colorsUsed[percents]
  
  # plot choropleth map
  
  map("county", fill = TRUE, col = fills, 
      resolution = 0, projection = "polyconic", 
      region=limitRegion)
  title(mapTitle)
  makeLegend(max,min,bins,colorsUsed,legend.title)

}
makeLegend <-function(max,min,bins,colorsUsed,legend.title){
  inc <- (max - min) / bins
  for (i in 1:bins) {
    textList[i]=paste(round(min+ inc*(i-1))," to ", round(min + i * inc),"")
  }
  
  legend("bottomleft", 
         legend = textList, 
         fill = colorsUsed, 
         title = legend.title)
  
}

sortDFOnVal <-function(df,val,higherIsBetter=FALSE) {
  return(dfOrdered <- df[order(val,decreasing = higherIsBetter),])
}

sortDFtoDF2 <-function(df1,df2,colNum=2) {
  df2[order(match(df2[,colNum],df1[,colNum])),]
  
}

getFiveColors <- function() {
  i=1
  for (i in 1:83) {
    if (i == 1) {
      colors=c("green")
    }
    else if (i < 21) {
      colors <- append(colors,c("green"))
    }
    else if (i < 41) {
      colors <- append(colors,c("blue"))
    }
    else if (i < 61) {
      colors <- append(colors,c("brown"))
    }
    else if (i < 81) {
      colors <- append(colors,c("black"))
    }
    else {
      colors <- append(colors,c("red"))
    }
  }
  return(colors)
}




colorsByTwenties  <- function(val,df,higherIsBetter=FALSE,legend=TRUE,mapTitle="NI Data") {
  
  dfOrdered <- sortDFOnVal(df,val,higherIsBetter)
  colors= getFiveColors()
  
    
  numCols=length(names(dfOrdered)) 
  numCols=numCols+1
  dfOrdered[,numCols] <- colors
  dfOrdered <- dfOrdered[order(match(dfOrdered[,2],df[,2])),]
  map("county", fill = TRUE, col = dfOrdered[,numCols], 
      resolution = 0, projection = "polyconic", 
      region=dfOrdered$County)
  
  
  
  if (legend) {
    inc <- 20
    
    min=1
    bins=5
      text
    for (i in 1:bins) {
      if (i==5) {
        textList[i]="81 to 83"
      }
      else {
        textList[i]=paste(min+ inc*(i-1)," to ", min + i * inc,"")
      }
    }
    title(mapTitle)
    
    legend("bottomleft", 
           legend = textList, 
           fill = c("green","blue","brown","black","red"), 
           title = "County Rankings")
  }
  
  
}




colorCodeByRegion <- function(df,val,valName,colNum) {
  count=0
  gaps=20
  
  dfColors <- df[order(df$Region,val),]
  colorsUsed = c("green","darkblue","yellow","orange","purple","darkgreen","red","cyan","gold","deeppink")
  for (color in colorsUsed) {
    count=count+1
    shades <- colorRampPalette(c("white", color))(100)
    colorsUsed=shades[1:(i+20)==(i+20)]
    regCount=sum(dfColors$Region==count)
    regDf <- dfColors[dfColors$Region==count,]
    regCols <- cut(regDf[,colNum],5,include.lowest = TRUE,ordered=TRUE)
    print(shades[regCols])
    if (count==1) {
      fills <- colorsUsed[regCols]
    }
    else {
      addShades <- colorsUsed[regCols]
      fills <-  append(fills,addShades)
    }
  }
  
  numCols=length(names(dfColors)) 
  numCols=numCols+1
  dfColors[,numCols] <- fills
  dfColors <- dfColors[order(match(dfColors[,2],df[,2])),]
  map("county", fill = TRUE, col = dfColors[,numCols], 
      resolution = 0, projection = "polyconic", 
      region=dfColors$County)
  
  
  #sortDFtoDF2()
  return(dfColors[,numCols])
  #x2[order(match(x2[,2],mostlySorted[,2])),]
}



colorTen <- function() {
  
}


regionMap <- function(var,df, color, legend.title="NI Data",limitRegion="",bins=5,mapTitle="NI Counties",legend=1) {
  reg=df$Region
  bins=10 # for now just hard code the bins at 5 eventually I may make this customizable 
  i=0
  shades <- colorRampPalette(c("white", color))(100)
  # constrain gradient to percents that occur between min and max

  #  colorsUsed=shades[1:(i+10)==(i+10)]
  colorsUsed = c("green","blue","yellow","orange","purple","darkgreen","red","cyan","gold","deeppink")
  
  reg <- factor(reg,levels=c(1:10),ordered=TRUE)
  fills <- colorsUsed[reg]
  map("county", fill = TRUE, col = fills, 
      resolution = 0, projection = "polyconic", 
      region=limitRegion)
  
  
}



