PSYCH2840 Data Simulations
================

## Week 3: Sample size and statistical validity

I have simulated data to show the importance of sample size for
statistical validity. In psychology, we generally use a sample of our
population of interest even though we want to make claims about the
population (because we usually can’t test the entire population.

For example, maybe I sampled 100 people about their ice cream
preferences, and found that 26% of people I sampled prefer vanilla ice
cream over chocolate. In this case, 26% is my estimate of the
population. Our estimation of the population usually involves some
amount of error - we could be off by 2% or 10% or sometimes even more
than that\!

Sometimes we can get extreme values (or outliers) by chance, and these
values impact our estimation of the population value much more when we
have smaller samples than when we have a larger sample.

We can see how this happens by simulating data where we know the true
population value.

When rolling two die and adding the values together, we know the
probability of each outcome (e.g., the most likely value is 7). We also
know it is much more likely that we would roll a 7 compared to a 2 or
11, but only slightly more likely to roll a 7 compared to a 6 or 8.

Here is the probability distribution for rolling two fair dies and
summing the total.

``` r
library(ggplot2)

sum = c(2,3,4,5,6,7,8,9,10,11,12)

probability = c(1/36,2/36,3/36,4/36,5/36,6/36,5/36,4/36,3/36,2/36,1/36)

expected = sum(sum * probability)


prob = data.frame(sum,probability)
prob$sum = as.factor(prob$sum)


ggplot(data = prob, aes(x = sum, y = probability)) +
  geom_col(fill="#00AFBB") + xlab("Sum of two Dice") + ylab("Probability") 
```

![](PSYCH2840_data-simulations_files/figure-gfm/probability%20distribution-1.png)<!-- -->

Given this distribution, if I were to roll two dies and summed the
values many many times, and took the average value of all of those
samples, I would expect to get 7. We can think of 7 as the mean in our
population.

What happens when we sample from our population?

Let’s start by simulating 10 rolls of two die. This is one outcome:

``` r
set.seed(15)
#Now let's try rolling two dice 10 times
sums = c(sample(1:6,10,replace=TRUE)+sample(1:6,10,replace=TRUE))
sums = data.frame(sums)

xbar = mean(sums$sums)

ggplot(sums, aes(sums)) + geom_bar(fill = '#00AFBB')+
  scale_x_continuous(breaks=seq(2,12)) + xlab('Sum of Die') + ylab('Count')
```

![](PSYCH2840_data-simulations_files/figure-gfm/rolling%20die-1.png)<!-- -->
<br> With these first 10 rolls, we can see that our distribution doesn’t
look very much like a known population distribution (our mean value is =
6.2). We actually got 2 and 11 at the same frequency as 7… which is not
what we would expect given the probability distribution.

What if we were to roll the two die ten times again?

``` r
set.seed(10)

sums = c(sample(1:6,10,replace=TRUE)+sample(1:6,10,replace=TRUE))
sums = data.frame(sums)

xbar = mean(sums$sums)

ggplot(sums, aes(sums)) + geom_bar(fill = '#00AFBB')+
  scale_x_continuous(breaks=seq(2,12)) + xlab('Sum of die rolls') + ylab('Count')
```

![](PSYCH2840_data-simulations_files/figure-gfm/rolling%20die%202-1.png)<!-- -->
<br>

This distribution looks a bit more like our population distribution (our
mean = 7.3). The most freqeunt outcome was 7, and our mean is slightly
closer to our expected mean.

What if we were to sample 100 die rolls?

``` r
set.seed(10)

sums = c(sample(1:6,100,replace=TRUE)+sample(1:6,100,replace=TRUE))
sums = data.frame(sums)

xbar = mean(sums$sums)

ggplot(sums, aes(sums)) + geom_bar(fill = '#00AFBB')+
  scale_x_continuous(breaks=seq(2,12)) + xlab('Sum of die rolls') + ylab('Count')
```

![](PSYCH2840_data-simulations_files/figure-gfm/rolling%20die%203-1.png)<!-- -->
<br> Now the sample distribution is starting to look more like our
population distribution (our mean = 7.24). Even though we did roll more
11’s than we would expect given the probability distribution, these
values have less of an impact on our overall mean because we have many
more observations then we did in the previous example.

Let’s roll the dice another 1000 times

``` r
set.seed(10)

sums = c(sample(1:6,1000,replace=TRUE)+sample(1:6,1000,replace=TRUE))
sums = data.frame(sums)

xbar = mean(sums$sums)

ggplot(sums, aes(sums)) + geom_bar(fill = '#00AFBB')+
  scale_x_continuous(breaks=seq(2,12)) + xlab('Sum of die rolls') + ylab('Count')
```

![](PSYCH2840_data-simulations_files/figure-gfm/rolling%20die%204-1.png)<!-- -->
<br> This distribution looks a lot more like our population distribution
(our mean = 7.084). But was it just a fluke? Let’s roll it another 1000
times.

``` r
set.seed(100)

sums = c(sample(1:6,1000,replace=TRUE)+sample(1:6,1000,replace=TRUE))
sums = data.frame(sums)

xbar = mean(sums$sums)

ggplot(sums, aes(sums)) + geom_bar(fill = '#00AFBB')+
  scale_x_continuous(breaks=seq(2,12)) + xlab('Sum of die rolls') + ylab('Count')
```

![](PSYCH2840_data-simulations_files/figure-gfm/rolling%20die%205-1.png)<!-- -->

<br> No - This one also looks really similar to our population (mean =
7.055). <br> The larger our sample size, the more confident we can be in
our estimate (the less it is impacted by extreme or unlikely values).

## Week 5: Inferential statistics - Does my friend have a weighted coin?

We can use inferential statistics to estimate what is happening in the
population. To understand the logic, we will go through an example:
Let’s say my friend makes a bet with me, every time he flips tails, I
get $1, everytime he flips heads, he gets $1. Given the probability of
flipping a heads or a tails is 1/2 - I would expect that neither of us
will win or lose much money, so I decide to agree to this bet. We agree
to do this 30 times. This is the outcome:

``` r
set.seed(15)
n = 30
outcome = c('heads', 'tails')
ThirtyFlips = data.frame(Flip =sample(outcome, n, replace = TRUE))

heads_fair = sum(ThirtyFlips$Flip == 'heads')
tails_fair = sum(ThirtyFlips$Flip == 'tails')
money_fair = heads_fair - tails_fair

ggplot(ThirtyFlips, aes(x = Flip, fill = Flip)) + geom_bar(stat = 'count') +theme(legend.position = "none")
```

![](PSYCH2840_data-simulations_files/figure-gfm/flipping%20the%20coin%2030%20times-1.png)<!-- -->
<br> My friend made 4 dollars on this bet - even though I am
disappointed, I am not that surprised with the outcome. Each time we
flip a coin, there is a 1/2 chance it gets on tails, but it doesn’t mean
I would expect every single time we flipped 30 coins we would get 15/30
tails. There is randomness in what we get each time we flip a fair coin
30 times.

What if we got this outcome?

``` r
set.seed(3)
n = 30
probs = c(.7, .3)
outcome = c('heads', 'tails')
ThirtyFlips = data.frame(Flip =sample(outcome, n, replace = TRUE, prob = probs))

heads_weighted = sum(ThirtyFlips$Flip == 'heads')
tails_weighted = sum(ThirtyFlips$Flip == 'tails')
money_weighted = heads_weighted - tails_weighted

ggplot(ThirtyFlips, aes(x = Flip, fill = Flip)) + geom_bar(stat = 'count') +theme(legend.position = "none")
```

![](PSYCH2840_data-simulations_files/figure-gfm/flipping%20the%20unfair%20coin%2030%20times-1.png)<!-- -->
<br> Now I am suspicious. My friend made 14 dollars and I am wondering
if they may have a weighted coin that ensured they would make a profit?

We can calculate the probability of getting this outcome or one more
extreme, if the coin is fair.

We can do this because we know the probability of each flip: a fair coin
has a 1/2 chance of being heads, and 1/2 chance of being tails. What is
the chance of us getting an outcome of 8 out of 30 flips or one more
extreme?

``` r
#We can use the binomial distribution to calculate this - but don't worry about it for this class
weighted = round(pbinom(tails_weighted, n, .5), 4)
fair = round(pbinom(tails_fair, n, .5), 4)
```

The probability of getting an outcome of 8 out of 30 flips or one more
extreme is 0.0081. If we assume we have a fair coin, 0.81 percent of the
time we would expect to get that many tails (or fewer).

In contrast, in the first example, we got 13 out of 30. What is the
probability of getting that many tails or fewer? 0.2923 - so 29.23
percent of the time, I would expect to lose at least 4 dollars.

I might decide that 0.81 percent is a sufficiently unlikely outcome to
suggest the coin was not fair, so I accuse my friend of having a
weighted coin and refuse to pay him\! But I have to understand, that
there is still a chance (although very small) that the coin was fair
after all - so I could be accusing them of something they didn’t do\!

**How does this relate to experimental data?**

We can do something similar with our experimental data. We often want to
know if two (or more) groups of data come from the same population or
not. Generally, we don’t know the population value (like we do when
flipping a coin), but we can compare the difference between our groups -
while considering the variance in our data - to calculate the
probability that we would get this difference (or one more extreme) if
our samples come from the same population.

For example, maybe I give 20 participants a chocolate ice cream cone,
and 20 other participants (randomly assigned) a vanilla ice cream cone.
Then I ask them on a scale from 1 to 10, how much they enjoyed their ice
cream with 1 being the worst ice cream they ever had and 10 being the
best ice cream they ever had. I find that the vanilla group had an
average score of 6.2 (SD = 1.5), and the chocolate group had an average
score of 7.4 (SD = 1.4). Obviously the groups differ, but do they differ
enough to say that chocolate is the more enjoyed flavor of ice cream?

It’s possible we got this difference due to chance - when we sample from
a population, we have to remember that there is likely some error in our
estimate and other factors can influence participants responses. Maybe
one of our participants who got the chocolate ice cream was really happy
that day, and rated their ice cream 10 out of 10 because of how great
their day was. And maybe we got another participant who got the vanilla
ice cream who was having a terrible day, and rated their ice cream 2 out
of 10 because of how terrible their day was. Even if everyone else rated
their ice cream similarly between the groups, these two outliers would
make our means different. This is why we have to consider not just the
mean difference, but also the variance in our data and our sample size.

This is where the t.test comes in - we can calculate the likelihood of
getting this difference (or one more extreme) if the groups don’t truly
differ in their ice cream enjoyment. The t-statistic takes into account
the mean difference and the variance (or standard deviation) in our
data. The probability (or p value) is determined based on the magnitude
of the t-statistic, and the degrees of freedom (how many data points we
have).

``` r
n = 20
Chocolate = rnorm(n, mean=7.4, sd=1.4)
Vanilla = rnorm(n, mean=6.2, sd=1.5)


t = t.test(Chocolate, Vanilla)
```

In this case, we get a p value = 0.0079, 95% CI \[0.35 , 2.17\]. Given
this result, I feel pretty confident that the participants like the
chocolate ice cream more than the vanilla ice cream.
