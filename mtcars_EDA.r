# mtcars_EDA.r
# exploratory data analysis mtcars regression

# This is a demonstration of the use of R's base plotting 
# features, as they might be used in an exploratory analysis
# of the "mtcars" data set.

# This is part of a series of visualizations demonstrating
# R's base graphics library, then the qplot and ggplot
# features of the "ggplot2" library.

#######################################################
# correlations
#######################################################

# pairs plot
#############
# mtcars1
#############
pairs(mtcars, main="mtcars data")
# correlation matrix
cor(mtcars)

#######################################################
# boxplots of mpg vs factor variables
#######################################################

#############
# mtcars2
#############
# MPG by cylinder (mpg~cyl)
boxplot(mpg ~ cyl, mtcars, xlab = "Cylinders",
        ylab = "MPG",
        col = c("red", "blue", "green"),
        main = "MPG by Cylinders")

#############
# mtcars3
#############
# MPG by transmission type (mpg~am)
boxplot(mpg ~ am, mtcars, xlab = "Transmission Type",
        ylab = "MPG",
        col = c("red", "blue"),
        main = "MPG by Transmission Type")

#############
# mtcars4
#############
# MPG by engine type (mpg~vs)
boxplot(mpg ~ vs, mtcars, xlab = "Engine Type",
        ylab = "MPG",
        col = c("red", "blue"),
        main = "MPG by Engine Type")

#############
# mtcars5
#############
# MPG by number of gears (mpg~gear)
boxplot(mpg ~ gear, mtcars, xlab = "Number of Forward Gears",
        ylab = "MPG",
        col = c("red", "blue", "green"),
        main = "MPG by Number of Forward Gears")

#############
# mtcars6
#############
# MPG by number of carburetors (mpg~carb)
boxplot(mpg ~ carb, mtcars, xlab = "Number of Carburetors",
        ylab = "MPG",
        col = c("red", "blue", "green", "yellow", "orange", "purple"),
        main = "MPG by Number of Carburetors")

#######################################################
# scatterplots of mpg vs continuous variables
#######################################################

#############
# mtcars7
#############
# MPG by displacement (mpg~disp)
plot(mpg ~ disp, mtcars,
     xlab = "Displacement (cubic inches)",
     ylab = "MPG",
     col = "red",
     pch = 19,
     main = "MPG by Displacement")

#############
# mtcars8
#############
# MPG by horsepower (mpg~hp)
plot(mpg ~ hp, mtcars,
     xlab = "Gross Horsepower",
     ylab = "MPG",
     col = "red",
     pch = 19,
     main = "MPG by Gross Horsepower")

#############
# mtcars9
#############
# MPG by rear axle ratio (mpg~drat)
plot(mpg ~ drat, mtcars,
     xlab = "Rear Axle Ratio",
     ylab = "MPG",
     col = "red",
     pch = 19,
     main = "MPG by Rear Axle Ratio")

#############
# mtcars10
#############
# MPG by weight (mpg~wt)
plot(mpg ~ wt, mtcars,
     xlab = "Weight (1000 lbs)",
     ylab = "MPG",
     col = "red",
     pch = 19,
     main = "MPG by Weight")

#############
# mtcars11
#############
# MPG by quarter mile time (mpg~qsec)
plot(mpg ~ qsec, mtcars,
     xlab = "Quarter-Mile Time",
     ylab = "MPG",
     col = "red",
     pch = 19,
     main = "MPG by Quarter-Mile Time")






