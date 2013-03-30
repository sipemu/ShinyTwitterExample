# load libraries
library(twitteR)


#################################################################################
#
# R function for getting the hourly count of tweets and tweeter
#
#################################################################################
hour_dist <- function(string, n = 1200, days = 6, lang = "de", plot = TRUE, 
                      geocode = NULL, min.freq = 3) {
  
  date <- c()
  hourly.count <- c()
  user <- c()
  for(i in days:1) {
    tw <- searchTwitter(string, n, lang = lang, since = Sys.Date() - (i + 1), 
                        until = Sys.Date() - i, geocode = geocode)
    if(length(tw) > 0){
      res <- twListToDF(tw)
      hourly.count <- c(hourly.count, sapply(res$created, extract_hour))
      date <- c(date, rep(as.character(Sys.Date() - i), length(res$created)))
      user <- c(user, res$screenName)
      if(plot) {
        myDtm <- word_cloud(res)
        plot_wc(myDtm, min.freq)
        X11()
      }
    }
  }
  tw <- searchTwitter(string, n, lang = lang, since = Sys.Date(), 
                      geocode = geocode)
  if(length(tw) > 0) {
    res <- twListToDF(tw)
    hourly.count <- c(hourly.count, sapply(res$created, extract_hour))
    date <- c(date, rep(as.character(Sys.Date()), length(res$created)))
    user <- c(user, res$screenName)
    if(plot) {
      myDtm <- word_cloud(res)
      plot_wc(myDtm, min.freq)
    }
  }
  
  return(data.frame(date = date, hourly.count = hourly.count, user = user))
}


#################################################################################
#
# Get the hour from the tweets
#
#################################################################################
extract_hour <- function(x) {
  return(as.numeric(strsplit(strsplit(as.character(x), 
                                      split = " ")[[1]][2], ":")[[1]][1]))
}
