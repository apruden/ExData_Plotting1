DATE_FMT = '%d/%m/%Y'
TIME_FMT = '%H:%M:%S'
FROM = as.Date('2007-02-01')
TO = as.Date('2007-02-02')

if (!file.exists('data.zip')) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'data.zip', method='curl')
}

data <- read.csv(unz('data.zip', 'household_power_consumption.txt'), sep=";", header=TRUE, na.strings="?")
t <- data[as.Date(data$Date, DATE_FMT) >= FROM & as.Date(data$Date, DATE_FMT) <= TO & !is.na(data$Global_active_power),]
t$DateTime <- strptime(paste(t$Date, t$Time, sep=' '),
                       paste(DATE_FMT, TIME_FMT, sep=' '))


par(bg='white')
par(mfrow=c(2, 2))
plot(t$DateTime,
     t$Global_active_power,
     main='',
     xlab='',
     ylab='Global Active Power',
     type='l')

plot(t$DateTime,
     t$Voltage,
     main='',
     xlab='datetime',
     ylab='Voltage',
     type='l')

plot(t$DateTime,
     t$Sub_metering_1,
     main='',
     xlab='',
     ylab='Energy sub metering',
     type='l')
lines(t$DateTime, t$Sub_metering_2, col='red')
lines(t$DateTime, t$Sub_metering_3, col='blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty=1, bty='n', cex=0.7)

plot(t$DateTime,
     t$Global_reactive_power,
     main='',
     xlab='datetime',
     ylab='Global_reactive_power',
     type='l')

dev.copy(png, 'plot4.png', width=480, height=480)
dev.off()
