#importing dataset
sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)

str(sms_raw)

#from character to vector
sms_raw$type <- factor(sms_raw$type)

table(sms_raw$type)

#installing text mining packages
install.packages("tm")
library(tm)

#converting into corpus NLP
sms_corpus <- Corpus(VectorSource(sms_raw$text))
print(sms_corpus)

inspect(sms_corpus[1:3])

#First, we will convert all of the SMS messages to lowercase and remove any numbers:

corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)


inspect(corpus_clean[1:3])

#tokenization

sms_dtm <- DocumentTermMatrix(corpus_clean)

#training and testing split

sms_raw_train <- sms_raw[1:4169, ]
sms_raw_test <- sms_raw[4170:5574,]

sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test <- sms_dtm[4170:5574,]

sms_corpus_train <- corpus_clean[1:4169]
sms_corpus_test <- corpus_clean[4170:5574]

prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))


#word cloud library
install.packages("wordcloud")
library(wordcloud)

wordcloud(sms_corpus_train, min.freq = 40, random.order = FALSE)

spam <- subset(sms_raw_train, type == "spam")
ham <- subset(sms_raw_train, type == "ham")

wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))


#to clean word data marix
findFreqTerms(sms_dtm_train, 5)
sms_dict <- dict(findFreqTerms(sms_dtm_train, 5))






















