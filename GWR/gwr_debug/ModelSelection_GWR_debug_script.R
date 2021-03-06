Candidate = "TRUMP"
require(sp)

library(sp)
library(rgdal)
library(RColorBrewer)
library(spdep)
library(lattice)
library(latticeExtra)
library(maptools)
library(tmap)
library(spgwr)
library(GWmodel)

#prevents lat long rounding
options("scipen" = 100)

#reads in Countylayer
co = readOGR(dsn = getwd(),layer = "NY_CNTY",integer64="warn.loss")
df_co = data.frame(co)
spdf_co = SpatialPolygonsDataFrame(co,df_co)

#reads-in Data
outvar = "v3_AllTags_002_AllSources_analysis_v3_310_subset.csv"
df = read.table(outvar,header=TRUE, sep=",", na.strings=0, dec=".",strip.white=TRUE)
spdf_co2 = merge(sp,df,by=(intersect(by.x,by.y)),by.x = "NAME", by.y = "County")

#Defines Dependent and Independant Variables
DeVar = "Candidate_VS"
InDeVars= c("Perc_BachelorsDeg_and_higher","perc_Fem")

model.sel <- gwr.model.selection(DeVar,InDeVars, data=spdf_co2,bw=100,approach="aic",
                                 adaptive=T,kernel="bisquare",dMat=NULL,p=2, theta=0, longlat=F)

model.list <- model.sel[[1]]
gwr.model.view(DeVar, InDeVars, model.list = model.list)

#Returns bandwidth, AIC, AICc, RSS
model.sel[[2]]

#Pulls AIC Column
ruler.vector <- model.sel[[2]][,2]
print(ruler.vector)


#numVars = 2
#numVars = list(2)
#numVars = c(2)
numVars = length(InDeVar)

sorted.models <- GWmodel::gwr.model.sort(model.sel,numVars = numVars, ruler.vector = ruler.vector)
model.list <- sorted.models[[1]]

gwr.model.view(DeVar, InDeVars, model.list)
