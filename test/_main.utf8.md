---
title: "Bluefish"
author: "Abigail Tyrell"
date: "11 Feb 2021"
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

# Bluefish {-}









This is a preliminary report of previously collected data. This report is pulling information on all Northeast Bluefish stocks.

<!--chapter:end:index.Rmd-->











## B/Bmsy 

B/Bmsy data were pulled from `assessmentdata::stockAssessmentSummary`.

The most recent status of B/Bmsy is: DANGER

### Figure
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/bbmsy_fig-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:bbmsy_fig)Bluefish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/unnamed-chunk-8-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-8)Bluefish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/unnamed-chunk-9-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-9)Bluefish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/unnamed-chunk-10-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-10)Bluefish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preservecb08099f179c9759
<p class="caption">(\#fig:bbmsy_data)Bluefish</p>
</div>

<!--chapter:end:16-bbmsy.Rmd-->

## F/Fmsy 










F/Fmsy data were pulled from `assessmentdata::stockAssessmentSummary`.

The most recent status of F/Fmsy is: GOOD

### Figure
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/ffmsy-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:ffmsy)Bluefish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/unnamed-chunk-12-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-12)Bluefish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/unnamed-chunk-13-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-13)Bluefish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="_main_files/figure-html/unnamed-chunk-14-1.png" alt="Bluefish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-14)Bluefish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve831c1bb32cb303fc
<p class="caption">(\#fig:ffmsy_data)Bluefish</p>
</div>

<!--chapter:end:21-ffmsy.Rmd-->

