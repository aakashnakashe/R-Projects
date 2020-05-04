getwd()
setwd("C:/Users/Avengers/Documents/r_project")

#importing datasets
credit <- read.csv("credit.csv")
str(credit)

table(credit$checking_balance)
table(credit$savings_balance)

summary(credit$months_loan_duration)
summary(credit$amount)

table(credit$default)

#to shuffle the data
set.seed(12345)
credit_rand <- credit[order(runif(1000)), ]

summary(credit$amount)
summary(credit_rand$amount)

head(credit$amount)
head(credit_rand$amount)

#training and testing dataset

credit_train <- credit_rand[1:900, ]
credit_test <- credit_rand[901:1000, ]

prop.table(table(credit_train$default))
prop.table(table(credit_test$default))


#installing model
install.packages("C50")
library(C50)
install.packages("gmodels")
#training the model
credit_train$default<-as.factor(credit_train$default)
str(credit_train$default)

credit_model <- C5.0(credit_train[-17], credit_train$default)

credit_model

summary(credit_model)

#testing the model

credit_pred <- predict(credit_model, credit_test)

library(gmodels)
CrossTable(credit_test$default, credit_pred,
             prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
             dnn = c('actual default', 'predicted default'))


#adaptive boosting

credit_boost10 <- C5.0(credit_train[-17], credit_train$default,
                       trials = 10)
credit_boost10
summary(credit_boost10)

credit_boost_pred10 <- predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred10,
             prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
             dnn = c('actual default', 'predicted default'))


#cost matrix

error_cost <- matrix(c(0, 1, 4, 0), nrow = 2)
error_cost

credit_cost <- C5.0(credit_train[-17], credit_train$default,
                      costs = error_cost)
credit_cost_pred <- predict(credit_cost, credit_test)
CrossTable(credit_test$default, credit_cost_pred,
             prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
             dnn = c('actual default', 'predicted default'))


## saving the model

#saveRDS(model, file = "credit_model.rds")

saveRDS(credit_model, file = "credti_model.rds")

loadedModel <- readRDS('credti_model.rds')

summary(loadedModel)