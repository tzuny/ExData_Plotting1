plot1 <- function() {
  ##checking to see if data file exists
  
  file<-"household_power_consumption.txt"
  
  if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.clousub_setront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
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
  
  ## Ploting the hisogram 

  hist(sub_set$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (KW)")
  
  ##save the plot to an PNG file
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("")
}
