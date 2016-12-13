#########################################
# Load the necessary R libraries
#########################################
library(plyr)
library(dplyr)
library(ggplot2)

#########################################
# Get the data
#########################################
# I get the data for each year, one at  time. Which is great, but
# that means the data lacks a column that identifies the season each 
# subset comes from, and I will need that to properly identify the rows.

# Here, I set up the function to trim the extra ID column and add 
# a season column. I will use this function on each file as I read
# the file into the workspace.
edit_tables <- function(df, year) {
  df <- df[, 2:28]
  season <- rep(toString(year), nrow(df))
  df <- cbind(season, df)
}

# Now I can use that function to 
# edit each data frame right when it is created.
b2012 <- read.csv('blazers2012.csv')
b2012 <- edit_tables(b2012, 2012)

b2013 <- read.csv('blazers2013.csv')
b2013 <- edit_tables(b2013, 2013)

b2014 <- read.csv('blazers2014.csv')
b2014 <- edit_tables(b2014, 2014)

b2015 <- read.csv('blazers2015.csv')
b2015 <- edit_tables(b2015, 2015)

b2016 <- read.csv('blazers2016.csv')
b2016 <- edit_tables(b2016, 2016)

#########################################
# Create the main project data frame
#########################################
# Now I need all that data in one "object."
# I can make one data frame out of many by using
# R's "rbind" (or row-bind) function.
blz <- rbind (b2012, b2013, b2014, b2015, b2016)

# Now our project has a data frame called "blz". That will be
# the main item of interest. We could delete the other data frames
# to preserve memory, but these aren't very large files and it doesn't
# make sense to worry about them right now.

# The current blz data frame doesn't have very descriptive 
# column names. In some case they are long and unwieldy for
# the purposes of display in a data frame.
# Here I define some shorter names. Some aren't very descriptive,
# but for the purpose of translating NBA season averages they 
# should make sense.
my_cols <- c('seas', 'pname', 'age',
             'games', 'start', 'mins',
             'fg', 'fga', 'fgp',
             't3p', 't3pa', 't3pp',
             't2p', 't2pa', 't2pp', 'efgp',
             'ft', 'fta', 'ftp',
             'orb', 'drb', 'trb',
             'ast', 'stl', 'blk',
             'tov', 'pf', 'pts')

# Here I assign those column names to the blz data frame.
colnames(blz) <- my_cols

# And the data frame is ready.

#########################################
# Subset the data
#########################################

# Here I create subsets by player.
player <- split(blz, blz$pname)

###################################################################
# I want to create a data frame of players who played more than one season
# in the time frame under consideration.

# Here's the basic functionality. Running this will PRINT the
# different subsets, but it does not STORE them anywhere. This
# is here for demonstration purposes so we can se what we're 
# getting.
for (i in 1:length(player)) {
  if (nrow(player[[i]]) > 1) {
    print (player[[i]])
  }
}

# The mult_seasons() function implements the loop above
# and returns a data frame with the data rearranged.
# Normally, I would use a function from the "dplyr"
# library to do all of this, but this illustrates
# what's happening under the hood.

# Essentially, I am SORTING by player name, and then 
# FILTERING (or SELECTING, in SQL parlance) by length
# of tenure. The dplyr functions "filter" and "arrange"
# would handle this in a couple of commands, but it
# would still require some helper variables to be created
# to index player tenures.
mult_seasons <- function(mylist) {
  collector <- data.frame()
  for (i in 1:length(mylist)) {
    if (nrow(mylist[[i]]) > 1) {
      collector <- rbind(collector, mylist[[i]])
    }
  }
  return(collector)
}

# As an example, we can create "twoplus", a data frame of season
# averages of players with at least 2 years on the team during
# they years in question.
twoplus <- mult_seasons(player)

#########################################
# Visualizations
#########################################
# basic plot: bar charts (for discrete data)

###############
# blazers1
###############
ggplot(blz) + 
  geom_bar(aes(x=age),
           color='wheat4',
           fill='wheat1') +
  ggtitle("Blazers Age Distribution\n2012 - 2016") +
  theme_light()

# histogram (for continuous data)

###############
# blazers2
###############
ggplot(blz) + 
  geom_histogram(aes(x=trb), 
                 binwidth=.85, 
                 color='wheat4', 
                 fill='wheat1') +
  ggtitle("Distribution of Rebounding Averages\nBlazers 2012 - 2016") +
  theme_light()

# horizontal bar chart (for long list of items)

###############
# blazers3
###############
ggplot(blz) +
  geom_bar(aes(x=pname), 
           color='wheat4',
           fill='wheat1') +
  coord_flip() +
  xlab("Seasons") +
  ylab("Player") +
  ggtitle("Blazers Players by Length of Tenure\n2012 - 2016") +
  theme(axis.text.y=element_text(size=rel(0.8)))

# It would be nice to have that chart sorted.
# We need to do some magic tricks in order to reorder the data.
playersums <- table(blz$pname)
playerdf <- as.data.frame(playersums)
colnames(playerdf) <- c('pname', 'count')
playerdf <- transform(playerdf,
                      pname=reorder(pname, count))

# Now we can look at the graph.

###############
# blazers4
###############
ggplot(playerdf) +
  geom_bar(aes(x=pname, y=count),
           stat='identity',
           color='wheat4',
           fill='wheat1') +
  coord_flip() +
  ggtitle("Blazers Players by Length of Tenure\n 2012 - 2016") +
  xlab("Seasons") +
  ylab("Player") +
  theme(axis.text.y=element_text(size=rel(0.8)))









