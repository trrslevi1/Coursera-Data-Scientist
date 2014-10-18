complete <- function(directory, id = 1:332) {
  dir <- paste("C:/Users/triciaslevin/Desktop/R/", directory, sep = "")
  setwd(dir)
  temp <- list.files(pattern="*.csv")
  t <- data.frame('id' = numeric(), 'nobs' = numeric())
  for(i in 1:length(id)) {
    csv <- read.csv(temp[id[i]], header = TRUE)
    ok <- nrow(csv [complete.cases(csv), ])
    t[i, ] <- list(id[i], ok)
  }
  t
}