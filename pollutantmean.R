pollutantmean <- function(directory, pollutant, id = 1:332) {
    dir <- paste("C:/Users/triciaslevin/Desktop/R/", directory, sep = "")
    setwd(dir)
    temp <- list.files(pattern="*.csv")
    m <- numeric()
    for(i in id) {
        csv <- read.csv(temp[i], header = TRUE)
        m <- c(m, csv [, pollutant])       
        }
    round(mean(m, na.rm = TRUE), digits = 3)  
    }