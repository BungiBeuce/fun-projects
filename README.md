# fun-projects

Personal projects exploring my interests in phonetics and speech science using R. 

## Contents 

### Vowel Spaces
Some exploratory analysis of established vowel data. Includes basic R scripts to visualise data. Will update as I go along 
with my projects.

- `exploring_Hillenbrand95.R` - Vowel space plots for four speaker groups from Hillenbrand et al. (1995), using 
`phonTools` package. Includes IPA conversion with `ipa` package and reusable plotting function with `stat_ellipse()` and 
vowel means. 

#### Normalisation Methods
Exploration of three vowel normalisation methods using the Hillenbrand et al. (1995) data.

- `normalisation_Hillenbrand95.R` - Compares Lobanov, Nearey and Watt & Fabricius normalisation methods.
- `normalisation_comparison.png` - Faceted plot comparing the three normalisation methods.
- `normalisation_methods.md` - Brief explanation of each normalisation method with references. Will potentially update as I learn more

## Requirements
- R packages: `phonTools`, `tidyverse`, `ipa`, `vowels`