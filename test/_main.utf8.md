---
title: "Acadian redfish"
author: "Abigail Tyrell"
date: "09 Feb 2021"
site: bookdown::bookdown_site
output: 
  bookdown::gitbook:
    split_by: section
documentclass: book
github-repo: NOAA-EDAB/esp_data_aggregation

language:
  ui:
    chapter_name: "Section "

params: 
  species_ID: "Acadian redfish" # common name of species
  
  latlong_data: data # strata
  shape: shape # shapefile
  
  asmt_sum_data: data # bbmsy, ffmsy, assessment ratings
  asmt_sum_source: "assessmentdata::stockAssessmentSummary"

  diet_data: data # allfh diet data
  
  survey_data: data # survey data
  survey_source: "survdat"
  
  ricky_survey_data: data # ricky survey data

  rec_data: data # recreational catch (MRIP)
  
  asmt_data: data # assessmentdata:stockAssessmentData, for recruitment and catch
  asmt_source: "assessmentdata::stockAssessmentData"
  
  cond_data: data # Laurel's condition data
  
  risk_data: data # relative risk rankings
  
  com_data: data # commercial catch
  
  swept_data: data # swept area estimates
  
  risk_year_hist_data: data # historical risk by year
  
  risk_year_value_data: data # value risk by year
  
  risk_species_data: data # species risk
  
  cache: FALSE
---

# Acadian redfish {-}









This is a preliminary report of previously collected data. This report is pulling information on all Northeast Acadian redfish stocks.

<!--chapter:end:index.Rmd-->

# Risk assessment





## Preliminary risk calculation

A preliminary risk analysis was conducted by ranking all species according to their indicator values. A high rank number and a normalized rank near 1 indicates that the species is at risk or of importance based on the measured indicator values. When a species was missing an indicator, it was assigned a normalized rank of 0.5.

### Relative to all other stocks

#### Comprehensive risk assessment {-}
<div class="figure" style="text-align: center">
preservea9639e9d13506ce4
<p class="caption">(\#fig:risk_comp)Acadian redfish</p>
</div>

#### Ranked value as percent of historical value by year {-}
<div class="figure" style="text-align: center">
preserveb792c98b9dfd985b
<p class="caption">(\#fig:risk_hist)Acadian redfish</p>
</div>

#### Ranked value in each year {-}
<div class="figure" style="text-align: center">
preservef6aade59d4ff32dd
<p class="caption">(\#fig:risk_year)Acadian redfish</p>
</div>

### Value within each stock, ranked by year 
<div class="figure" style="text-align: center">
preserve3d0bb555bbe2d07f
<p class="caption">(\#fig:risk_within)Acadian redfish</p>
</div>

## Preliminary risk visualization

### Relative to all other stocks

Risk was calculated over time for all indicators that were documented for five or more species in a given year. Risk was calculated as the average of the past 5 years, as a percent of the historical average. The normalized risk value plotted here reflects the normalized rank of this stock compared to all other stocks in that year.

#### Comprehensive risk assessment {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/comp_risk_plot-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:comp_risk_plot)Acadian redfish</p>
</div>

#### Ranked value as percent of historical value by year {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/year_risk_hist-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:year_risk_hist)Acadian redfish</p>
</div>

#### Ranked value in each year {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/year_risk_value-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:year_risk_value)Acadian redfish</p>
</div>

### Within a single stock

For each stock, a five-year running mean was calculated for each indicator. Indicator values were then ranked for all years where a value was present. The normalized risk values plotted here reflects the normalized rank of each year compared to all other years.

<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/stock_risk-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:stock_risk)Acadian redfish</p>
</div>

<!--chapter:end:23-risk-assessment.Rmd-->

