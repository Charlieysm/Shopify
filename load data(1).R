df <- read.csv("apps.csv")
df_1<- read.csv("apps_categories.csv")
df_2<- read.csv("categories.csv")
df_3<- read.csv("key_benefits.csv")
df_5<- read.csv("pricing_plans.csv")
df_6<- read.csv("reviews.csv")
#title "" 1855 fill it with NA 
df_5$title[df_5$title==""]<- NA 

#change pricing_hint into numeric and fill "" 1365  with 0 
library(stringr) #library I prefer
df$pricing_hint <- str_replace_all(df$pricing_hint, "[[-day free trial]]", "")
df$pricing_hint <- as.numeric(df$pricing_hint)
df$pricing_hint[df$pricing_hint==""]<- 0

#change price from $ /month to numeric and free to 0
df_5$price[df_5$price=="Free"]<- NA
df_5$price[df_5$price=="Free to install"]<- NA
library(stringr) #library I prefer
df_5$price <- str_replace_all(df_5$price, "[[$ /month]]", "")
df_5$price <- str_replace_all(df_5$price, "[[eiecarge]]", "")
df_5$price<- as.numeric(df_5$price)
df_5$price[is.na(df_5$price)]<- 0

#generate new index id called developer_id with unique developer. 
install.packages("dplyr")
library(dplyr)
df <- df %>% 
  mutate(developer_id = match(developer, unique(developer)))
#generate new index id called review_id with unique review(means unique app_id here)
df <- df %>% 
  mutate(review_id = match(id, unique(id)))

#table app_info, app_id is unique in apps.csv dataset
app_info<- df[,c("id", "developer_id","review_id")]
names(app_info)[names(app_info)=="id"]="app_id"
app_info$app_id<- as.character(app_info$app_id)
app_info$developer_id<- as.character(app_info$developer_id)
app_info$review_id<- as.character(app_info$review_id)

#Removing duplicate values of developer_id and generate new table developer with unqiue developer_id
library(dplyr)
df_developer<- df %>% distinct(developer_id, .keep_all = TRUE)

#table developer
developer<- df_developer[,c("developer_id", "developer","developer_link","icon")]
developer$developer_id<- as.character(developer$developer_id)
developer$developer<- as.character(developer$developer)
developer$developer_link<- as.character(developer$developer_link)
developer$icon<- as.character(developer$icon)

#table reviews
reviews<- df[,c("review_id", "rating", "reviews_count")]
reviews$review_id<- as.character(reviews$review_id)

#table apps_urls
apps_urls<- df[,c("id", "url")]
names(apps_urls)[names(apps_urls)=="id"]="app_id"
apps_urls$app_id<- as.character(apps_urls$app_id)
apps_urls$url<- as.character(apps_urls$url)

#table app_descriptions 
app_descriptions<- df[,c("id", "description_raw","description","tagline")]
names(app_descriptions)[names(app_descriptions)=="id"]="app_id"
app_descriptions$app_id<- as.character(app_descriptions$app_id)
app_descriptions$description_raw<- as.character(app_descriptions$description_raw)
app_descriptions$description<- as.character(app_descriptions$description)
app_descriptions$tagline<- as.character(app_descriptions$tagline)

#table pricing_advantages
pricing_advantages<- df[,c("id", "pricing_hint")]
names(pricing_advantages)[names(pricing_advantages)=="id"]="app_id"
pricing_advantages$app_id<- as.character(pricing_advantages$app_id)
pricing_advantages$pricing_hint<- as.integer(pricing_advantages$pricing_hint)

#table categories
categories<- df_1[,c("app_id", "category_id")]
categories$app_id<- as.character(categories$app_id)
categories$category_id<- as.character(categories$category_id)

#table titles
titles<- df_2
names(titles)[names(titles)=="id"]="category_id"
titles$category_id<- as.character(titles$category_id)
titles$title<- as.character(titles$title)


#generate new id: seriel number for this table 
df_3$id <- 1:nrow(df_3)
#table feature_descriptions
feature_descriptions<- df_3
feature_descriptions$id<- as.character(feature_descriptions$id)
feature_descriptions$app_id<- as.character(feature_descriptions$app_id)
feature_descriptions$title<- as.character(feature_descriptions$title)
feature_descriptions$description<- as.character(feature_descriptions$description)

#in df_6.csv app_id is not unqiue
#generate new index author_id in df_6.csv for every unique author. 
df_6 <- df_6 %>% 
  mutate(author_id= match(author, unique(author)))
#generate new index id called developer_review_id for every developer reply 
df_6$developer_review_id <- 1:nrow(df_6)
#generate new index id called author_review_id for every author reply 
df_6$author_review_id <- 1:nrow(df_6)

#table author_review_info
author_review_info<- df_6[,c("app_id", "author_id", "author_review_id")]
author_review_info$app_id<- as.character(author_review_info$app_id)
author_review_info$author_id<- as.character(author_review_info$author_id)
author_review_info$author_review_id<- as.character(author_review_info$author_review_id)

#Removing duplicate values of author_id and 
#generate new table author_info with unqiue author_id
install.packages("dplyr")
library(dplyr)
df_author<- df_6 %>% distinct(author_id, .keep_all = TRUE)
#table author_info
author_info<- df_author[,c("author_id", "author")]
str(author_info)# check author_id is integer 
author_info$author_id<- as.character(author_info$author_id)
author_info$author<- as.character(author_info$author)

#table author_reviews
author_reviews<- df_6[,c("author_review_id","rating", "posted_at","body" ,"helpful_count")]
author_reviews$rating <- as.integer(author_reviews$rating)
author_reviews$helpful_count <- as.integer(author_reviews$helpful_count)
author_reviews$author_review_id<- as.character(author_reviews$author_review_id)
author_reviews$posted_at<- as.character(author_reviews$posted_at)
author_reviews$body<-as.character(author_reviews$body)

#table developer_review_info
developer_review_info<- df_6[,c("developer_review_id", "app_id")]
developer_review_info$developer_review_id<- as.character(developer_review_info$developer_review_id)
developer_review_info$app_id<- as.character(developer_review_info$app_id)

#table developer_reviews
developer_reviews<- df_6[,c("developer_review_id", "developer_reply","developer_reply_posted_at")]
developer_reviews$developer_review_id<- as.character(developer_reviews$developer_review_id)
developer_reviews$developer_reply<- as.character(developer_reviews$developer_review_id)
developer_reviews$developer_reply_posted_at<- as.character(developer_reviews$developer_review_id)

#table app_price
app_price<- df_5
app_price$id<- as.character(app_price$id)
app_price$app_id<- as.character(app_price$app_id)
app_price$title<- as.character(app_price$title)

#Connecting to the database----
require('RPostgreSQL')
drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv, dbname = 'app_store',
                 host = 'localhost', port = 5432,
                 user = 'postgres', password = 'pwd4APAN5310')

#Write tables to the database----
dbWriteTable(con,'developer',developer, row.names=FALSE, append=TRUE)
dbWriteTable(con,'app_info',app_info, row.names=FALSE, append=TRUE)
dbWriteTable(con,'reviews',reviews, row.names=FALSE, append=TRUE)
dbWriteTable(con,'apps_urls',apps_urls, row.names=FALSE, append=TRUE)
dbWriteTable(con,'titles',titles, row.names=FALSE, append=TRUE)
dbWriteTable(con, "categories", categories, row.names=FALSE, append=TRUE)
dbWriteTable(con,'app_descriptions',app_descriptions, row.names=FALSE, append=TRUE)
dbWriteTable(con,'pricing_advantages',pricing_advantages, row.names=FALSE, append=TRUE)
dbWriteTable(con,'feature_descriptions',feature_descriptions, row.names=FALSE, append=TRUE)
dbWriteTable(con,'author_info',author_info, row.names=FALSE, append=TRUE)
dbWriteTable(con,'author_review_info',author_review_info, row.names=FALSE, append=TRUE)
dbWriteTable(con,'author_reviews',author_reviews, row.names=FALSE, append=TRUE)
dbWriteTable(con,'developer_review_info',developer_review_info, row.names=FALSE, append=TRUE)
dbWriteTable(con,'developer_reviews',developer_reviews, row.names=FALSE, append=TRUE)
dbWriteTable(con,'app_price',app_price, row.names=FALSE, append=TRUE)


#Pass your SQL statements----
stmt = "SELECT * FROM df;"
df <- dbGetQuery(con, stmt)

# Check the count of different rating levels
stmt1 = "SELECT rating,count(*) as count
FROM author_reviews
GROUP BY rating;"
df1 <- dbGetQuery(con, stmt1)


#helpful_count:Number of times the review was considered as helpful
# Join pricing,ratings and helpful_count 
stmt3="SELECT rating, helpful_count, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id;"
df3 <- dbGetQuery(con, stmt3)


# Check the ratings of apps with free charging. 
stmt5="SELECT rating, helpful_count, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id AND price = 0 
ORDER BY rating DESC;" 
df5 <- dbGetQuery(con, stmt5)

# We also want to know the count of different rating levels among free apps.
stmt6="SELECT rating,count(*) as count
FROM (
SELECT rating, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS rate
WHERE price = 0
GROUP BY rating
ORDER BY rating DESC;"
df6 <- dbGetQuery(con, stmt6)

# check ratings of charged apps
stmt7="SELECT rating, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id AND price != 0
ORDER BY rating DESC;" 
df7 <- dbGetQuery(con, stmt7)

# and the count of rating levels of charged apps
stmt8="SELECT rating,count(*) as count
FROM (
SELECT rating, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS R 
WHERE price != 0
GROUP BY rating
ORDER BY rating DESC;"
df8 <- dbGetQuery(con, stmt8)

# check ratings of charged apps:price $0-10/month
stmt9="SELECT *
FROM (
SELECT rating, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS A
WHERE price>0 AND price<=10
ORDER BY rating DESC;" 
df9 <- dbGetQuery(con, stmt9)

# and the count of their rating levels price $0-10/month
stmt10="SELECT rating,count(*) as count
FROM (
SELECT rating, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS B
WHERE price>0 AND price<=10
GROUP BY rating
ORDER BY rating DESC;"
df10 <- dbGetQuery(con, stmt10)

# check ratings of charged apps:price $10-50/month
stmt11="SELECT *
FROM (
SELECT rating,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS c
WHERE price>10 AND price<=50
ORDER BY rating DESC;" 
df11 <- dbGetQuery(con, stmt11)

# and the count of their rating levels
stmt12="SELECT rating,count(*) as count
FROM (
SELECT rating,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS D
WHERE price>10 AND price<=50
GROUP BY rating
ORDER BY rating DESC;"
df12 <- dbGetQuery(con, stmt12)

# check ratings of charged apps:price $50-100/month
stmt13="SELECT rating,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
AND price>50 AND price<=100
ORDER BY rating DESC;" 
df13 <- dbGetQuery(con, stmt13)

# and the count of their rating levels
stmt14="SELECT rating,count(*) as count
FROM (
SELECT rating,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS E
WHERE price>50 AND price<=100
GROUP BY rating
ORDER BY rating DESC;"
df14 <- dbGetQuery(con, stmt14)

# check ratings of charged apps:price >$100/month
stmt15="SELECT *
FROM (
SELECT rating,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS F 
WHERE price>100
ORDER BY rating DESC;" 
df15 <- dbGetQuery(con, stmt15)

# and the count of their rating levels
stmt16="SELECT rating,count(*) as count
FROM (
SELECT rating,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS G
WHERE price>100
GROUP BY rating
ORDER BY rating DESC;"
df16 <- dbGetQuery(con, stmt16)


# Among all the apps rated 5, how many are free apps?
stmt18="SELECT count(*) as count
FROM (
SELECT rating, helpful_count, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS K
WHERE price = 0 AND rating = 5;"
df18 <- dbGetQuery(con, stmt18)

# Among all the apps rated 5, how many apps price <$10/month?
stmt19="SELECT count(*) as count
FROM (
SELECT rating, helpful_count, price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
) AS L
WHERE price<=10;"
df19 <- dbGetQuery(con, stmt19)

# Then what about the helpful_count of each review with free apps?
#check the body of reviews 
stmt20="SELECT rating, helpful_count,body,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
AND price = 0
ORDER BY helpful_count DESC;"
df20 <- dbGetQuery(con, stmt20)

# as well as the helpful_count of charged apps
stmt21="SELECT DISTINCT rating, helpful_count,body,price
FROM author_reviews, author_review_info, app_price
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=app_price.app_id
AND price > 100
ORDER BY helpful_count DESC;"
df21 <- dbGetQuery(con, stmt21)

# We also want to know the count of different rating levels with price hint<=15 days
stmt22="SELECT rating,count(*) as count
FROM author_reviews, author_review_info, pricing_advantages
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=pricing_advantages.app_id
AND pricing_hint <= 15
GROUP BY rating
ORDER BY rating DESC;"
df22 <- dbGetQuery(con, stmt22)

# We also want to know the count of different rating levels with price hint>15 days
stmt23="SELECT rating,count(*) as count
FROM author_reviews, author_review_info, pricing_advantages
WHERE author_reviews.author_review_id = author_review_info.author_review_id
AND author_review_info.app_id=pricing_advantages.app_id
AND pricing_hint>15
GROUP BY rating
ORDER BY rating DESC;"
df23 <- dbGetQuery(con, stmt23)


