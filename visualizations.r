# From R Graphics Cookbook, W. Chang
library(gcookbook) # data set
library(ggplot2)
library(plyr)


# bar graphs

# fig 3-1 - basic bar graph
ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat="identity")

# fig 3-3 - bar graph with color
ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat="identity", fill="lightblue",
           color="black")

# fig 3-4 - grouping bars together
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(position="dodge", stat="identity")

# fig 3-7 - a bar graph of counts
# use geom_bar, but without mapping anything to y
ggplot(diamonds, aes(x=cut)) +
  geom_bar()

# fig 3-8 - a histogram
# aka a bar graph of counts on a continuous axis
ggplot(diamonds, aes(x=carat)) +
  geom_histogram()

# fig 3-9 - bar graph using colors
upc <- subset(uspopchange, rank(Change) > 40)
ggplot(upc, aes(x=Abb, y=Change, fill=Region)) +
  geom_bar(stat="identity")

# fig 3-11 - bar graph with colors for sign values
csub <- subset(climate, Source=="Berkeley" & Year >= 1900)
csub$pos <- csub$Anomaly10y >= 0
ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
  geom_bar(stat="identity", position="identity")

# fig 3-17 - stacked bar graph
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity") +
  guides(fill=guide_legend(reverse=TRUE))

# fig 3-31 - dot plot with facets and color
tophit <- tophitters2001[1:25, ] # top 25 hitters
nameorder <- tophit$name[order(tophit$lg, tophit$avg)]
tophit$name <- factor(tophit$name, levels=nameorder)
ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, color="grey50") +
  geom_point(size=3, aes(color=lg)) +
  scale_color_brewer(palette="Set1", limits=c("NL", "AL"), guide=FALSE) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank()) +
  facet_grid(lg ~ ., scales="free_y", space="free_y")

# Line Graphs

# fig 4-5 line graph with points
ggplot(worldpop, aes(x=Year, y=Population)) +
  geom_line() +
  geom_point()

# fig 4-13b - line graph with points and color
tg <- ddply(ToothGrowth, c("supp", "dose"), summarize, length=mean(len))
ggplot(tg, aes(x=dose, y=length, color=supp)) +
  geom_line(linetype="dashed") +
  geom_point(shape=22, size=3, fill="white")

# fig 4-19 shaded area graph
sunspotyear <- data.frame (
  Year = as.numeric(time(sunspot.year)),
  Sunspots = as.numeric(sunspot.year)
)

ggplot(sunspotyear, aes(x=Year, y=Sunspots)) +
  geom_area(fill="blue", alpha=0.2) +
  geom_line()

# fig 4-20 - stacked area graph with full colors
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area()

# fig 4-23 - stacked area graph with subtler color, reversed stacking order
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup,
                     order=desc(AgeGroup))) +
  geom_area(color=NA, alpha=.4) + 
  scale_fill_brewer(palette="Blues") +
  geom_line(position="stack", size=.2)

# fig 4-25 - line graph with confidence region
clim <- subset(climate, Source=="Berkeley",
               select=c("Year", "Anomaly10y", "Unc10y"))

ggplot(clim, aes(x=Year, y=Anomaly10y)) +
  geom_ribbon(aes(ymin=Anomaly10y-Unc10y,
                  ymax=Anomaly10y+Unc10y),
              alpha=0.2) +
  geom_line()


# Scatter Plots

# fig 5-1 - basic scatter plot
ggplot(heightweight, aes(x=ageYear, y=heightIn)) +
  geom_point()

# fig 5-4a - scatter plot with third (factor) variable
ggplot(heightweight, aes(x=ageYear, y=heightIn, color=sex)) +
  geom_point()

# fig 5-9a - scatter plot with third (continuous) variable
ggplot(heightweight, aes(x=ageYear, y=heightIn, color=weightLb)) +
  geom_point()

# fig 5-11 - scatter plot with two extra variables
# (one factor, the other continuous), revised colors
ggplot(heightweight, aes(x=ageYear, y=heightIn,
                         size=weightLb, color=sex)) +
  geom_point(alpha=0.5) +
  scale_size_area() + # make area proportional to numeric value
  scale_color_brewer(palette="Set1")

# fig 6-33b - density plot mapped to color
p <- ggplot(faithful, aes(x=eruptions, y=waiting))
p + stat_density2d(aes(color=..level..))

# fig 6-34b - density plot with points and density mapped to alpha
p + geom_point() +
  stat_density2d(aes(alpha=..density..), 
                 geom="tile", 
                 contour=FALSE)





