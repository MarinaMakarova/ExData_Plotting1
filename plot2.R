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

## make sure your graphics device settings are correct
par(mfrow = c(1,1), mar = c(2, 4, 2, 0.5))

## drow a plot. First, create a blank plot withput any dots or line, then add a
## line connecting all the values
with(power, plot(Date_Time, Global_active_power, "n", 
                 ylab = "Global Active Power (kilowatts)", xlab = "", 
                 cex.lab = 0.75, cex.axis = 0.75))
with(power, lines(Date_Time, Global_active_power))

## save to png file
dev.copy(png, filename = "plot2.png", width = 480, height = 480)

## CLOSE FILE DEVICE!!!
dev.off()
