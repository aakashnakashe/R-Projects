getwd()

mushrooms <- read.csv('mushrooms.csv', stringsAsFactors = TRUE)
str(mushrooms)

mushrooms$veil_type <- NULL

table(mushrooms$type)

install.packages("RWeka")
library(RWeka)

mushroom_1R <- OneR(type ~ ., data = mushrooms)

mushroom_1R
summary(mushroom_1R)
