library(readxl)
library(dplyr)
##install.packages("ggplot2")
library(ggplot2)
#install.packages("janitor")
library(janitor)
library(tidyr)



slope_chart_colour <- summarised_yearly_stats %>%
  filter(type != "T20") %>%
  ungroup() %>%
  group_by(type) %>%
  mutate(total_runs = sum(year_runs),
         total_wickets = sum(year_wickets),
         total_balls = sum(year_balls),
         total_batting_average = total_runs/total_wickets,
         total_batting_strike_rate = total_runs/total_balls * 100,
         total_bowling_strike_rate = total_balls/total_wickets)

slope_chart_grey <- slope_chart_colour %>%
  mutate(dice = year) %>%
  select(-year)

library(tidyr)

test_stats <- summarised_yearly_stats %>%
  filter(type == "Test") %>%
  filter(year >= 1971)

odi_stats <- summarised_yearly_stats %>%
  filter(type == "ODI") %>%
  filter(year >= 1971)

segment_chart <- test_stats %>%
  left_join(odi_stats, by = c("year")) %>%
  mutate(slope = (year_batting_average.y - year_batting_average.x)/(year_batting_strike_rate.y - year_batting_strike_rate.x))


segment_chart %>%
  ggplot(aes(x = year_batting_strike_rate.x, xend = year_batting_strike_rate.y, 
             y = year_batting_average.x, yend = year_batting_average.y, 
             colour = slope)) +
  geom_segment(size = 2) +
  scale_colour_gradient2(low = "blue",
                         mid = "grey",
                         high = "orange",
                         midpoint = 0,
                         limits = c(-0.8,0.8))

  ggplot() +
    # geom_line(data = slope_chart_grey,
    #           aes(x = year_batting_strike_rate, 
    #               #y = year_batting_strike_rate, 
    #               #y = year_batting_average,
    #               y = year_batting_average,
    #               group = dice
    #           ),
    #           colour = "black",
    #           alpha = 0.15) +  
    geom_line(data = slope_chart_grey,
              aes(x = total_batting_strike_rate,
                  #y = year_batting_strike_rate,
                  #y = year_batting_average,
                  y = total_batting_average,
                  group = dice
              ),
              colour = "grey",
              linetype = "dashed") +
  geom_line(data = slope_chart_colour,
            aes(x = year_batting_strike_rate, 
                #y = year_batting_strike_rate, 
                #y = year_batting_average,
                y = year_batting_average,
                group = year
                #colour = year_batting_average
            )) +
    geom_segment(data = segment_chart,
                 aes(x = year_batting_strike_rate.x, xend = year_batting_strike_rate.y, 
                     y = year_batting_average.x, yend = year_batting_average.y, 
                     colour = slope),
                 size = 2) +

  #geom_point(aes(size = no_innings, colour = type)) +
  geom_point(data = slope_chart_colour,
             aes(x = year_batting_strike_rate, 
                 #y = year_batting_strike_rate, 
                 #y = year_batting_average,
                 y = year_batting_average,
                 group = year
             )) +

    theme_minimal() + 

    scale_colour_gradient2(low = "blue",
                           mid = "grey",
                           high = "orange",
                           midpoint = 0,
                           limits = c(-0.8,0.8)) +

  facet_wrap(~ year, ncol = 5) +
  theme(plot.background = element_rect(fill = "#FAFAFA",
                                       linetype = 0),
        title = element_text(color="#555555"),
        
        plot.title = element_text(color="#555555", face = "bold", size = 26,
                                  margin=margin(10,0,10,0)
        ),
        plot.subtitle = element_text(color="#555555", size = 16),
        axis.text.x=element_text(color="#555555", size = 10,
                                 margin=margin(0,0,10,0)), 
        axis.text.y=element_text(color="#555555", size = 10,
                                 margin=margin(0,0,0,10)), 
        #axis.title.y = element_blank(), 
        axis.title = element_text(color="#555555", size = 14, face = "bold"), 
        strip.text = element_text(color="#555555", size = 10), 
        # strip.background = element_blank(),
        plot.caption = element_text(color="#555555", size = 10,
                                    margin=margin(-15,0,0,0)
        ),
        legend.text = element_text(color="#555555", size = 14),
        #legend.title = element_text(color="#555555", size = 14, face = "bold"),
        legend.title = element_blank(),
        legend.position = "none"
  ) +
  labs(title = "An inverted batting market",
       subtitle = "Batting average versus batting strike rate per year in Test and ODI formats | 1970-2021",
       caption = "Source: ESPNcricinfo.com Statguru",
       x = "Runs per 100 balls (batting strike rate)", 
       y = "Runs per wickets (batting average)")


ggsave("slope.png", width = 26.66, height = 52,  unit = "cm", dpi = 600)