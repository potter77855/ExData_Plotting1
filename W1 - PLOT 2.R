## scripts created to plot data for 'individal household electric power consumption'
## between 2007-02-01 & 2007-02-02
## dataset is measurments of electric power consumption in 1 minutes samples over 4 year period
## data will be filtered to dates wanted
library("data.table")
## scheme for script names: XXXXXCDS
##                          xxxxx: 1)POWER -> DATA GIVEN FROM COURSE
##                                 2)WANT-> DATA FOR GIVEN PERIOD 02-01-2007 & 02-02-2007
##                          DATETIME -> DATAE & TIME FOR PLOTTING
##                          GACTPOWER -> Global_active_power from data wanted
##                          
POWERCDS <- read.table("household_power_consumption.txt", header= T,sep=";",na.strings="?")
POWERCDS <- fread("household_power_consumption.txt", na.strings="?")
POWERCDS[,Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
POWERCDS[,Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
WANTCDS <- POWERCDS[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
DATETIME <- strptime(paste(WANTCDS$Date, WANTCDS$Time),"%Y-%m-%d %H:%M:%S")
GACTPOWER <- as.numeric(WANTCDS$Global_active_power)
WANTCDS$DATETIME <- as.POSIXct(WANTCDS$DATETIME)
png("plot2.png",width=480,height=480)
## create 2nd plot -> Date & Time vs Global Active Power
plot(DATETIME, GACTPOWER,
     type="l",xlab="",ylab="Global Active Power(kilowatts)",
     ylim = c(0,10))
dev.off()
