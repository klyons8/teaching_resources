#'PSYCH  9041: Plotting in R 
#'Course website: https://gribblelab.org/teaching/stats2019/
#'By Kathleen Lyons
#'Feb 6, 2019


### Tidyverse is great for data wrangling

install.packages("tidyverse")
library(tidyverse)

## Let's play around with R dataset 'Orange'

summary(Orange)
str(Orange)
glimpse(Orange)

## What if we want to look at only the data from the trees equal or younger to the mean? 

Young_Trees = filter(Orange, age <= 1004)
Younger_Trees = filter(Orange, 100 <= age, age <= 800)

#If you want an specific age range, you can include n <= age, age <= n
#If you only want some variables you can use the piping function (%>%) in tidyverse

Young_Trees2 = Orange %>%
  filter(118 <= age, age <= 1004) %>% 
  select(Tree, age)

## How would we filter the Orange data so we get the trees older than the mean?
Old_Trees = filter(Orange, age >= 1004)
summary(Old_Trees)

#the function subset can also be used to do similar things. For example:

Young_Trees3 = subset(Orange, age <= 1004)
Young_Trees3

#We can also subset type of tree, 

Tree_1 = subset(Orange, Tree == '1')
Tree_1

#What if you just want the first three trees?

Tree_123 = subset(Orange, Tree == '1' | Tree == '2' | Tree == '3')

Tree_34 = subset(Orange, Tree == '3' | Tree == '4')

#Or what if I want Trees that are type 1 and between below the age 1004?

Young_1 = subset(Orange, Tree == '1' & 1004 > age)

Young_3 = subset(Orange, Tree == '3' | 1004 > age)

## What if we want to know descriptives about each group? 

MeansbyTree = Orange %>% group_by(Tree) %>% 
    summarize(MeanCir = mean(circumference, na.rm=T), 
    sdCir = sd(circumference, na.rm = T), 
    MeanAge = mean(age, na.rm = T), sdAge = sd(age, na.rm = T))

MeansbyTree

#Let's try this out with the data set 'iris'

summary(iris)

MeanPetal = iris %>% group_by(Species) %>% summarize(Mean = mean(Petal.Length), SD = sd(Petal.Length))
#I want the mean and sd petal length for the three species
#What would I do?





#What if I want the variance of the petal lengths for each group?


CT_Petal = iris %>% group_by(Species) %>% 
  summarize(Variance = var(Petal.Length))

#Now let's plot the mean petal length of the three flower species
#Usually, you want to include error bars in bar graphs 
#so I will calculate standard error

PetalLengthMeans = iris %>% group_by(Species) %>% 
  summarise(X_Length = mean(Petal.Length), 
            SE = sd(Petal.Length)/sqrt(length(Petal.Length)))

PetalLengthMeans

limits <- aes(ymax = X_Length + SE, ymin= X_Length - SE)

LengthPlot = ggplot(PetalLengthMeans, aes(x = Species, y = X_Length)) + 
  geom_bar(stat = 'identity', fill="royalblue1", width=.7) +
  geom_errorbar(limits, width=0.1) 
LengthPlot

ggplot(PetalLengthMeans, aes(x = Species, y = X_Length)) + 
  geom_bar(stat = 'identity', fill="#E69F00", width=.9) +
  geom_errorbar(limits, width=0.4)

## Let's spend some time experimenting with how this plot looks
#Change the axis names? using function labs()
#Google ggplot colors to change the colors
#Google ggplot themes

LengthPlot = LengthPlot + labs(y = 'Petal Length', x = 'Species')


LengthPlot + theme_classic()
LengthPlot + theme_minimal()
LengthPlot + theme_bw()


#You can also create your own theme, and change the font size/style, 
#alignment, background, axis lines, etc.
LengthPlot + theme(
  panel.background = element_rect(fill = "lightblue",
                                  colour = "lightblue",
                                  size = 0.5, linetype = "solid"),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "white"), 
  panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                  colour = "white"))

#What if we wanted to create a scatterplot of petal length and petal width?

PetalPlot = ggplot(iris, aes(y = Petal.Length, x = Petal.Width)) + 
  geom_point()

PetalPlot
PetalPlot +  stat_smooth()

## What if want to plot multiple plots in one panel?
#facet_wrap()

PetalPlot + facet_wrap( ~ Species)


#You can also use a grouping variable to have different colors on the graph
#For example, let's use species to group the different flowers
PetalPlot = ggplot(iris, aes(y = Petal.Length, x = Petal.Width, color = Species)) + 
  geom_point()
PetalPlot

## Ok now let's try it in groups of 2-4
#Using the dataset CO2, make two or three plots displaying the data

summary(CO2)





