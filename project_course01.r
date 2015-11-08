### Course Project 1 - by Fábio Machry - B. Sc. in Statistics, Universidade Federal do Rio de Janeiro, Brazil
### Using R Version 3.0.1 Windows 8.1 Time-Date configuration UTC - 3h (Brasilia)

### Setting some initial configurations:
options(digits=4) # I think it's ok working with 4 digits
setwd("D:\\Documents\\Estudo\\Estatistica\\Cursos\\Coursera\\
Data Science Specialization\\04 Exploratory Data Analysis by Roger Peng") ### I need to set my working directory
rm(list=ls()) # in any case, removing any lost variable.

### Module "Loading the data":

### First, we should note that the entire dataset has 2,075,259 rows and 9 columns. So, we can estimate roughly
( (2075259 * 9 * 8) / (2^20)) / 2^10 ### Estimate in GB
### [1] 0.139157  - Roughly 0.14 GB
### Looking my system status, because I have 2.6 GB RAM available, even if I'd load the entire dataset, it'd be ok doing that.
### Another thing you should consider is that I'm using R studio, so that I can visualize the dataset. Ok, so
### I'll load a small number of lines to accomplish an initial visualization of the dataset - this is important because I don't know in advance
### important features such as the separator character, whether there is a header or not, comments and so forth. Of course, I could have
### opened the file in my text editor and discovered it all. But I can accomplish it doing the following:
raw.house.pow.cons <- read.table("household_power_consumption.txt", nrows=100)
### The "raw" read.table() command is the first step because I want to discover the stuff I've mentioned before.
### Now I see: sep is ";", and there is a header in the dataset.
### I can also use the good hint We've learned in R programming module to say to R the col classes:
classes <- sapply(raw.house.pow.cons, class)
house.pow.cons <- read.table("household_power_consumption.txt", header = T,
sep = ";", na.string = "?", colClasses = classes, comment.char = "")
house.pow.cons.final <- subset(house.pow.cons, (house.pow.cons$Date == "1/2/2007" | house.pow.cons$Date == "2/2/2007"))
rm(house.pow.cons) ### saving space in memory

Rdate <- strptime(as.character(paste(house.pow.cons.final$Date, house.pow.cons.final$Time)), format = "%d/%m/%Y %H:%M:%S")
house.pow.cons.final$Date <- Rdate

### Plot 1 - Histogram of Global Active Power

png("plot01.png")
with(house.pow.cons.final, {
	hist(Global_active_power, col='red', xlab = "Global Active Power (kilowatts)",
	main = "Global Active Power")
	})
dev.off()

### Plot 2 - Simple Time Series of Global Active Power

with(house.pow.cons.final, {
plot(Date, Global_active_power, type='l',
	ylab = "Global Active Power (kilowatts)"
	### The x-lab appear in Portuguese, I think this is due to my date-time windows configuration
})

### Plot 3 -

with(house.pow.cons.final, {
	plot(x=Date, y=Sub_metering_1, type='l',
		ylab = "Energy sub metering",
		col = "black") ### desnecessary since this is already the standard color
	### The x-lab appear in Portuguese, I think this is due to my date-time windows configuration
	lines(x=Date, y=Sub_metering_2, col = "red")
	lines(x=Date, y=Sub_metering_3, col = "blue")
	legend("topright", lty=1, col = c("black", "red", "blue"),
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})