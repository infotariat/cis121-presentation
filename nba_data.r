# nba data
library(XML)
library(plyr)
library(dplyr)
library(ggplot2)
library(reshape2)


# set up the data frame
pHeader=c("seas", "age", "team", "leag", "pos", "games", "strt",
          "min", "fg", "fga", "fgp", "tp", "tpa", "tpp", "duo", 
          "duoa", "duop", "efg", "ft", "fta", "ftp", "orb", "drb", "trb", 
          "ast", "stl", "blk", "tov", "pf", "pts")

pClasses=c("character", "numeric", rep("character", 3), 
           rep("numeric", 25))

pmain <- data.frame(namecol=character(), seas=character(), age=numeric(), 
                    team=character(), leag=character(), pos=character(), 
                    games=numeric(), strt=numeric(),min=numeric(), fg=numeric(), 
                    fga=numeric(), fgp=numeric(), tp=numeric(), tpa=numeric(), 
                    tpp=numeric(), duo=numeric(), duoa=numeric(), duop=numeric(),
                    efg=numeric(), ft=numeric(), fta=numeric(), ftp=numeric(), 
                    orb=numeric(), drb=numeric(), trb=numeric(), ast=numeric(), 
                    stl=numeric(), blk=numeric(), tov=numeric(), pf=numeric(), 
                    pts=numeric())

# html parsing of the XML returned by makeURL
importData <- function(purl) {
  pdoc <- htmlParse(purl)
  pnode <- getNodeSet (pdoc, "//table")
  pdata <- readHTMLTable(pnode[[1]], header=pHeader, colClasses=pClasses)
  return(pdata)
}

# create a NameID column for player in question
makeTidyDF <- function(data, NAME) {
  num <- nrow(data)
  namecol <- rep(NAME, num)
  tidydf <- cbind(namecol, data)
  return(tidydf)
}

# get career season stats for one player
career <- function(playerID) {
  playerURL <- paste("http://www.basketball-reference.com/players/",
                     substr(playerID, 1, 1), "/", playerID, ".html", sep="")
  roughData <- importData(playerURL)
  tidyData <- makeTidyDF(roughData, playerID)
  playerData <- rbind(pmain, tidyData)
  playerData[,2] <- as.numeric(substr(playerData[,2], 1, 4)) + 1
  return (playerData)
}

# get a dataframe of career season stats for a set of players
# USER PROMPT VERSION
comparison <- function() {
  # get desired number of players
  pquant <- readline(prompt="Enter number of players to compare: ")
  allData <- pmain
  for (i in 1:pquant) {
    playerID <- readline(prompt="Enter player code: ") # prompt for the player code(s)
    allData <- rbind(allData, career(playerID))
  }
  allData[,2] <- as.numeric(substr(allData[,2], 1, 4)) + 1
  return(allData)
}

comparison2 <- function(numPlayers, playerVector) {
  allData <- pmain
  for (i in 1:numPlayers) {
    playerID <- playerVector[i]
    allData <- rbind(allData, career(playerID))
  }
  allData[,2] <- as.numeric(substr(allData[,2], 1, 4)) + 1
  return(allData)
}


#############################
# TO DO LIST ################
#############################
# refactor column stuff #####
#############################
# cache searches ############
# and check for #############
# search terms in ###########
# the cache to ##############
# validate before ###########
# requesting from ###########
# website. ##################
#############################



















# stub