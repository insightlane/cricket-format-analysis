## Create Test match sub-list for dates until 1900

test_match_list_1 <- test_match_list %>%
  slice(1:235) %>%
  mutate(start_date = as.Date(start_date_ascending, c("%d %b %Y")))

## Create Test match sub-list for dates after 1900

test_match_list_2 <- test_match_list %>%
  slice(236:n()) %>%
  mutate(start_date = as.Date(as.numeric(start_date_ascending), origin = "1899-12-30"))

## Recombine the Test match lists with fixed start dates

test_match_list <- rbind(test_match_list_1, test_match_list_2)
rm(test_match_list_1, test_match_list_2)

## Create ODI list with fixed start date

odi_match_list <- odi_match_list %>%
  mutate(start_date = as.Date(start_date_ascending))

## Create T20 list with fixed start date

t20_match_list <- t20_match_list %>%
  mutate(start_date = as.Date(start_date_ascending))
  
## Create master list of all three formats

compiled_match_list <- rbind(test_match_list, 
                             odi_match_list, 
                             t20_match_list) %>%
  select(-10, -14) %>%
  select(-start_date_ascending) %>%
  mutate(year = format(start_date,"%Y")) %>%
  mutate(score_clean = as.numeric(score_clean),
         wickets = as.numeric(wickets),
         total_balls = as.numeric(total_balls),
         year = as.numeric(year)) %>%
  # mutate(score_clean = ifelse(is.na(score_clean), 0, score_clean),
  #        wickets = ifelse(is.na(wickets), 0, wickets),
  #        total_balls = ifelse(is.na(total_balls), 0, total_balls)) %>%
  filter(score != "DNB" & score != "forfeited") %>%
  mutate(opposition = substring(opposition, 3))

