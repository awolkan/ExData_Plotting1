
# 2017/05/08 Written by Arif Volkan Vural

# Preliminary data processing

 # URL extracted from the web page
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

 # download and read the zip file
  temp <- tempfile()
  download.file(fileUrl, temp)

 # read data into data frame 'data'
  data<- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", 
          stringsAsFactors = FALSE, header = TRUE)
  unlink(temp)

 
# convert Time values from string to Time data type

  data$Time <- as.POSIXct(paste(data$Date, data$Time), 
                format = "%d/%m/%Y %H:%M:%S")

# convert Date values from character to Date data type

  data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

 # convert other factor values to numeric

  data$Global_active_power <- as.numeric((data$Global_active_power)
  data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
  data$Voltage <- as.numeric(data$Voltage)
  data$Global_intensity <- as.numeric(data$Global_intensity)
  data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
  data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
  # no need for Sub_metering_3 as it was read as numeric data type 

 # filter the initial data for given values of "2007-02-01" and "2007-02-02"

  fData <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]
  # rm(data) # remove 'data' data frame to open up some space in memory

# End of preliminary data processing  

# Plot 3 Plot the data
 
  plot(fData$Time, fData$Sub_metering_1, type = "l", xlab = "", 
        ylab = "Energy sub metering")
  lines(fData$Time, fData$Sub_metering_2, type = "l", col = "red")
  lines(fData$Time, fData$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
 
# Paste the plot into png file

  dev.copy(png, file = "plot3.png", height = 480, width = 480)
  dev.off()

