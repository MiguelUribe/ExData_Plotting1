library(data.table)

#Read data file
#Assumption: household_power_consumption.txt file is located in the working directory
#NULLS in the data file are denoted as "?"

PowerCompTmp <- fread("household_power_consumption.txt", header= TRUE, na.strings=c("NA","N/A","null", "?"))
                      
#Subset where observations from dates 2007-02-01 and 2007-02-02, using a temporary var
PowerCompTmp$DateTmp <-   as.Date(PowerCompTmp$Date, "%d/%m/%Y")
PowerCompFeb07 <- subset(PowerCompTmp, PowerCompTmp$DateTmp >= as.Date("2007-02-01", "%Y-%m-%d") 
                    & PowerCompTmp$DateTmp <= as.Date("2007-02-02", "%Y-%m-%d"))

#Create a new variable with date+time from Date and Time variables
PowerCompFeb07$DateTime  <-  as.POSIXct(strptime(paste(PowerCompFeb07$Date,PowerCompFeb07$Time),"%d/%m/%Y %H:%M:%S"))

#Clear plotting area
plot.new()

#Plot
with(PowerCompFeb07,plot(DateTime,
                         Sub_metering_1,
                         type = "l",
                         xlab = "",
                         ylab = "Energy Sub metering"
                         ))

with(PowerCompFeb07,points(DateTime,
                         Sub_metering_2,
                         type = "l",
                         col = "red"))

with(PowerCompFeb07,points(DateTime,
                           Sub_metering_3,
                           type = "l",
                           col = "blue"))

legend (x= "topright", 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty=c(1,1,1), 
        lwd=c(1,1, 1),
        col = c("black","red","blue"))
                         
#copy grapgh to a png file 
dev.copy(png, filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

#close the device
dev.off()