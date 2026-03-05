## Load packages 
library(phonTools)
library(tidyverse)
library(ipa)
library(vowels)


## Load Hillenbrand data 
data(h95)

head(h95)

h95_norm <- h95 %>% 
  mutate(
    speaker_id = paste(type, speaker, sep = "_"),
    vowel_id = vowel,
    context = NA, 
    F1_glide = NA,
    F2_glide = NA,
    F3_glide = NA
  ) %>% 
  select(speaker_id, vowel_id, context, f1, f2, f3, F1_glide, F2_glide, F3_glide)

## Use IPA symbols
h95_norm$vowel_id <- convert_phonetics(h95_norm$vowel_id, from = "xsampa", to = "ipa")

## Recode the abnormal symbol
h95_norm$vowel_id <- recode(h95_norm$vowel_id, "ɜʲ" = "ɜː")


## Lobanov normalisation
h95_lobanov <- norm.lobanov(h95_norm)

## Nearey normalisation
h95_nearey <- norm.nearey(h95_norm)


## Watt & Fabricius normalisation
h95_watt_fabricius <- norm.wattfabricius(h95_norm)

## Prepare dataframes to combine into single large one
h95_lobanov$method <- "Lobanov"
h95_nearey$method <- "Nearey"
h95_watt_fabricius$method <- "Watt & Fabricius"

## Need to recode watt_fabricius column names to ensure consistency in final data frame
h95_watt_fabricius <- h95_watt_fabricius %>% 
  rename("F*1" = "F1/S(F1)",
         "F*2" = "F2/S(F2)")

## Combine normalised data into single data frame
h95_combined <- bind_rows(h95_lobanov, h95_nearey, h95_watt_fabricius) %>% 
  select(Speaker, Vowel, `F*1`, `F*2`, method)

h95_combined %>% 
  ggplot(aes(x = `F*2`, y = `F*1`, colour = Vowel)) + 
  geom_point(alpha = 0.4) + 
  stat_ellipse() +
  geom_label(data = h95_combined %>%
               group_by(Vowel, method) %>%
               summarise(`F*1` = mean(`F*1`),
                         `F*2` = mean(`F*2`)),
             aes(label = Vowel),
             size = 3,
             show.legend = FALSE) +
  scale_x_reverse() + scale_y_reverse() +
  facet_wrap(~ method, scales = "free") +
  labs(title = "Hillenbrand et al. (1995) Vowel Space by Normalisation Method",
       x = "F2 (Normalised)", y = "F1 (Normalised)", colour = "Vowel") +
  theme_bw()



