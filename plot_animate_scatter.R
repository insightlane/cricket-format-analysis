

library(gganimate)
library(gifski)
library(magick)
library(png)



##install.packages("gganimate")
#install.packages("gifski")
#install.packages("magick")


#install.packages("png")

g <- ggplot(data = summarised_yearly_stats, 
            aes(x = year_batting_strike_rate, y = year_batting_average, group = type, colour = type)) +
  geom_point(aes(size = no_innings)) +
  #geom_line() +
  #labs(title = 'Year: {year}', x = 'SR', y = 'BA') +
  labs(title = 'Year', x = 'SR', y = 'BA') +
  
  transition_time(year) +
  #transition_reveal(along = Year) +
  shadow_wake(0.3) +
  ease_aes('linear')

animate(g
        , renderer = magick_renderer()
        #, fps = 20
        , nframes = 200
)

anim_save("test.gif", animation = last_animation())