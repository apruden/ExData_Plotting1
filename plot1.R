DATE_FMT = '%d/%m/%Y'
FROM = as.Date('2007-02-01')
TO = as.Date('2007-02-02')

if (!file.exists('data.zip')) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'data.zip', method='curl')
}

data <- read.csv(unz('data.zip', 'household_power_consumption.txt'), sep=";", header=TRUE, na.strings="?")
t <- data[as.Date(data$Date, DATE_FMT) >= FROM & as.Date(data$Date, DATE_FMT) <= TO & !is.na(data$Global_active_power),]

par(bg='white')
hist(t$Global_active_power,
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)',
     col=c('red'))
dev.copy(png, 'plot1.png', width=480, height=480)
dev.off()
