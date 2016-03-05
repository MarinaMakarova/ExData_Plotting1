## load the data into R
power_full <- read.table("./household_power_consumption.txt", header = TRUE, 
                         sep = ";")

## assign correct variable classes to Date and Time
power_full$Date <- as.Date(power_full$Date, "%d/%m/%Y")
power_full$Time <- strptime(power_full$Time, "%H:%M:%S")

## check class of Global_active_power variable. If not numeric, assign numeric 
## class
class(power_data$Global_active_power)
power_data$Global_active_power <- as.numeric(power_data$Global_active_power)

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

## make sure your graphics device settings are correct
par(mfrow = c(1,1), mar = c(4, 4, 2, 0.5))

##draw a histigram
hist(power$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", breaks = 12, xlim = c(0, 6), ylim = c(0, 1200),
     cex.lab = 0.75, cex.axis = 0.75)

## save to png file
dev.copy(png, filename = "plot1.png", width = 480, height = 480)

## CLOSE FILE DEVICE!!!
dev.off()


