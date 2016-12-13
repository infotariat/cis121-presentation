
#########################################
# Part 3: Exploratory Data Analysis     #
#########################################

library(ggplot2)
head(mtcars) # first few rows
help(mtcars) # help documentation, explanation of data

summary(mtcars) # first look at aggregate numbers

# how could we sort this data?
# what are the "factors"?
str(mtcars) # get the structure of the data

# factors include:
# cyl (number of cylinders)
# vs (V/S)
# am (transmission, 0=auto, 1=manual)
# gear (number of forward gears)
# carb (number of carburetors)

# How does MPG differ across different factors?

# We could use boxplots or histograms to compare 
# MPG distribution for different amounts of cylinders, 
# or we could do scatterplots of MPG versus other continuous
# (non-factor) variables (such as horsepower or weight).

# We can also simply plot the different columns one at a time
# to look for any obvious outliers.

# We can also look for missing values (NAs) to make sure we 
# don't have a column with an excessive amount of NAs.

# Let's focus on MPG versus weight
# qplot

# qplot1
qplot(wt, mpg, data=mtcars)

# qplot2
qplot(wt, mpg, data=mtcars, color=cyl)

# qplot3
qplot(wt, mpg, data=mtcars, size=cyl)

# qplot4
qplot(wt, mpg, data=mtcars, facets= vs~am)

mod <- lm(mpg~wt, data=mtcars)

# qplot5
qplot(resid(mod), fitted(mod))

# qplot6
qplot(wt, mpg, data=mtcars, color=I("red"))

# only x supplied = histogram
# qplot7
qplot(mpg, data=mtcars)


# only y = scatterplot, with x = seq_along(y)
# qplot8
qplot(y = mpg, data=mtcars)

# qplot9
qplot(factor(cyl), wt, data=mtcars, geom=c("boxplot", "jitter"))

# qplot10
qplot(mpg, data=mtcars, geom="dotplot")
