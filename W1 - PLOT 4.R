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
##                          RACTPOWER -> Global_reactive_power from data selected
##                          SUBMET1 -> Sub_metering_1 from data wanted
##                          SUBMET2 -> Sub_metering_2 from data wanted
##                          SUBMET3 -> Sub_metering_3 from data wanted
##                          VOLTAGE -> Voltage from data wanted
POWERCDS <- fread("household_power_consumption.txt", na.strings="?")
POWERCDS[,Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
POWERCDS[,Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

WANTCDS <- POWERCDS[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
DATETIME <- strptime(paste(WANTCDS$Date, WANTCDS$Time),"%Y-%m-%d %H:%M:%S")
WANTCDS$DATETIME <- as.POSIXct(WANTCDS$DATETIME)

GACTPOWER <- as.numeric(WANTCDS$Global_active_power)
VOLTAGE <- as.numeric(WANTCDS$Voltage)
RACTPOWER <- as.numeric(WANTCDS$Global_reactive_power)
SUBMET1 <- as.numeric(WANTCDS$Sub_metering_1) 
SUBMET2 <- as.numeric(WANTCDS$Sub_metering_2)
SUBMET3 <- as.numeric(WANTCDS$Sub_metering_3)

png("plot4.png", width=480,height=480)
## allows 4 plots in a screen
par(mfrow=c(2,2))
##plot #1: Date & Time vs Global_active_power 
plot(DATETIME,GACTPOWER,
     type="l",xlab="",ylab="Global Active Power",cex=0.2)
## plot #2: Date & Time vs Voltage
plot(DATETIME,VOLTAGE,
     type="l",xlab="datetime",ylab="Voltage")
## plot #3 : Date & Time vs Sub_metering_1
##           with additonal plotting of Sub_metering_2 & Sub_metering_3
## NOTE: annotation of Sub_metering_(1,2,3) noted in legend
plot(DATETIME,SUBMET1,
     type="l", xlab="",ylab="Energy Submetering")
lines(DATETIME,SUBMET2,type = "l", col="red")
lines(DATETIME,SUBMET3,type = "l", col="blue")
legend("topright",col=c("black","red","blue"),
       c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),
       lty=1,bty="o")
## plot #4 : Date & Time vs Global_reactive_power
plot(DATETIME, RACTPOWER,
     type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()

