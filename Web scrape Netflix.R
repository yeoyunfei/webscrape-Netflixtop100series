install.packages('rvest')

#Loading libraries
library(rvest)
library(dplyr)


#Webpage of info you want to scrape
link = "https://www.imdb.com/list/ls063868333/"

#Creates a html document from a url
page = read_html(link)

#Taking the Title of the page

name = page %>% html_nodes(".lister-item-header a") %>% html_text()

year = page %>% html_nodes(".text-muted.unbold") %>% html_text()
  remove <- c ('IMDb user rating (average)', 'Number of votes', 'Release year or range' )
  year <- year [ !year %in% remove]

runtime = page %>% html_nodes(".runtime") %>% html_text()
  runtime <-append(runtime, 'NA', after = 34)  

rating = page %>% html_nodes(".ipl-rating-star.small .ipl-rating-star__rating") %>% html_text()

synopsis = page %>% html_nodes(".ipl-rating-widget+ p") %>% html_text()

genre = page %>% html_nodes(".genre") %>% html_text()

#create dataframe
#use stringAsFactors = F if you're planning to change the type of strings you're going to use in your data frame. If not the data will not be changed.
netflixtop100 = data.frame(name,year,rating,runtime, genre, synopsis, stringsAsFactors = FALSE)
write.csv(netflixtop100, "Netflixtop100.csv" )
