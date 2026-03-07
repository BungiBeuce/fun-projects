library(tidyverse)
library(phonTools)
library(ipa)


## Load data
data("pb52")

## Relevant columns are type, speaker, sex, vowel, repetition, f0, f1, f2, f3

## 1520 observations

## vowels are coded in xsampa, can convert with ipa package

## Number of speakers 
length(unique(pb52$speaker))

## 76 speakers


## Look at vowel symbols
table(pb52$vowel)

## Try converting and check if it works 

pb52$vowel <- convert_phonetics(pb52$vowel, from = "xsampa", to = "ipa")

## Check if it worked 
table(pb52$vowel)

## Same issue as with Hillenbrand data, one vowel not coded properly
pb52$vowel <- recode(pb52$vowel, "ɜʲ" = "ɜː")

table(pb52$vowel)

## Try a basic plot 
pb52 %>% 
  ggplot(aes(x = f2, y = f1, col = vowel)) +
  geom_point() +
  scale_x_reverse() + scale_y_reverse() +
  stat_ellipse()

## Can modify and reuse the plotting function from my Hillenbrand et al. (1995) analysis, should work as
## data is in same format

phonTools_vowel_space <- function(data, title) {
  data %>% 
    ggplot(aes(x = f2, y = f1, colour = as.factor(vowel))) +
    geom_point(alpha = 0.8) +
    scale_x_reverse() + scale_y_reverse() +
    theme_bw(base_size = 10) +
    stat_ellipse() + 
    geom_label(
      data = data %>% 
        group_by(vowel) %>% 
        summarise(f1 = mean(f1), f2 = mean(f2)),
      aes(label = vowel),
      size = 3, show.legend = FALSE
    ) +
    labs(title = title,
         x = "F2 (Hz)", y = "F1 (Hz)",
         colour = "Vowel")
}

phonTools_vowel_space(pb52, "Peterson & Barney (1952) American English Vowel Space")

## Want to do a custom plot with axis labels to match the 1952 paper - this doesn't split by type
pb52 %>% 
  ggplot(aes(x = f1, y = f2, col = vowel)) +
  geom_point() +
  stat_ellipse() +
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2") +
  geom_label(
    data = pb52 %>%
      group_by(vowel) %>%
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel),
    size = 3, show.legend = FALSE
  ) +
  theme_bw() + 
  labs(title = "Peterson & Barney (1952) octave scaled F1 vs F2",
       x = "F1 (Hz)", y = "F2 (Hz)") +
  theme(legend.position = "none")


## Would be good to separate out speaker groups and normalise data, will hopefully make
## vowel space more clear and vowels more distinct from each other 
## Also a good opportunity to look at phonTools normalisation functions

## Filer data just for adults, can then normalise formants between the men and women
pb52_adults <- pb52 %>% 
  filter(type != "c")

## Normalise data with phonTools function
pb52_lobanov <- normalize(pb52_adults[, c("f1", "f2", "f3")],
                          speakers = pb52_adults$speaker,
                          vowels = pb52_adults$vowel,
                          method = "lobanov")

## This plot mimics the shape of the 1952 paper for figure 8
pb52_lobanov %>% 
  ggplot(aes(x = f1, y = f2, col = vowel)) +
  geom_point() + 
  stat_ellipse() +
  geom_label(
    data = pb52_lobanov %>% 
      group_by(vowel) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel),
    size = 3, show.legend = FALSE
  ) +
  theme_bw() +
  labs(
    title = "Peterson & Barney (1952) F1 vs F2 with Lobanov Normalisation",
    x = "Normalised F1", y = "Normalised F2", subtitle = "Attempt at replicating shape of figure 8 from original paper"
  )


## Can make a more typical vowel plot as well
pb52_lobanov %>% 
  ggplot(aes(x = f2, y = f1, col = vowel)) +
  geom_point() + 
  scale_x_reverse() + scale_y_reverse() +
  stat_ellipse() +
  geom_label(
    data = pb52_lobanov %>% 
      group_by(vowel) %>% 
      summarise(
        f1 = mean(f1),
        f2 = mean(f2)),
    aes(label = vowel),
    size = 3, show.legend = FALSE
  ) +
  theme_bw() +
  labs(
    title = "Peterson & Barney (1952) American English Lobanov Normalised Vowel Space",
    x = "Normalised F2", y = "Normalised F1"
  )

## Can also make a vowel plot for just adults which is not normalised, and maybe compare to children as well

## avc just means adult v children 
## Will recode men and women as "adult" in new column, and children as "child"
pb52_avc <- pb52 %>% 
  mutate(
    age_group = case_when(
      type == "c" ~ "child",
      type == "m" ~ "adult",
      type == "w" ~ "adult"
    )
  )

## Normalise data, save in new frame so can compare maybe to the non-normalised data
pb52_avc_lnorm <- normalize(pb52_avc[, c("f1", "f2", "f3")],
                            speakers = pb52_avc$speaker,
                            vowels = pb52_avc$vowel,
                            method = "lobanov"
                            )

## Need to add age_group and type back in 
pb52_avc_lnorm$type <- pb52_avc$type
pb52_avc_lnorm$age_group <- pb52_avc$age_group

## Final plot faceting by speaker age group
pb52_avc_lnorm %>% 
  ggplot(aes(x = f2, y = f1, col = vowel)) +
  geom_point() +
  scale_x_reverse() + scale_y_reverse() +
  geom_label(
    data = pb52_avc_lnorm %>% 
      group_by(vowel, age_group) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel),
    size = 3, show.legend = FALSE
  ) +
  theme_bw() +
  stat_ellipse() +
  facet_wrap(~ age_group) +
  labs(
    title = "Peterson & Barney (1952) F1 and F2 data by age group",
    x = "Normalised F2", y = "Normalised F1"
  )

## Non-faceted plot to look at
pb52_avc_lnorm %>% 
  ggplot(aes(x = f2, y = f1, col = vowel)) +
  geom_point() +
  scale_x_reverse() + scale_y_reverse() +
  geom_label(
    data = pb52_avc_lnorm %>% 
      group_by(vowel) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel),
    size = 3, show.legend = FALSE
  ) +
  theme_bw() +
  stat_ellipse() +
  labs(
    title = "Peterson & Barney (1952) F1 and F2",
    x = "Normalised F2", y = "Normalised F1"
  )


## Mimic shape of figure 8 in 1952 paper, swapping traditional axis representation 
## and not reversing axes
pb52_avc_lnorm %>% 
  ggplot(aes(x = f1, y = f2, col = vowel)) +
  geom_point() +
  geom_label(
    data = pb52_avc_lnorm %>% 
      group_by(vowel) %>% 
      summarise(f1 = mean(f1), f2 = mean(f2)),
    aes(label = vowel),
    size = 3, show.legend = FALSE
  ) +
  theme_bw() +
  stat_ellipse() +
  labs(
    title = "Peterson & Barney (1952) F1 and F2",
    x = "Normalised F1", y = "Normalised F2"
  )


