library(readr)
library(dplyr)
assignment_file <- "./household_power_consumption.txt"
assignment_data <- read_delim(assignment_file, delim = ";", col_names = TRUE)
data3 <- assignment_data %>%
  filter(!is.na(Global_active_power)) %>%
  filter(Date %in% c("1/2/2007","2/2/2007"))
  

data3$Date <- as.Date(data3$Date,  "%d/%m/%Y")

data3 <- data3 %>%
  mutate(datetime = as.POSIXct(paste(Date, Time)) )

png(filename = "plot4.png", width = 480, height = 480)


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))


with(data3, {
  plot(Global_active_power~datetime, type="l",
       ylab="Global Active Power", xlab="")
  plot(Voltage~datetime, type="l",
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~datetime, type="l",
       ylab="Enery sub metering", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l",
       ,xlab="datetime")
})


dev.off()

