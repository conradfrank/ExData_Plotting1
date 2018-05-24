library(readr)
library(dplyr)
assignment_file <- "./household_power_consumption.txt"
assignment_data <- read_delim(assignment_file, delim = ";", col_names = TRUE)
data2 <- assignment_data %>%
  filter(!is.na(Global_active_power)) %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  select(Date, Time, contains("Sub"))

data2$Date <- as.Date(data2$Date,  "%d/%m/%Y")

 data2 <- data2 %>%
  mutate(datetime = as.POSIXct(paste(Date, Time)) )

png(filename = "plot3.png", width = 480, height = 480)

with(data2, {
  plot(Sub_metering_1~datetime, type = "l", xlab = "", 
        ylab = "Enery sub metering")
  lines(Sub_metering_2~datetime, type = "l", col = "red")
  lines(Sub_metering_3~datetime, type = "l", col = "blue")
  legend("topright", col = c("black", "red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
          lty = 1, lwd = 2)
  
})

dev.off()

