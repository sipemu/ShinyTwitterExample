# load libraries
library(twitteR)

#' R function for getting the hourly count of tweets and tweeter
#' 
hour_dist <- function(string, n = 1200, days = 6, lang = "de", plot = TRUE, geocode = NULL, min.freq = 3) {
  date <- c()
  hourly.count <- c()
  user <- c()
  for (i in days:1) {
    tw <- searchTwitter(searchString = string, 
                        n            = n, 
                        lang         = lang, 
                        since        = as.character(Sys.Date() - (i + 1)), 
                        until        = as.character(Sys.Date() - i), 
                        geocode      = geocode)
    
    if (length(tw) > 0) {
      res <- twListToDF(tw)
      hourly.count <- c(hourly.count, sapply(res$created, extract_hour))
      date <- c(date, rep(as.character(Sys.Date() - i), length(res$created)))
      user <- c(user, res$screenName)
    }
  }
  tw <- searchTwitter(searchString = string, 
                      n            = n, 
                      lang         = lang, 
                      since        = as.character(Sys.Date()), 
                      geocode      = geocode)
  if (length(tw) > 0) {
    res <- twListToDF(tw)
    hourly.count <- c(hourly.count, sapply(res$created, extract_hour))
    date <- c(date, rep(as.character(Sys.Date()), length(res$created)))
    user <- c(user, res$screenName)
  }
  return(data.frame(date=date, hourly.count=hourly.count, user=user))
}

#' Get the hour from the tweets
extract_hour <- function(x) {
  return(as.numeric(strsplit(strsplit(as.character(x), 
                                      split = " ")[[1]][2], ":")[[1]][1]))
}




#' http://www.r-bloggers.com/sentiment-analysis-for-airlines-via-twitter/
#'
score.sentiment <- function(sentences, pos.words, neg.words, .progress='none') {
  require(plyr)
  require(stringr)
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array ("a") of scores back, so we use
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}