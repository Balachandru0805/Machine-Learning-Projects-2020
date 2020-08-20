#Import Neccessary modules
library(ranger)
library(caret)
library(data.table)
library(caTools)
library(pROC)
library(rpart)
library(rpart.plot)
library(neuralnet)
library(gbm)

#Import Data
credit_card <- read.csv("Credit_Card.csv")

#Explaratory Data Analysis
print(head(credit_card))
dim(credit_card)
names(credit_card)
summary(credit_card$Amount)
var(credit_card$Amount)
table(credit_card$Class)

#Scaling the data
credit_card$Amount = scale(credit_card$Amount)
new_credit = credit_card[,-c(1)]
print(head(new_credit))

new_credit$Class = factor(new_credit$Class,levels=c(0,1))

#Splitting the dataset into Training and Testing
set.seed(123)
split = sample.split(new_credit$Class,SplitRatio = 0.80)
train_set = subset(new_credit,split==TRUE)
test_set = subset(new_credit,split==FALSE)
dim(train_set)
dim(test_set)

#Fitting and predicting Logistic Regression Model
logistic_model = glm(Class~.,train_set,family = binomial())
summary(logistic_model)

lr_pred = predict(logistic_model,test_set,probability=TRUE)
roc(test_set$Class, lr_pred, plot=TRUE, col='blue')

#Fitting and predicting Decision Tree Model
DecTree_model = rpart(Class ~ ., credit_card, method='class')
dt_pred = predict(DecTree_model, credit_card, type='class')
dt_prob = predict(DecTree_model, credit_card, type='prob')
rpart.plot(DecTree_model)

#Fitting and predicting Artificial Neural Network Model
Ann_model = neuralnet(Class ~ ., train_set, linear.output = FALSE)
plot(Ann_model)
Ann_pred = compute(Ann_model,test_set)
res = Ann_pred$net.result
res1 = ifelse(res>0.5,1,0)
res1


