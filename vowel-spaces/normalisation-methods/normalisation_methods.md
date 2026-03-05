# Vowel Normalisation Methods

I wanted to explore different ways of dealing with variation in acoustic data, which of course can arise due to 
various factors, including but not limited to age, sex, physiology, and more. I use the Hillenbrand et al. (1995)
data from the phonTools package to explore 3 normalisation methods.

## Lobanov 

Lobanov's method converts each speakers formant values to z-scores by subtracting their mean and dividing by standard 
deviation with the following formula 

F = (F - mean(F)) / sd(F)

This is a widely used method of normalisation for acoustic data and effectively removes speaker variation in a dataset.

It is worth noting that z-scoring centres values around 0

## Nearey 

Normalises values in log space by subtracting the log mean of all formants from each log formant value with the 
following formula

F = log(F) - mean(log(F))

This is thought to better reflect how the auditory system processes frequency information in contrast to raw/linear Hz 
values

## Watt & Fabricius 

Normalises each formant relative to a centroid which is calculated from the corner vowels for a speaker. Values are 
then expressed as a ratio relative to this centroid.

F = F / centroid(F)

This is a more linguistically motivated method of normalisation than the others, it incorporates the boundaries which 
define a speaker's vowel space.

## References

Kendall, Tyler and Erik R. Thomas. 2026. vowels: Vowel Manipulation,
Normalization, and Plotting. R package version 1.2-3.
https://doi.org/10.32614/CRAN.package.vowels

Thomas, Erik R. and Tyler Kendall. 2007.
NORM: The vowel normalization and plotting suite.
http://lingtools.uoregon.edu/norm/

Lobanov, B. M. 1971. Classification of Russian vowels spoken by different speakers.
*Journal of the Acoustical Society of America* 49:606-08.

Nearey, Terrance M. 1977. Phonetic Feature Systems for Vowels.
Dissertation, University of Alberta.
Reprinted 1978 by the Indiana University Linguistics Club.

Watt, Dominic, Anne Fabricius, and Tyler Kendall. 2011. More on Vowels: Plotting and Normalization.
In M. Yaeger-Dror and M. Di Paolo (eds.), *Sociophonetics: A Student's Guide*, 107-118. Routledge.