ShinyTwitterExample
===================

*oAuth-Hilfe*
+ [Stackoverflow](http://stackoverflow.com/questions/15713073/twitter-help-unable-to-authorize-even-with-registering)
+ [google-groups](https://groups.google.com/forum/?fromgroups#!searchin/shiny-discuss/twitter/shiny-discuss/dXkb6WqeCTE/CeSen29DEGAJ)

## Code:
    library(ROAuth)
    library(RCurl)
    
    requestURL <- "https://api.twitter.com/oauth/request_token"
    accessURL <- "http://api.twitter.com/oauth/access_token"
    authURL <- "http://api.twitter.com/oauth/authorize"
    consumerKey <- "XXX"
    consumerSecret <- "XXX"
    my_oauth <- OAuthFactory$new(consumerKey=consumerKey,
      consumerSecret=consumerSecret, requestURL=requestURL,
      accessURL=accessURL, authURL=authURL)

run this line and go to the URL that appears on screen
    my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))

Setting working folder
    setwd("/your/path/")

now you can save oauth token for use in future sessions with twitteR or streamR
    save(my_oauth, file="my_oauth")

So if you load that "my_oauth" file into Shiny (on the server) you *should* be able to have OAuth authentification with:

    load("my_oauth")
    registerTwitterOAuth(my_oauth)