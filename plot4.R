plot4 <- function() {
  ##checking to see if data file exists
  
  file<-"household_power_consumption.txt"
  
  if(!file.exists("household_power_consumption.txt")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
  }
  
  cat("Reading data\n")
  power_data <- read.table(file, header=T, sep=";")
  
  ##convering the Date field from character to Date format
  
  power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
  
  ##create a subset with only the two dates we need
  
  sub_set <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]
  
  ##convert all the fields we need from caharacter to numeric
  
  sub_set$Global_active_power <- as.numeric(as.character(sub_set$Global_active_power))
  sub_set$Global_reactive_power <- as.numeric(as.character(sub_set$Global_reactive_power))
  sub_set$Voltage <- as.numeric(as.character(sub_set$Voltage))
  sub_set <- transform(sub_set, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
  sub_set$Sub_metering_1 <- as.numeric(as.character(sub_set$Sub_metering_1))
  sub_set$Sub_metering_2 <- as.numeric(as.character(sub_set$Sub_metering_2))
  sub_set$Sub_metering_3 <- as.numeric(as.character(sub_set$Sub_metering_3))
  
  ## generating the plot
  
  par(mfrow=c(2,2))
  
  ##PLOT 1
  
  plot(sub_set$timestamp,sub_set$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  ##PLOT 2
  
  plot(sub_set$timestamp,sub_set$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##PLOT 3
  
  plot(sub_set$timestamp,sub_set$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(sub_set$timestamp,sub_set$Sub_metering_2,col="red")
  lines(sub_set$timestamp,sub_set$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #PLOT 4
  
  plot(sub_set$timestamp,sub_set$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  ## Save the output file to a PNG
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("")
}
