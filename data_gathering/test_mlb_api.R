# file to try using the mlb api
# API Docs: https://appac.github.io/mlb-data-api-docs/#top
# note sure this is detailed enough for our purposes

library(curl)
library(jsonlite)
library(magrittr)

# formats url for the player search request
# see the docs link above for details
format_player_search <- function(name_part,active_sw = "Y"){
  
  host <- "http://lookup-service-prod.mlb.com"
  endpoint <- "/json/named.search_player_all.bam"

  # formatting parameters 
  params <- list(
    "sport_code" = "mlb",
    "active_sw" = active_sw,
    "name_part" = name_part
  )  
  
  param_str <- sapply(1:length(params), function(i){
    paste0(names(params)[i],"='",params[[i]],"'")
  }) %>% paste(collapse = "&")
  
  paste0(host, endpoint,"?", param_str)
  
}

req <- format_player_search('devers%25') %>% curl_fetch_memory()
parse_headers(req$headers)

content <- jsonlite::prettify(rawToChar(req$content))
test <- jsonlite::fromJSON(content)
df <- test$search_player_all$queryResults$row %>% as.data.frame()

# test with the rafi devers id
rdeversid <- 646240

format_hitting_stats <- function(player_id, game_type = "R"){
  
  host <- "http://lookup-service-prod.mlb.com"
  endpoint <- "/json/named.sport_career_hitting.bam"
  
  # formatting parameters 
  params <- list(
    "league_list_id" = "mlb",
    "player_id" = player_id,
    "game_type" = game_type
  )  
  
  param_str <- sapply(1:length(params), function(i){
    paste0(names(params)[i],"='",params[[i]],"'")
  }) %>% paste(collapse = "&")
  
  paste0(host, endpoint,"?", param_str)
  
}

req <- format_hitting_stats(rdeversid) %>% curl_fetch_memory
parse_headers(req$headers)

content <- jsonlite::prettify(rawToChar(req$content))
test <- jsonlite::fromJSON(content)
df <- test$sport_career_hitting$queryResults$row %>% as.data.frame

