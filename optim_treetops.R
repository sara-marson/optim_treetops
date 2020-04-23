## Canopy analysis in R using Forest Tools
# Attach the 'ForestTools', 'optimParallel' and 'raster' libraries
library(ForestTools)
library(raster)
library(raster)
library(rgdal)
library(optimParallel)

# Load sample canopy height model
CHM <- raster("C://CHM.tif")


#### Target= nunumber of trees found in the field
Target<-500

Trees<-function (data, par) {
  lin <- function(x){x * par[1] + par[2]}
  ttops <- vwf(CHM = data, winFun = lin, minHeight = 2)
  nttops <-sp_summarise(ttops)
  return((Target-nttops)^2)
}
start_time <- Sys.time()
result <- optim(par = c(0.05, 0.6), fn = Trees, data = CHM)
end_time <- Sys.time()
end_time - start_time
result


# Find tree tops: put the values found during the previous step in place of the variables 'a' and 'b' of the function
lin <- function(x){x * a + b }
ttops <- vwf(CHM = CHM, winFun = lin, minHeight = 2)
sp_summarise(ttops)
