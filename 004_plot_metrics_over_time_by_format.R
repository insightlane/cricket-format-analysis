library(ggplot2)
#install.packages("ggtext")
library(ggtext)


group.colors <- c(Test = "#1c65a4", #light blue
                  ODI = "#ffaa00", #gold
                  T20 = "#70ad47" #green
                  
)




ggplot(data = summarised_yearly_stats, 
       aes(x = year, 
           #y = year_batting_average,
           #y = year_batting_strike_rate, 
           y = year_bowling_strike_rate,
           group = type, colour = type, fill = type)) +
  geom_point(aes(size = no_innings)) +
  #geom_line()
  geom_smooth(aes(weight = no_innings), method = loess, se = TRUE) +
  
  theme_minimal() + 
  scale_color_manual(values = group.colors, name = "Format") +
  scale_fill_manual(values = group.colors,name = "Format") +
  scale_size_continuous(name = "No. innings") +
  #scale_x_continuous(breaks = c(0:4)) +
  #scale_y_continuous(breaks = c(0:2)/10) +
  theme(plot.background = element_rect(fill = "#FAFAFA",
                                       linetype = 0),
        #title = element_text(color="#555555"),
        
        #plot.title = element_text(color="#555555", face = "bold", size = 26,
        #                          margin=margin(10,0,10,0)
        #),
        #plot.subtitle = element_text(color="#555555", size = 16),
        axis.text.x=element_text(color="#555555", size = 14,
                                 margin=margin(0,0,10,0)), 

        axis.text.y=element_text(color="#555555", size = 14,
                                 margin=margin(0,0,0,10)), 
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        #axis.title = element_text(color="#555555", size = 14, face = "bold"), 
        strip.text = element_text(color="#555555", size = 14), 
        #strip.background = element_blank(),
        plot.caption = element_text(color="#555555", size = 10,
                                    margin=margin(0,0,0,0)
        ),
        legend.text = element_text(color="#555555", size = 14),
        legend.title = element_text(color="#555555", size = 14, face = "bold"),

        legend.position = "none",
        plot.title = element_markdown(face = "bold", size = 26, margin=margin(10,0,10,0)),
        plot.subtitle = element_markdown(size = 16),
        
  ) +
  labs(title = "Bowlers are striking Test batsmen down like never before",
       subtitle = "Aggregate bowling strike rate per year in <span style='color:#1c65a4;'><b>Test</b></span>, <span style='color:#ffaa00;'><b>ODI</b></span> and <span style='color:#70ad47;'><b>T20</b></span> formats | 1971-2020 calendar years",
       caption = "Source: ESPNcricinfo.com Statguru",
       x = "", 
       y = "")


#ggsave("batting_average.png", width = 26.66, height = 18.56,  unit = "cm", dpi = 600)
#ggsave("batting_strike_rate.png", width = 26.66, height = 18.56,  unit = "cm", dpi = 600)
#ggsave("bowling_strike_rate.png", width = 26.66, height = 18.56,  unit = "cm", dpi = 600)