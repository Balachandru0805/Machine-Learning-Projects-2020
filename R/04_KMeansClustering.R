#K-Means Clustering Model

#Import
dataset = read.csv("Mall_Customers.csv")
View(dataset)
dataset = dataset[4:5]

#Elbow plot
library(cluster)
set.seed(5)
wcss = vector()
for(i in 1:10) 
  wcss[i]=sum(kmeans(dataset,i)$withinss)

plot(1:10, wcss,
     type='b',
     main="The Elbow Method",
     xlab="Number of Cluster",
     ylab='WCSS')

#Fitting K-mean to the dataset
kmeans=kmeans(x=dataset,centers = 5 )
y_kmeans = kmeans$cluster

#Visualising the cluster
clusplot(dataset, y_kmeans,
         #labels = 2,
         #shade = T,
         lines = 0,
         color = T,
         main="Cluster of Customers",
         xlab = 'Annual Income',
         ylab = 'Spending Scores')