# model selection ####

# suppose we have data from an experiment like this:
# mean RT correct = 250ms
# mean RT incorrect = 246ms
# accuracy = 0.80

# try to fit this data with both models by adjusting the parameters of the model
# HINT: you can speed up your parameter search by using a small number of samples
# initially, and then increasing the samples as you get closer to a viable set
# of parameters.
# 2nd HINT: Don't adjust the sdrw parameter of the random.walk.model or the criterion
# paramter of the accumulator model.

# You don't need to get a perfect match. Just get in the ballpark. 

set.seed(12604)

random.walk.test <- random.walk.model(2000,drift=0.014, sdrw=0.3, criterion=5.25)
sum(random.walk.test$correct) / length(random.walk.test$correct)
random.walk.correct.data <- random.walk.test %>% filter(correct==TRUE)
mean(random.walk.correct.data$rt)
random.walk.incorrect.data <- random.walk.test %>% filter(correct==FALSE)
mean(random.walk.incorrect.data$rt)
hist(random.walk.correct.data$rt)
hist(random.walk.incorrect.data$rt)


accumulator.test <- accumulator.model(2000, rate.1=83, rate.2=89, criterion=3)
# this is exponential. So the larger the rate is, the steeper the slop will be (fewer
# will be sampled) -> reverse relationship

mean(accumulator.test$correct)
accumulator.correct.data <- accumulator.test %>% filter(correct==TRUE)
mean(accumulator.correct.data$rt)
accumulator.incorrect.data <- accumulator.test %>% filter(correct==FALSE)
mean(accumulator.incorrect.data$rt)
hist(accumulator.correct.data$rt)
hist(accumulator.incorrect.data$rt)

# acc.model.result <- accumulator.model(1000, rate.1 = 85, rate.2 = 91, criterion=3)
# acc.model.result %>% group_by(correct) %>% summarize(mean.rt = mean(rt))
# mean(acc.model.result$correct)


# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

# random.walk.model: drift=0.014, sdrw=0.3, criterion=5.25 ->
# accuracy = 0.831, correct RT = 264.1011, incorrect RT = 260.5296

# accumulator.model: rate.1 = 89, rate.2 = 83, criterion = 3 ->
# accuracy = 0.787, correct RT = 245.9288, incorrect RT = 253.1714

# both models seem to be able to fit the means and accuracy accurately. Additional information
# is needed to determine which model is better (both quantitative evaluation and intelelctual
# and scholarly judgment).

# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.

# Since the distrubition produced by the random walk model is right skewed and the one by 
# the accumulator model is normal, we can evaluate the model based on how the distrubtion of 
# the actual data looks like. 
# (Missing point:) Also, the variability in the random walk model is higher. 
# -> formally, we can use variance/standard deviation of RTs to quantify the variability 
# predicted by the model and compare it to the variance/SD of RTs of actual data

accumulator.test %>% group_by(correct) %>% summarize(sd.rt = sd(rt))
random.walk.test %>% group_by(correct) %>% summarize(sd.rt = sd(rt))
# random.walk:219; accumulator: 14.1 for correct. Big enough difference.