#Simple Linear Regresstion
#Import the Data
dataset = read.csv("Salary_Data.csv")
View(dataset)

#Splitting the datset into training and test
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary,
                     SplitRatio = 2/3)
split
training_set =subset(dataset, split==TRUE)
test_set =subset(dataset, split==FALSE)
View(training_set)
View(test_set)

#Fitting Simple Linear Regression to 
#Traiing Set
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)
summary(regressor)

#Predicting the Test Set Result
y_pred = predict(object = regressor,
                 newdata = test_set)

#Visualising the Training Set Result
library(ggplot2)
ggplot()+
  geom_point(aes(x=training_set$YearsExperience,
                 y=training_set$Salary),
             color="red")+
  geom_line(aes(x=training_set$YearsExperience,
                y=predict(regressor,
                          newdata=training_set)),
            color="blue")

#Visualizing the Test Set Result
ggplot()+
  geom_point(aes(x=test_set$YearsExperience,
                 y=test_set$Salary),
             color='red')+
  geom_line(aes(x=test_set$YearsExperience,
                y=predict(regressor,
                          newdata=test_set)),
            color='blue')