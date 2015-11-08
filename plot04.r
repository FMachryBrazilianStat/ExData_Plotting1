###################### Johns Hopkins Bloomberg School of Public Health ######################
	### Data Science Specialization (in the framework of Coursera)
		### Exploratory Data Analysis course - Instructor: Roger D. Peng, PhD
			### Course Project 1 - by Fábio Machry - B. Sc. in Statistics, Federal University of Rio de Janeiro, Brazil
#############################################################################################
			
### Using R Version 3.0.1 Windows 8.1 Time-Date configuration UTC - 3h (Brasilia)
### Project Course #01

######### Plot #04 #########

### Setting some initial configurations:
setwd("D:\\Documents\\Estudo\\Estatistica\\Cursos\\Coursera\\
Data Science Specialization\\04 Exploratory Data Analysis by Roger Peng") ### I need to set my working directory

### Loading the data:

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
rm(house.pow.cons) ### saving RAM space

### Now I need to convert the Time and Date from factor to Time-Date object, using the strptime() function:
Rdate <- strptime(as.character(paste(house.pow.cons.final$Date, house.pow.cons.final$Time)), format = "%d/%m/%Y %H:%M:%S")
house.pow.cons.final$Date <- Rdate
### Now I've got a variable with complete Time-Date information, from which I can extract a lot of information. It's not necessary in here,
### but for more information, please see the bibliography note at the end of this file.

### Four plots in the same panel

### Note that I've already set up my working directory
png("plot04.png") ### Not necessary passing more arguments because width = 480px = height is the default

par(mfrow=c(2,2)) ### rowwise order
	### (1,1) position plot
	with(house.pow.cons.final, {
		plot(Date, Global_active_power, type='l',
			ylab = "Global Active Power (kilowatts)", xlab="")
	})
	### (1,2) position plot
	with(house.pow.cons.final, {
		plot(Date, Voltage, type='l',
			ylab = "Voltage", xlab = 'datetime')
	})
	### (2,1) position plot
	with(house.pow.cons.final, {
		plot(x=Date, y=Sub_metering_1, type='l',
			ylab = "Energy sub metering",
			col = "black", xlab="") ### desnecessary since this is already the standard color
		### The x-lab appear in Portuguese, I think this is due to my date-time windows configuration
		lines(x=Date, y=Sub_metering_2, col = "red")
		lines(x=Date, y=Sub_metering_3, col = "blue")
		legend("topright", lty=1, col = c("black", "red", "blue"),
			legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
	})
	### (2,2) position plot
	with(house.pow.cons.final, {
		plot(Date, Global_reactive_power, type='l',
			ylab = "Global_reactive_power", xlab = 'datetime')
	})
dev.off()

### In order to accomplish this task I've had the help of:
	### 1) Crawley, M. J. "The R Book 2nd ed". Wiley, 2013.
	### 2) stackoverflow.com
	### 3) The R help system