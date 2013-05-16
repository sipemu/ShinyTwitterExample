library(shiny)
library(shinyIncubator)


library(twitteR)
library(RCurl) 
source("tools/twitteR.R")

# Download certificate
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

# Handshake
load("twitoAuth.RData")
registerTwitterOAuth(cred)


library(ggplot2)
theme_set(theme_classic())