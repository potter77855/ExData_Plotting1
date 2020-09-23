## scripts created to plot data for 'individal household electric power consumption'
## between 2007-02-01 & 2007-02-02
## dataset is measurments of electric power consumption in 1 minutes samples over 4 year period
## data will be filtered to dates wanted
library("data.table")
## setwd("C:/Users/misc/Documents/COURSERA/R PROGRAMMING/EDA W1 ASSIGNMENT")
## naming scheme: XXXXCDS where CDS -> consumption data set
##                XXXX -> 1) POWER for initial data set of the assignment
##                     -> 2) WANT for data from 2007 for days 02-1 & 02-02 
## scheme for script names: XXXXXCDS
##                          xxxxx: 1)POWER -> DATA GIVEN FROM COURSE
##                                 2)WANT-> DATA FOR GIVEN PERIOD 02-01-2007 & 02-02-2007
##                          DATETIME -> DATAE & TIME FOR PLOTTING
##                          GACTPOWER -> Global_active_power from data wanted
##                          SUBMET1 -> Sub_metering_1 from data wanted
##                          SUBMET2 -> Sub_metering_2 from data wanted
##                          SUBMET3 -> Sub_metering_3 from data wanted
##                          
POWERCDS <- fread("household_power_consumption.txt", na.strings="?")
POWERCDS[,Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
POWERCDS[,Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
WANTCDS <- POWERCDS[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
DATETIME <- strptime(paste(WANTCDS$Date, WANTCDS$Time),"%Y-%m-%d %H:%M:%S")
GACTPOWER <- as.numeric(WANTCDS$Global_active_power)
WANTCDS$DATETIME <- as.POSIXct(WANTCDS$DATETIME)
SUBMET1 <- as.numeric(WANTCDS$Sub_metering_1) 
SUBMET2 <- as.numeric(WANTCDS$Sub_metering_2)
SUBMET3 <- as.numeric(WANTCDS$Sub_metering_3)
png("plot3.png", width=480,height=480)
## create 3rd plot -> Date & Time vs Sub_metering_1
##                    with additonal plotting of Sub_metering_2 & Sub_metering_3
## NOTE: annotation of Sub_metering_(1,2,3) noted in legend
plot(DATETIME, SUBMET1, 
     type="l", xlab="",ylab="Energy sub metering")
lines(DATETIME, SUBMET2, type = "l", col="red" )
lines(DATETIME, SUBMET3, type = "l", col="blue" )
legend("topright",col=c("black","red","blue"),
       c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),
       lty=1,lwd=2.5)
dev.off()


