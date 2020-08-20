#Web Scraping - rvest

library(rvest)
url <- "https://www.imdb.com/list/ls041588759/"
read_html(url)
#or
webpage <- read_html("https://www.imdb.com/list/ls041588759/")
rank_data_html <- html_nodes(webpage,'.text-primary')
rank_data <- html_text(rank_data_html)
rank_data <- as.numeric(rank_data)
print(rank_data)

#title Selection
title_data_html <- html_nodes(webpage,
                              '.lister-item-header a')
title_data <- html_text(title_data_html)
print(title_data)

#runtime
#title Selection
runtime_data_html <- html_nodes(webpage,
                                '.runtime')
runtime_data <- html_text(runtime_data_html)
runtime_data <-gsub(" min","",runtime_data)
runtime_data <- as.numeric(runtime_data)
print(runtime_data)

#Genre data
genre_data_html <- html_nodes(webpage,'.genre')
genre_data <- html_text(genre_data_html)
genre_data<- gsub("\n","",genre_data)
genre_data <- gsub(",.*","",genre_data)
genre_data <- gsub(" ","",genre_data)
print(genre_data)

#Create Dataframe
movie_db<-data.frame(rank_data,
                     title_data, runtime_data,
                     genre_data)
print(head(movie_db))

#Hist - runtime based on genre
library(ggplot2)
ggplot(data=movie_db,
       aes(x=runtime_data,
           fill=genre_data))+
  geom_histogram()


ggplot(data=movie_db,
       aes(x=rank_data,
           y=runtime_data,col=genre_data))+
  geom_point()

View(movie_db)
