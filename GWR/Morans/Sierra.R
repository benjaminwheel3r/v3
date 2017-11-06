rm(list = ls())   #clear out memory
# set up tools:
# 1. Install packages (comment if already installed)
#install.packages("sp")
#install.packages("rgdal")
#install.packages("RColorBrewer")
#install.packages("spdep")
#install.packages("lattice")
#install.packages("latticeExtra")
#install.packages("maptools")

#2. Add libraries from installed packages
library(sp)
library(rgdal)
library(RColorBrewer)
library(spdep)
library(lattice)
library(latticeExtra)
library(maptools)
# set the scientific notation option really high to avoid rounding latitude/longitude values

options("scipen" = 100)

# Data downloaded from https://www.ncdc.noaa.gov/cdo-web/search as CSV:
# Dataset "Normals Monthly", Date range "2010-01-01 to 2010-12-01", Search for "States", Search term "CA"
# Custom Normal Monthly Normals CSV, and check Geographic Location box, units Metric, 
# Selected long-term averages (normals) under Precipitation (snowfall and precip),
# and average, diurnal temperature range (DUTR), monthly minimum (TMIN) and maximum (TMAX) temperature.
# Then graphically selected to cover Sierra Nevada to Lassen extent, and then exported to a new CSV.

setwd("C:\\TEMP\\R_test\\Sierra")
sierraData = read.csv("Sierra2LassenData.csv")
names(sierraData)
year = 2010 # See download above
month = 2   ##### Select the month to use  #####
yearmonth = year * 100 + month

mon = subset(sierraData, sierraData$DATE == yearmonth,
                 select=c(FID, STATION, STATION_NA, ELEVATION, LONGITUDE, LATITUDE, DATE,
                          MLY_PRCP_N, MLY_SNOW_N, MLY_TAVG_N, MLY_DUTR_N, MLY_TMAX_N, MLY_TMIN_N))

summary(mon)  # Note the minimum values of -9999 and such for all of the observational data
# See documentation from NCDC -- -9999 means missing data, and there are other special codes
# So change these to ND.  Should be able to shorten this with a loop or apply function, but this works...
mon$MLY_PRCP_N[mon$MLY_PRCP_N < -1000] = NA
mon$MLY_SNOW_N[mon$MLY_SNOW_N < -1000] = NA
mon$MLY_TAVG_N[mon$MLY_TAVG_N < -1000] = NA
mon$MLY_TMAX_N[mon$MLY_TMAX_N < -1000] = NA
mon$MLY_TMIN_N[mon$MLY_TMIN_N < -1000] = NA
mon$MLY_DUTR_N[mon$MLY_DUTR_N < -1000] = NA
summary(mon)  # Note the better results for observational data
vars = subset(mon, select=c(ELEVATION, LONGITUDE, LATITUDE, MLY_PRCP_N, MLY_SNOW_N, 
                            MLY_TAVG_N, MLY_DUTR_N, MLY_TMAX_N,MLY_TMIN_N))
pairs(vars)  # Note the correlation between avg, min and max temperatures with elevation
# attach(mondata)

# California counties downloaded from ArcGIS and saved in data folder, 
# path accessed as getwd() from working directory set above by setwd()s
co = readOGR(dsn = getwd(),layer = "CA_counties")
ct = readOGR(dsn = getwd(),layer = "CA_places")
#cont = readOGR(dsn = getwd(),layer = "ca_contours500gcs")

monthnames = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

#create a function to remove records with missing data in specific columns
completeFun = function(data, desiredCols) {
  completeVec = complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}
mon = completeFun(mon, c("MLY_PRCP_N","MLY_SNOW_N","MLY_TAVG_N", "MLY_DUTR_N", "MLY_TMAX_N", "MLY_TMIN_N"))

deplist = c("Temp", "Min Temp", "Max Temp", "Precip", "Snowfall")
######  CHOOSE WHICH DEPENDENT VARIABLE -- COMMENT OUT OTHERS with Ctrl-Sh-C:
depcode = 1; mon$dependent = mon$MLY_TAVG_N
# depcode = 2; mon$dependent = mon$MLY_TMIN_N
# depcode = 3; mon$dependent = mon$MLY_TMAX_N
# depcode = 4; mon$dependent = mon$MLY_PRCP_N
# depcode = 5; mon$dependent = mon$MLY_SNOW_N

# Set up spplot symbolization
trellis.par.set(sp.theme()) # sets color ramp to bpy.colors()
nclr = 7
coldwarm.palette = brewer.pal(n = nclr, name = "Spectral") #create a color palette
# High values will be blue, which works for precipitation (red is dry) or snow (blue is more snow)
# If dependent variable is some type of temperature, reverse colors so red is hot, blue is cold:
if (length(subset(c(1,2,3), c(1,2,3) == depcode) == 1)) {coldwarm.palette = coldwarm.palette[nclr:1]}

model1 = lm(mon$dependent ~ mon$ELEVATION) # + mon$LATITUDE)# * mon$LONGITUDE) 
summary(model1)
mon$resid = resid(model1)
mon$predict = predict(model1) 
formula1 = as.character(model1$call[2])

coeff = model1$coefficients
# for (i in 2:length(coeff)) {
#   submodel = lm(mon$dependent ~ )
#   plot(mon$ELEVATION,mon$dependent,xlab=names(coeff[i]),ylab=deplist[depcode])
#   abline(model1)}

if (length(coeff) == 2) {
  if (depcode<4) {
    plot(mon$ELEVATION,mon$dependent,xlab=names(coeff[2]),ylab=deplist[depcode])
    abline(model1)
  }
  }

# Get weather station coordinates and create a SpatialPointsDataFrame with known projection in WGS 84 
latlong <-  "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
mon$coords = cbind(mon$LONGITUDE, mon$LATITUDE)
spdf = SpatialPointsDataFrame(mon$coords, mon, proj4string = CRS(latlong))

r2 = paste("  r-sq =",as.character(as.integer(summary(model1)$r.squared * 10000)/100),"%")
indeps = "Independent Vars:"
allvars = all.vars(formula(model1))
for (i in 3:length(allvars)) {
  indeps = paste(indeps,allvars[i],",")
}
indeps = paste(indeps,r2)

#### spplot method.  First create layers for a basemap of selected cities and CA counties
# sl0 = list('sp.lines',cont, pch=19, cex=.8, col='bisque') # probably won't use unless plot order figured out
sl1 = list('sp.points', ct, pch=19, cex=.8, col='grey')
sl2 = list('sp.pointLabel', ct, label=ct$AREANAME,
             cex=0.7, col='grey')
sl3 = list('sp.polygons', co, col="grey")
sl4 = list('sp.text', c(-119.9,35.6), indeps, cex = 0.7)  # was formula1

# Original dependent variable
spplot(spdf, "dependent", sp.layout = list(sl1, sl2, sl3),
       key.space=list(x=0.6,y=1.0,corner=c(0,1)),
       scales=list(draw=T),
       auto.key = list(title = paste(monthnames[month], as.character(deplist[depcode])), cex.title=1.2),
       col.regions = coldwarm.palette, cex = 1.6,
       cuts = 7, first = TRUE)

# Prediction
spplot(spdf, "predict", sp.layout = list(sl1, sl2, sl3, sl4),
       key.space=list(x=0.6,y=1.0,corner=c(0,1)),
       scales=list(draw=T),
       auto.key = list(title = paste(monthnames[month],"prediction\n",as.character(deplist[depcode])), cex.title=1.2),
       col.regions = coldwarm.palette, cex = 1.6,
       cuts = 7)
summary(model1)

# Residuals
spplot(spdf, "resid", sp.layout = list(sl1, sl2, sl3, sl4),
       key.space=list(x=0.6,y=1.0,corner=c(0,1)),
       scales=list(draw=T),
       auto.key = list(title = paste(monthnames[month],"residual\n",as.character(deplist[depcode])), cex.title=1.2),
       col.regions = coldwarm.palette, cex = 1.6,
       cuts = 7)

crds = coordinates(spdf)
col.rel.nb = graph2nb(relativeneigh(crds), sym=TRUE)
plot(col.rel.nb, crds, col = "light blue")
lm.morantest(model1, listw = nb2listw(col.rel.nb, style="W"))
# Might also try adding a hillshade:  "ca_hillsh_WGS84.tif"

