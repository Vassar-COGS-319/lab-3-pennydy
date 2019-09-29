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

random.walk.test <- random.walk.model(2000,drift=0.014, sdrw=0.3, criterion=5.25)
sum(random.walk.test$correct) / length(random.walk.test$correct)
random.walk.correct.data <- random.walk.test %>% filter(correct==TRUE)
mean(random.walk.correct.data$rt)
random.walk.incorrect.data <- random.walk.test %>% filter(correct==FALSE)
mean(random.walk.incorrect.data$rt)
hist(random.walk.correct.data$rt)
hist(random.walk.incorrect.data$rt)


accumulator.test <- accumulator.model(2000, rate.1=89, rate.2=83, criterion=3)
sum(accumulator.test$correct) / length(accumulator.test$correct)
accumulator.correct.data <- accumulator.test %>% filter(correct==TRUE)
mean(accumulator.correct.data$rt)
accumulator.incorrect.data <- accumulator.test %>% filter(correct==FALSE)
mean(accumulator.incorrect.data$rt)
hist(accumulator.correct.data$rt)
hist(accumulator.incorrect.data$rt)

# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

# random.walk.model: drift=0.014, sdrw=0.3, criterion=5.25 ->
# accuracy = 0.831, correct RT = 264.1011, incorrect RT = 260.5296

# accumulator.model: rate.1 = 83, rate.2 = 89, criterion = 3 ->
# accuracy = 0.7945, correct RT = 245.4191, incorrect RT = 252.528
# (it cannot account for the mean RT and accuracy. the incorrect RT is larger than the
# correct RT, given the accuracy level)

# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.

# the random.walk.model is better, because it can accurately reflect the relationship
# between mean RT and accuracy. 
# if they both can reasonably account for the data, then since the distrubition produced
# by the random walk model is right skewed and the one by accumulator model is normal,
# we can evaluate the model based on how the distrubtion of the actual data looks like.
