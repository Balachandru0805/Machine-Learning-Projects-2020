#Sentiment Analysis

#Importing Packages
library(dplyr) # For pippe symbol
library(tidytext) #For Sentiment Analysis

#Loading the Dataset
load("shakespeare.rda")
View(shakespeare)

#Operations on dataset
shakespeare %>% count(title, type)

tidy_shakespeare <- shakespeare %>% 
  group_by(title) %>%
  mutate(linenumber = row_number()) %>%
  unnest_tokens(word, text) %>%
  ungroup()
View(tidy_shakespeare)

tidy_shakespeare %>%
  count(word, sort = T)

library(textdata)
get_sentiments("bing")
get_sentiments("afinn")
get_sentiments("nrc")

shakespeare_sentiment <- tidy_shakespeare %>%
  inner_join(get_sentiments("bing"))

shakespeare_sentiment

shakespeare_sentiment %>%
  count(title, sentiment)


tidy_shakespeare %>%
  inner_join(get_sentiments("bing")) %>%
  count(title, type, sentiment)

tidy_shakespeare

word_count <- tidy_shakespeare %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment)
word_count

library(ggplot2)
word_count %>%
  group_by(sentiment) %>%
  top_n(10)%>%
  ungroup() %>%
  mutate(word = reorder(word,n))%>%
  ggplot(aes(x=word, y=n, fill="sentiment"))+
  geom_col() +
  facet_wrap(~sentiment, scales = "free")+
  coord_flip()