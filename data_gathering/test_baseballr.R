# test with baseballr
# Github:
# https://github.com/billpetti/baseballr
# Official website:
# https://billpetti.github.io/baseballr/

library(baseballr)
library(dplyr)

rm(list = ls())
gc()

# look at rafi devers stats
rafi_lookup <- playerid_lookup("Devers","Rafael")
rdid <- rafi_lookup$mlbam_id

# getting rafi pitch by pitch data
rafi <- statcast_search(start_date = "2021-06-01", end_date = "2021-06-15",
                        playerid = rdid, player_type = "batter")


