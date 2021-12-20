#'PSYCH  9041: Intro to Using R, ggplot, and R Markdown
#'Course website: https://gribblelab.org/teaching/stats2019/
#'By Kathleen Lyons
#'Jan 17, 2019
#'
#'
#'Console: command window (Where you run your commands)
#'Global environment: Where your variables are saved/stored (workspace)
#'R script editor: Where you can write and run scripts, make sure to save your work!
#' 
#'
#'Some good shortcuts to remember:
#'Tab completion 
#'Ctrl/command enter for mac, or ctrl r for PC, to run line/section within script
#'Up/down arrow to retrieve previously run commands
#'Erase your global environment:rm(list=ls()) 
#'Ctrl+L: Clear the Console
#'Esc: Stop whatever you are running
#'
#'
#'

## Operations ##

20 + 7 #This is a comment

20 - 7 

20 * 7

20 / 7

20 ^ 2 

20 ^ 20 

#Order of operations: BEDMAS  

5 + 4 / 2

5 - 4 * 2^2

5 * (4 + 2^2)

2 + 2^2

(2 + 2)^2

## Variables ##

# we can store information in variables using = (or <- )

y = 2 #This is a variable, which will be saved in your global environment when you run this line
x = 3
rm(x) #This removes a specific variable in your environment, this can not be undone
rm(list=ls()) #This erases your entire envornment 

y = 2

x <- 3 

y

x

z = y + x #You can call on previous variables when creating new variables

z

#We can also update variables while we go, but this rewrites the old variable

x = 5

x

x = x^2

x 
#When we call on x, we are calling on the most previous version of x
#Be careful not to override variables you need, keep track of your variable names

#we can name variables really anything, within these rules:
#can't start with a number
#can't contain most special characters (but . and _ are fine)

X.times.Z = x * z 


## Vectors ##

#Vectors are a way of storing multiple values in one place

Test_Scores = c(90, 67, 89, 79, 76, 97, 91, 84) 
#c means concatenate; we are combining these different objects (in this case numbers) together in one vector
Test_Scores

Numbers = c('one','two','three','four','five') #you can store any information in vectors
Numbers

NumComb = c('one', 'two', 3) #You can store different types of information in the same vector
NumComb

#Calling on items in a vector: vector[item number]
#R begins indexing at 1; some other languages begin at 0. 
Test_Scores[3] #give the third item in Test_Scores
Test_Scores[1:3] #Gives the first three items in Test_Scores

Ind = c(4,5,6)
Test_Scores[Ind] #You can call on items using another vector to specify which items you want

#You can also do operations on that item
Test_Scores[3]+1

#Or on the entire vector
Test_Scores + 1

#You can also get rid of items in your vector by using the minus sign
NumComb[-3]

#And you can assign values to specific items in your vector
NumComb[3] = 'three'
NumComb

#Vector math is cell by cell, for example:
Var1 = c(1, 2, 3, 4, 5)
Var2 = c(10, 11, 12, 13, 14)
Var1 + Var2
Var1 * Var2


#What happens if your vectors are different lengths?
Var3 = seq(0,100,5)
Var3
Var4 = c(1,2,3)

Var4 * Var3 #This still works, but what exactly is happening?

## Functions ##

# Functions generally take some input, perform operations, and produce some output
# R has a lot of useful functions that we will be using in this course
# such as sqrt, mean, sd, var, range, t.test, anova, lm

mean(Test_Scores) #mean is a function that gives us the average of the vector we give it
sd(Test_Scores) #sd is a function that gives use the standard deviation of the vector we give it

# You can also create your own functions, which will save you time if you are consistently using an operation that isn't currently a function

#If you forget what a function does, you can use '?' to get more information
?mean
?t.test

## Directories ##

getwd() #Tells you where you are, which becomes important when you are loading in data
#'You can either load in your data by putting the entire directory in the datafile name
#'Or you can set your working directory to where your data is, and then you just need the name of the data file 
#'To do this, use setwd(). For example setwd('/Users/klyons/Downloads/')
#'I recommend always setting your working directory to where your data is because that means you only have to change 
#'the working directory if you are working on a different computer, or you go back years later and your data has moved
#'And this makes it much easier for other people to run your code (Good for reproducibility!)
#'
#'Set your working directory to your Downloads folder to give it a try




## Loading data ##

#Easiest to load in csv files 
#If you download the datafile for chapter 1 from the textbook's website and you've set your wd to your downloads, 
#you can load it like this:
Data_1 = read.csv('chapter_1_table_1.csv')
Data_1
summary(Data_1) #Gives you a summary of the variables in your dataframe - mean/median/quartiles/max for each variable
str(Data_1) #Tells you what type of variable each column is, and how many observations/variables you have

#R also has a bunch of datasets you can play with to practice using R

library(help = "datasets") #You can see what datasets are available
#cars dataset: The data give the speed of cars and the distances taken to stop  
summary(cars)
str(cars)

#To call on a specific variables, use dollarsign ($) between dataframe name and variable name
mean(cars$speed)
summary(cars$dist)
Mean_speed = mean(cars$speed)

#You can also call on a specific observation, using the same rules from vectors
cars$speed[3]
#OR
cars[3,1] #row number first, then column number

#Or if you want multiple observations
cars[1:10, 2] #This gives us the first ten observations for the second variable (distance)

#You can also create a new variable in your dataframe
Data_1$NewVar = Data_1$treat - Data_1$control
Data_1
Data_1$NewVar = NULL #Removes this variable
Data_1

#Using the dataset 'PlantGrowth', what is the overall mean weight and standard deviation






#What if we want the mean for each group?

mean(PlantGrowth$weight[PlantGrowth$group == 'ctrl']) #This is telling R you want only the weights who are in the ctrl group
mean(PlantGrowth$weight[PlantGrowth$group == 'trt1'])
mean(PlantGrowth$weight[PlantGrowth$group == 'trt2'])

## Packages ##

#'https://www.rstudio.com/products/rpackages/
#' 
#' Although the standard packages do a lot, often times we want more
#' And lucky for us, other R users have created a bunch of useful packages 
#' My favorites are tidyverse and ggplot2
#' You only have to install a package once, but you will always have to call on it in a new session
#' For example, let's install and call on 'ggplot2'

install.packages('ggplot2') #This will take a moment
library(ggplot2) #this is how you call on the package when you want to use it, this is the step you will have to run everytime you open R and use ggplot

## ggplot ##

#'ggplot2 is a great package for making figures.
#'If you're not sure how to set up your code to create a figure, just google ggplot 'figure type', and you'll find lots of helpful code
#'Let's do a couple example graphs
#'First, let's try a scatterplot with the cars dataset, using the function ggplot()

?ggplot 

#Before specifying what figure type you want, you have to tell R what dataframe the figure will be based on, 
#as well as the aesthetic mappings, which are the variables you want to plot (x, y, fill/color)
cars_plot = ggplot(data = cars, aes(x = speed, y = dist)) 
cars_plot #Hasn't plotted anything because we haven't specified the type of graph

cars_plot + geom_point() 

cars_plot = cars_plot + geom_point(color = 'blue', alpha = .5, size = 3) #alpha makes it transparent, the lower the decimal the more transparent
cars_plot

#We can add a title and change the format in a lot of different ways, 
#including the labels, the color, the background, the font size, etc.

cars_plot + labs(y = 'Distance', x = "Speed")  + theme(panel.grid.minor = element_blank(),
                                                       panel.background = element_blank(),
                                                       plot.title=element_text(size = 18), 
                                                       text=element_text(size = 14), 
                                                       axis.text.x=element_text(size = 10), 
                                                       axis.text.y=element_text(size = 10),
                                                       axis.line.y = element_line(size = .5),
                                                       axis.line.x = element_line(size = .5))

#What about a boxplot?
summary(ToothGrowth)
str(ToothGrowth)
#Let's use this dataset, which is The Effect of Vitamin C on Tooth Growth in Guinea Pigs
#How would you set up this figure to plot the supplement (supp) on the x axis, length (len) on the y axis?
#Don't look below!

#Tooth_plot = ?











#Solution: Tooth_plot = ggplot(data = ToothGrowth, aes(x = supp, y = len))
Tooth_plot + geom_boxplot() 

Tooth_plot + geom_boxplot() + geom_jitter(width = .1, height = 0)#we can even add points to our boxplot 

#Or we can make a histogram
#Exercise: Using the  dataset airquality, create a histogram of temp using geom_histogram()















#solution:Temp_plot = ggplot(data = airquality, aes(x = Temp))
#Temp_plot + geom_histogram()
#Temp_plot + geom_histogram(binwidth = 5)

#You can also make bar graphs, violin plots, density plots, line graphs
#For some inspiration: https://www.r-graph-gallery.com/all-graphs/

#A couple things to keep in mind when using ggplot 

#1. The type of variable will make a difference
#For example: 
str(Data_1) #Week is treated as an interger instead of a factor, so we will run into issues when we try to plot it

ggplot(Data_1, aes(x = week, y = control)) + geom_boxplot() #Why?

#because R is treating week as a continuous variable instead a discrete one so we need to change it

Data_1$week_factor = as.factor(Data_1$week) #you can change the variable type using as.type() e.g. as.character(), as.numeric()

str(Data_1)

ggplot(Data_1, aes(x = week_factor, y = control)) + geom_boxplot() 

#2. Your dataframes have to be organized in a specific way. Let's use a made up example:

MadeUpData = data.frame(PtNum = c(1:8), OnDrug = c(rnorm(8, mean=60, sd=10)), OffDrug = c(rnorm(8, mean=50, sd=10)))
summary(MadeUpData)

#We have two conditions, on the drug and off the drug, and have some sort of measure of something
#Now we want to be able to visualize the data by comparing our measurement in the OnDrug and OffDrug conditions, 
#but how would we set up the ggplot?

#We actually can't in the way we would want because the on drug and off drug conditions are separate columns, 
#So we need to transform the dataframe so that they are in the same column 

New_MadeUpData = data.frame(ptNum = c(MadeUpData$PtNum, MadeUpData$PtNum), 
                            Condition = c('On','On','On','On','On','On','On','On','Off','Off','Off','Off','Off','Off','Off','Off'),
                            Score = c(MadeUpData$OnDrug, MadeUpData$OffDrug))

#If your data is set up the first way ('wide'), you can melt or reshape to make it 'long' 
New_MadeUpData 

ggplot(New_MadeUpData, aes(x = Condition, y = Score)) + geom_boxplot()

#This is a good thing to keep in mind when setting up how you collect and save data (if you plan to use R for figures)

#3. Bar graphs/error bars are a bit more complicated. For example: 

ggplot(PlantGrowth, aes(x = weight, y = group)) + geom_bar() #Why didn't this work?

#We have to tell R what the value you actually want plotted for each group, so it knows what to plot
#In this case, we want the mean (each value has equal weight) but R doesn't assume this
#There is a couple different ways to get the means of each group in a dataframe 
#I generally use the package tidyverse which allows me to create a dataframe with the means, sd, se, whatever I want based on groupings
#You can also calculate the means by hand (which is less efficient especially for complicated datasets)

install.packages('tidyverse')
library(tidyverse)

Sum_plantgrowth = PlantGrowth %>% group_by(group) %>% 
  summarise(xbar = mean(weight), SD = sd(weight), N = n(), SE = sd(weight)/sqrt(length(weight)))

#now our dataset is in a format that can be plotted as a bar graph
#The standard error (SE) is for error bars

limits <- aes(ymax = xbar + SE, ymin= xbar - SE)

ggplot(Sum_plantgrowth, aes(x = group, y = xbar)) + 
  geom_bar(stat = 'identity', fill="seagreen2", width=.7) +
  geom_errorbar(limits, width=0.25) 


## R Markdown ##


#The papaja package creates APA style documents
#Benefits of rmarkdown:
#You call directly on your stats/plots, so there is less chance of misreporting
#Creates a document that can be complerely reproducible if other person has data
#More info: https://rmarkdown.rstudio.com/lesson-1.html

#To create an rmarkdown file, go to plus sign (where you create new scripts) and click on R Markdown
#Let's try making one now!
#If you want to call a variable within the written portion of the document, use `r {VariableName}`


## General advice when learning R ##

#'You will encounter errors that you can't figure out how to fix, 
#'but there are lots of helpful resources you can use:
#'Stackoverflow.com
#'R-bloggers.com
#'Rdocumentation.org
#'And of course google! 


