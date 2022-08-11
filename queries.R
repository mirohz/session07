install.packages("ggplot2")

library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2) 

my_db <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(my_db)

country.languages <- my_db %>% tbl("CountryLanguage") 

head(country.languages)

spanish.speakers <- country.languages %>% filter(Language == "Spanish")
spanish.speakers %>% ggplot(
  aes(x = Percentage, y = CountryCode, fill = IsOfficial)
) + geom_bin2d()

dbDisconnect(my_db)
