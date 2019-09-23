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

random.walk.test <- random.walk.model(1000,drift=0.015, sdrw=0.3, criterion=5)
sum(random.walk.test$correct) / length(random.walk.test$correct)
random.walk.correct.data <- random.walk.test %>% filter(correct==TRUE)
mean(random.walk.correct.data$rt)
random.walk.incorrect.data <- random.walk.test %>% filter(correct==FALSE)
mean(random.walk.incorrect.data$rt)


accumulator.model <- function(samples, rate.1=40, rate.2=40, criterion=3)
accumulator.test <- accumulator.model(1000)
mean(accumulator.test$rt)

# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

# random.walk.model: drift=0.015, sdrw=0.3, criterion=5

# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.
