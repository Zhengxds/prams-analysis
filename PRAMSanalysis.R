library(haven)
library(dplyr)
library(survey)
# load back only the prams dataset
load(file = "pramsone.RData")
load(file = "pramstwo.RData")
combined_prams <- bind_rows(pramsone, pramstwo)
combined_prams$BF5EVER.f <- factor(
  combined_prams$BF5EVER,
  levels = c(1, 2),
  labels = c("NO", "YES")
)
# get overall for 2016 - all states
# make survey design file
combined_prams.svy <- 
  svydesign(ids = ~0, strata = ~SUD_NEST, 
            fpc = ~TOTCNT, weights = ~WTANAL, 
            data = combined_prams)

svyby(~BF5EVER.f, ~NEST_YR,
      design = combined_prams.svy,
      svytotal, na.rm=TRUE)