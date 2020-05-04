launch <- read.csv("challenger.csv")
str(launch)
head(launch)

cor(launch)

#importing datasets
insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)
str(insurance)

summary(insurance$charges)
hist(insurance$charges)

table(insurance$region)

#exploring relationships among features

cor(insurance[c("age", "bmi", "children", "charges")])
pairs(insurance[c("age", "bmi", "children", "charges")])

install.packages("psych")
library(psych)

pairs.panels(insurance[c("age", "bmi", "children", "charges")])

#training the model

ins_model <- lm(charges ~ age + children + bmi + sex +
                  smoker + region, data = insurance)

ins_model <- lm(charges ~ ., data = insurance)

ins_model
summary(ins_model)

summary(insurance$age)

#evaluating the model performance

insurance$age2 <- insurance$age^2

#converting numeric features into binary
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0)

str(insurance)

ins_model2 <- lm(charges ~ age + age2 + children + bmi + sex +
                   bmi30*smoker + region, data = insurance)
summary(ins_model2)
