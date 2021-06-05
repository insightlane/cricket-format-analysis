## Create list of included countries

test_nations_8 <- c("Australia",
                    "England",
                    "New Zealand",
                    "South Africa",
                    "Pakistan",
                    "India",
                    "Sri Lanka",
                    "West Indies")

## Create table of summarised metrics at yearly level for 1971-2020

summarised_yearly_stats <- compiled_match_list %>%
  filter(team %in% test_nations_8) %>%
  filter(opposition %in% test_nations_8) %>%
  group_by(year, type) %>%
  summarise(year_runs = sum(score_clean),
            year_wickets = sum(wickets),
            year_overs = sum(total_balls)/6,
            year_balls = sum(total_balls),
            year_batting_average = year_runs/year_wickets,
            year_batting_strike_rate = year_runs/year_balls*100,
            year_bowling_strike_rate = year_balls/year_wickets,
            no_innings = n()) %>%
  ungroup() %>%
  filter(year >= 1971) %>%
  filter(year <= 2020)


