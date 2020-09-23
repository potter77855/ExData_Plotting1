## scripts created to plot data for 'individal household electric power consumption'
## between 2007-02-01 & 2007-02-02
## dataset is measurments of electric power consumption in 1 minutes samples over 4 year period
## data will be filtered to dates wanted
library("data.table")
## naming scheme: XXXXCDS where CDS -> consumption data set
##                XXXX -> 1) POWER for initial data set of the assignment
##                     -> 2) WANT for data from 2007 for days 02-1 & 02-02                    
POWERCDS <- fread("household_power_consumption.txt", na.strings="?")
POWERCDS[,Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
POWERCDS[,Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
WANTCDS <- POWERCDS[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
png("plot1.png", width=480,height=480)
## create 1st plot -> histogram
hist(WANTCDS[,Global_active_power],main="Global Active Power",
     xlab="Global Active Power(kilowatts)",ylab="Frequency",col="Red")
dev.off()


     



