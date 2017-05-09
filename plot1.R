
# 2017/05/08 Written by Arif Volkan Vural

# Preliminary data processing

 # URL extracted from the web page
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

 # download and read the zip file
  temp <- tempfile()
  download.file(fileUrl, temp)

 # read data into data frame 'data'
  data<- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)
  unlink(temp)

 # convert Date values from factor to Date data type

  dateConvert <- factor(data$Date)
  dateConvert <- as.Date(dateConvert, format = "%d/%m/%Y")
  data$Date <- dateConvert

 # convert Time values from factor to Time data type

  timeConvert <- factor(data$Time)
  timeConvert <- as.character (timeConvert)
  timeConvert <- strptime(timeConvert, format = "%H:%M:%S")
  data$Time <- timeConvert

 # convert other factor values to numeric

  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
  data$Voltage <- as.numeric(as.character(data$Voltage))
  data$Global_intensity <- as.numeric(as.character(data$Global_intensity))
  data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
  data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
  # no need for Sub_metering_3 as it was read as numeric data type 

 # filter the initial data for given values of "2007-02-01" and "2007-02-02"

  filteredData <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]
  rm(data) # remove 'data' data frame to open up some space in memory

# End of preliminary data processing  

# Start of Plot1
 
  hist(filteredData$Global_active_power, col = "red",
       xlab = "Global Active Power (kilowatts)", main = 
       "Global Active Power")
  dev.copy(png, file = "plot1.png", height = 480, width = 480)
  dev.off()

# End of plot 1
