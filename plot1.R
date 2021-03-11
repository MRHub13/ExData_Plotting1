### ... preparation
library("data.table")

filename <- "exdata_data_household_power_consumption.zip"

## ... checking if archieve already exists.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename, method="curl")
}  

## ... checking if household_power_consumption.txt file exists
if (!file.exists("household_power_consumption.txt")) { 
        unzip(filename) 
}

### ... reading data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

### ... preventing histogram from printing in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

### ... changing date column to date type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

### ... filtering dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

### ... defining png file
png("plot1.png", width=480, height=480)

### ... plot1.R
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()