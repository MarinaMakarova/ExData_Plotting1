## load the data into R
power_full <- read.table("./household_power_consumption.txt", header = TRUE, 
                         sep = ";")

## assign correct variable classes to Date and Time
power_full$Date <- as.Date(power_full$Date, "%d/%m/%Y")

## subset data needed for plot (2007-02-01 and 2007-02-02 entries)
power_data <- subset(power_full, Date == "2007-02-01" | Date == "2007-02-02" )

## Formate Time column
Date_Time <- as.POSIXct(paste(power_data$Date, power_data$Time), 
                        format="%Y-%m-%d %H:%M:%S")
power <- cbind(power_data[,1], Date_Time, power_data[,3:9])

## check class and assign as.numeric if other
str(power)
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Global_active_power <- as.numeric(as.character(power$Global_active_power)) 
power$Global_reactive_power <- as.numeric(as.character
                                          (power$Global_reactive_power))
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))

## make sure your graphics device settings are correct. Set the way you want 
##your graphics to appear on the screen and margins
par(mfrow=c(2,2), mar=c(2,4,0.5,0.5), oma=c(1.5,1,1,1), bg = "gray94")

## Draw plots one by one, starting with topleft and going clockwise

## plot 1
with(power, plot(Date_Time, Global_active_power, "n", 
                 ylab = "Global Active Power", xlab = "", cex.lab = 0.7, 
                 cex.axis = 0.7))
with(power, lines(Date_Time, Global_active_power))

##plot 2
with(power, plot(Date_Time, Voltage, "n", ylab = "Voltage", 
                 xlab = "", cex.lab = 0.7, cex.axis = 0.7))
with(power, lines(Date_Time, Voltage))

##plot3
with(power, plot(Date_Time, Sub_metering_1, "n", ylab = "Energy sub-metering", 
                 xlab = "", cex.lab = 0.7, cex.axis = 0.7))
with(power, lines(Date_Time, Sub_metering_1))
with(power, lines(Date_Time, Sub_metering_2, col = "red"))
with(power, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1.2, cex = 0.55, bty = "n")

##plot 4
with(power, plot(Date_Time, Global_reactive_power, "n", cex.lab = 0.7, 
                 cex.axis = 0.7, ylab = "Global reactive power", xlab = ""))
with(power, lines(Date_Time, Global_reactive_power))

## save to png file
dev.copy(png, filename = "plot4.png", width = 480, height = 480)

## CLOSE FILE DEVICE!!!
dev.off()