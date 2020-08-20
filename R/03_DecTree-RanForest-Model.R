#Decision Tree Model on Titanic Dataset
#1. Import Data
titanic = read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/titanic_data.csv")
titanic = read.csv("titanic.csv")
View(titanic)

#2. Shuffel the Index of Data
set.seed(678)
shuffel_index =sample(1:nrow(titanic))
titanic = titanic[shuffel_index,]

#3. Cleaning Process of Data
library(dplyr)
dim(titanic)
clean_titanic =titanic %>% select(-c(x,name,ticket,cabin,home.dest)) %>%
  mutate(pclass=factor(pclass,
                       levels = c(1,2,3),
                       labels = c("Upper","Middle","Lower")),
         survived=factor(survived,
                         levels = c(0,1),
                         labels = c("No","Yes"))) %>%
  na.omit()
View(clean_titanic)
str(titanic)

#4. Splitting Dataset into Training and Testing Set
library(caTools)
split = sample.split(clean_titanic$survived,
                     SplitRatio = 0.8)
split
training_set =subset(clean_titanic, split==TRUE)
test_set =subset(clean_titanic, split==FALSE)
dim(training_set)
dim(test_set)

#5. Creating DecisionTree Model
library(rpart)
fit <- rpart(survived~pclass+sex+age+embarked,
             data = training_set,
             method = 'class')

#6. Visualizing DecisionTree Model
library(rpart.plot)
library(RColorBrewer)
library(rattle)
rpart.plot(fit)
fancyRpartPlot(fit)


#7. Making Prediction on Testset
predict_unseen=predict(object = fit,
                       newdata=test_set,
                       type='class')

#8. Creating Confusion Matrix
tab_mat= table(test_set$survived,
               predict_unseen)
sum(diag(tab_mat))/sum(tab_mat)

#-------------------------------------------------------
#Random forest Model

library(caret)
library(randomForest)

table(training_set$survived, 
      training_set$pclass)
?randomForest

classifier = randomForest(
  x = training_set[-2],
  y = training_set$survived,
  ntree = 500)

summary(classifier)
r_pred=predict(classifier, 
               newdata = test_set)
r_pred
plot(classifier)