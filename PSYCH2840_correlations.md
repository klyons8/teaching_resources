PSYCH2840\_correlations
================

## Week 10: Understanding bivariate correlations

To help you get an intuitive sense of what a correlation represents, I
created fake data to show what positive, negative and zero correlations
look like, what a correlation coefficient (r value) actually represents,
and how small sample sizes are more influenced by outliers.

Let’s start with a perfect correlation - i.e. a r value of 1. What does
a perfect positive correlation look like?

``` r
library(ggplot2)

x = 1:20
y = 51:70
d = data.frame(x, y)

ggplot(data = d, aes(x = x, y = y)) + geom_point(color='#69b3a2') +
  geom_line(color='#69b3a2') 
```

![](PSYCH2840_correlations_files/figure-gfm/positive%20correlation-1.png)<!-- -->

A correlation of 1 means there is a perfect linear relationship between
x and y. It also means if we know X we can perfectly predict Y (within
our sample).

Positive correlations mean when X goes up, Y goes up. This means the
regression line will have a positive slope.

**Remember:** Just because two variables are correlated, doesn’t mean
they causally related (i.e. variable X causes variable Y or vice versa)
- even if you have a perfect correlation.

What about a negative correlation with an r value of -1?

``` r
x = 1:20
y = 70:51
d = data.frame(x, y)

ggplot(data = d, aes(x = x, y = y)) + geom_point(color='#69b3a2') + geom_line(color='#69b3a2')
```

![](PSYCH2840_correlations_files/figure-gfm/negative%20correlation-1.png)<!-- -->

Again, there is a perfect linear relationship between x and y but it’s
going in the opposite direction.

Negative correlations mean when X goes up, Y goes down. This means the
regression line will have a negative slope.

We basically never have a correlation coeffient of 1 - in psychology,
our correlations are often much lower. What does this look like?

``` r
x = 1:20
y = c(89, 80, 68, 74, 85, 65, 50, 56, 62, 70, 45, 54, 65, 57, 66, 55, 32, 43, 50, 51)
c = cor(x,y)
d = data.frame(x, y)

ggplot(data = d, aes(x = x, y = y)) + geom_point(color='#69b3a2') +
  geom_smooth(method='lm', color='#69b3a2')
```

    ## `geom_smooth()` using formula 'y ~ x'

![](PSYCH2840_correlations_files/figure-gfm/smaller%20correlation-1.png)<!-- -->

This is a correlation of -0.75. It’s still strong - if we know a value
of x, we can pretty accurately predict our value of y (with some error).
It’s negative, so as x goes up, y goes down.

``` r
x = c(30, 25, 30, 5, 20, 19, 10, 21, 29, 18, 20, 19, 11, 12, 20, 7, 7, 15, 10, 12)
y = c(89, 80, 58, 74, 85, 65, 50, 56, 52, 70, 45, 54, 65, 57, 66, 55, 32, 43, 50, 51)
c = cor(x,y)
d = data.frame(x, y)

ggplot(data = d, aes(x = x, y = y)) + geom_point(color='#69b3a2') +
  geom_smooth(method='lm', color='#69b3a2') 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](PSYCH2840_correlations_files/figure-gfm/even%20smaller%20correlation-1.png)<!-- -->
<br> This is a correlation of +0.39. It’s a smaller correlation so there
is more error in our prediction. We can tell it would be smaller because
the dots are more spread out from our regression line. There is a less
consistent pattern between x and y - although the regression line still
trends up, suggesting a slight (non-significant) positive relationship

What does a zero correlation look like?

``` r
set.seed(10)
x = sample(1:100, 20, replace = TRUE)
y = sample(1:100, 20, replace = TRUE)
c = cor(x, y)

d = data.frame(x, y)

ggplot(data = d, aes(x = x, y = y)) + geom_point(color='#69b3a2') + geom_smooth(method='lm', color='#69b3a2')
```

    ## `geom_smooth()` using formula 'y ~ x'

![](PSYCH2840_correlations_files/figure-gfm/zero%20correlation-1.png)<!-- -->

You can see - the regression line is basically flat. The r value is
-0.03. This means we cannot predict y with x - or that knowing x tells
us nothing about y.

Let’s look at some fake data to get a sense of what a correlation is
actually measuring. Imagine this is grade data from five students on
their midterm and final exams. Can we predict someones final exam grade
based on their midterm grade?

``` r
midterm = c(58, 64, 66, 70, 72)
xbar_m = mean(midterm)
final = c(72, 80, 79, 85, 90)
xbar_f = mean(final)
Student = c(1:5)
grades = data.frame(Student, midterm, final)

grades_cor = cor(midterm, final)
grades
```

    ##   Student midterm final
    ## 1       1      58    72
    ## 2       2      64    80
    ## 3       3      66    79
    ## 4       4      70    85
    ## 5       5      72    90

If you look at each student’s scores, can you predict what direction the
correlation will go in? Do you think it will be a strong or weak
correlation?

Ask yourself - Did the students with the highest grades on the midterm
get the highest grades on the final? It seems that way - student 5 had
the highest midterm grade and highest final grade. And student 1 had the
lowest midterm grade and lowest final grade. This pattern is consistent
across all students. This suggests there is a positive relationship
between the two variables, and that this relationship is strong.

When we calculate the correlation we get +0.97. Exactly what we
predicted - a positive, strong relationship.

What about this data? What do you predict is going on here?

``` r
midterm = c(58, 62, 64, 70, 72)
xbar_m = mean(midterm)
final = c(90, 82, 85, 70, 74)
xbar_f = mean(final)
Student = c(1:5)
grades = data.frame(Student, midterm, final)

grades_cor = cor(midterm, final)
grades
```

    ##   Student midterm final
    ## 1       1      58    90
    ## 2       2      62    82
    ## 3       3      64    85
    ## 4       4      70    70
    ## 5       5      72    74

If you predicted that midterm and final grades are negatively correlated
with each other, you’d be right. The student with the highest grade on
the midterm has the lowest grade on the final, and the student with the
lowest grade on the midterm has the highest grade on the final. As
midterm grades go up, final grades go down.

The correlation for this dataset is -0.92.

What about this dataset?

``` r
midterm = c(58, 62, 64, 70, 72)
xbar_m = mean(midterm)
final = c(80, 72, 92, 95, 78)
xbar_f = mean(final)
Student = c(1:5)
grades = data.frame(Student, midterm, final)

grades_cor = cor(midterm, final)
grades
```

    ##   Student midterm final
    ## 1       1      58    80
    ## 2       2      62    72
    ## 3       3      64    92
    ## 4       4      70    95
    ## 5       5      72    78

The pattern is less clear for this dataset. Student 5 had the highest
grade on the midterm, and the second lowest grade on the final. Student
1 had the lowest grade on the midterm, and the third highest grade on
the final. Student 4 had the second highest grade on the midterm, and
the highest grade on the final. Maybe there is a pattern here, but it’s
less clear. And when we look at the correlation: +0.31, you can see that
it’s a small (and not significant) relationship.

This last example also tells us something important about sample size
and statistical validity. Even though a correlation of +0.31 might seem
meaningful, we also have to consider the sample size. In this case, our
sample size was 5 students, so when we look up the probability of
getting this large of a correlation by chance, it’s pretty high\! When
interpreting correlation coeffients, we should look at the p-value (or
confident interval) to determine whether our r value is statistically
significant.

Remember: Small samples are more influenced by outliers - we may get
what seems like a large correlation by chance.

Let’s go through an example. I have randomly sampled 10 values for x,
and 10 values for y. There should theoretically be no relationship
between these two variables because they were chosen randomly (and
independently from each other).

``` r
set.seed(4)
x = sample(1:100, 10, replace = TRUE)
y = sample(1:100, 10, replace = TRUE)
random_corr = cor.test(x, y)

d = data.frame(x, y)

ggplot(data = d, aes(x= x, y = y)) + geom_point(color='#69b3a2') + geom_smooth(method='lm', color='#69b3a2') + geom_point(data=subset(d, y == max(d$y)), aes(x=x, y=y), color='#69b3a2',size=5)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](PSYCH2840_correlations_files/figure-gfm/sample%20size%20correlation-1.png)<!-- -->

In this case, I got a correlation of +0.5 - completely due to chance.
You can see that one of my data points (the dot that is bigger in the
right upper corner) is very high on both variables - this is an outlier,
and it’s making my correlation a lot stronger. Let’s see what happens
when I remove that datapoint.

``` r
new_d = subset(d, y < max(d$y))
random_corr = cor.test(new_d$x, new_d$y)


ggplot(data = new_d, aes(x= x, y = y)) + geom_point(color='#69b3a2') + geom_smooth(method='lm', color='#69b3a2') 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](PSYCH2840_correlations_files/figure-gfm/removing%20outlier-1.png)<!-- -->

Now our correlation is +0.38 - it dropped by a lot, from just removing
that one participant. We still have a positive correlation, but it’s
less strong.

**Note:** Neither of these two correlation values were statistically
significantly different from zero, because our degrees of freedom
(sample size - 1) is so low.

What happens when I randomly select 100 numbers for x and y?

``` r
set.seed(4)
x = sample(1:100, 100, replace = TRUE)
y = sample(1:100, 100, replace = TRUE)
random_corr = cor.test(x, y)

d = data.frame(x, y)

ggplot(data = d, aes(x= x, y = y)) + geom_point(color='#69b3a2') + geom_smooth(method='lm', color='#69b3a2') 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](PSYCH2840_correlations_files/figure-gfm/bigger%20sample%20size%20correlation-1.png)<!-- -->
<br> You can see, the regression line is flat, and our correlation value
is 0. Even though we have a few datapoints with high x’s and y’s, there
are many more data points so these outliers don’t have as much of an
impact on our r value.

As we learned in week 3, the larger our sample size, the more confident
we are in our estimates (whether they are frequency, correlational, or
effect size estimates).
