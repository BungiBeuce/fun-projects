# fun-projects

Personal projects exploring my interests in phonetics and speech science using R. 

## Contents 

### Vowel Spaces
Some exploratory analysis of established vowel data. Includes basic R scripts to visualise data. Will update as I go along 
with my projects.

- `exploring_Hillenbrand95.R` - Vowel space plots for four speaker groups from Hillenbrand et al. (1995), using 
`phonTools` package. Includes IPA conversion with `ipa` package and reusable plotting function with `stat_ellipse()` and 
vowel means. 

- `exploring_Peterson_Barney52.R` - Vowel space plots for F1 and F2 data from the pb52 dataset in phonTools.
Used `phonTools`, xsampa to IPA conversion with `ipa` package, `tidyverse` for data manipulation and plotting. 
Includes raw Hz and normalised Hz vowel space plots for speakers, including a faceted plot by age group (adults vs children),
and my attempts at recreating the original vowel space figure from the 1952 paper. 

#### Normalisation Methods
Exploration of three vowel normalisation methods using the Hillenbrand et al. (1995) data.

- `normalisation_Hillenbrand95.R` - Compares Lobanov, Nearey and Watt & Fabricius normalisation methods.
- `normalisation_comparison.png` - Faceted plot comparing the three normalisation methods.
- `normalisation_methods.md` - Brief explanation of each normalisation method with references. Will potentially update as I learn more

## Requirements
- R packages: `phonTools`, `tidyverse`, `ipa`, `vowels`