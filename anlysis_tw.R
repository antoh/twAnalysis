library(rtweet)
library(tidyverse)
library(tidytext)

#Search tweets containing William Ruto, Exclude Rts and Replies
tweets <- search_tweets(q = "William Ruto",
                        n=18000,
                        include_rts = FALSE,
                        `-filter` = "replies")
#Pull a random number of sample tweets
tweets %>%
  sample_n(5) %>% 
  select(created_at, screen_name, text, favorite_count, retweet_count)

#export as CSV
write_as_csv(tweets, "tweets.csv")

#Explore Tweets Timeline
ts_plot(tweets, "hours") +
  labs(x = NULL, y = NULL,
       title = "Frequency of tweets with William Ruto",
       subtitle = paste0(format(min(tweets$created_at), "%d %B %Y"), " to", format(max(tweets$created_at), " %d %B %Y")),
       caption = "Data Collected from Twitters REST API via rtweet") + 
         theme_minimal()
#Top Tweeting Location
tweets %>%
  filter(is.na(quoted_location))%>%
  count(quoted_location, sort = TRUE) %>%
  top_n(100)

#Most Frequently shared link
tweets %>%
  filter(is.na(urls_expanded_url))%>%
  count(urls_expanded_url, sort = FALSE) %>%
  top_n(100)
#Most Retweeted Tweet
tweets %>%
  arrange(-retweet_count) %>%
  slice(1) %>%
  select(created_at, screen_name, text, retweet_count)

library(magick)
library(webshot)
tweet_shot(tweet_url("minibloggerske", "1229505441958449153"))
tweet_shot()