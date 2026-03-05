library(ipa)
library(phonTools)
library(tidyverse)

data(h95)

## 1668 observations of 8 variables

## Use ipa package to convert symbols from xsampa to IPA
h95$vowel_ipa <- convert_phonetics(h95$vowel, from = "xsampa", to = "ipa")

h95$vowel_ipa <- recode(h95$vowel_ipa, "ɜʲ" = "ɜː")

## Verify that it worked
table(h95$vowel)


men <- subset(h95, type == "m")
women <- subset(h95, type == "w")
boys <- subset(h95, type == "b")
girls <- subset(h95, type == "g")


## Plot for adult male speakers
men %>% 
  ggplot(aes(x = f2, y = f1, colour = as.factor(vowel_ipa))) +
  geom_point(alpha = 0.8) +
  scale_x_reverse() + scale_y_reverse() +
  labs(title = "Hillenbrand et al. (1995) Adult Male Vowel Space",
       x = "F2 (Hz)", y = "F1 (Hz)",
       colour = "Vowel") +
  theme_bw() +
  stat_ellipse() +
  geom_label(
    data = men %>% 
      group_by(vowel_ipa) %>% 
      summarise(
        f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel_ipa),
    size = 3, show.legend = FALSE
  )

women %>% 
  ggplot(aes(x = f2, y = f1, colour = as.factor(vowel_ipa))) +
  geom_point(alpha = 0.8) +
  scale_x_reverse() + scale_y_reverse() +
  theme_bw() +
  stat_ellipse() + 
  geom_label(
    data = women %>% 
      group_by(vowel_ipa) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel_ipa),
    size = 3, show.legend = FALSE
  ) +
  labs(title = "Hillenbrand et al. (1995) Adult Woman Vowel Space",
       x = "F2 (Hz)", y = "F1 (Hz)",
       colour = "Vowel")


boys %>% 
  ggplot(aes(x = f2, y = f1, colour = as.factor(vowel_ipa))) +
  geom_point(alpha = 0.8) +
  scale_x_reverse() + scale_y_reverse() +
  theme_bw() +
  stat_ellipse() + 
  geom_label(
    data = boys %>% 
      group_by(vowel_ipa) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel_ipa),
    size = 3, show.legend = FALSE
  ) +
  labs(title = "Hillenbrand et al. (1995) Boys Vowel Space",
       x = "F2 (Hz)", y = "F1 (Hz)",
       colour = "Vowel")


girls %>% 
  ggplot(aes(x = f2, y = f1, colour = as.factor(vowel_ipa))) +
  geom_point(alpha = 0.8) +
  scale_x_reverse() + scale_y_reverse() +
  theme_bw() +
  stat_ellipse() + 
  geom_label(
    data = girls %>% 
      group_by(vowel_ipa) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel_ipa),
    size = 3, show.legend = FALSE
  ) +
  labs(title = "Hillenbrand et al. (1995) Girls Vowel Space",
       x = "F2 (Hz)", y = "F1 (Hz)",
       colour = "Vowel")


## Create a function to do this manually instead of having separate blocks of code

h95_vowel_space <- function(data, title) {
  data %>% 
    ggplot(aes(x = f2, y = f1, colour = as.factor(vowel_ipa))) +
    geom_point(alpha = 0.8) +
    scale_x_reverse() + scale_y_reverse() +
    theme_bw(base_size = 10) +
    stat_ellipse() + 
    geom_label(
      data = data %>% 
        group_by(vowel_ipa) %>% 
        summarise(f1 = mean(f1), f2 = mean(f2)),
      aes(label = vowel_ipa),
      size = 3, show.legend = FALSE
    ) +
    labs(title = title,
         x = "F2 (Hz)", y = "F1 (Hz)",
         colour = "Vowel")
}

h95_vowel_space(men, "Hillenbrand et al. (1995) Adult Male Vowel Space")
