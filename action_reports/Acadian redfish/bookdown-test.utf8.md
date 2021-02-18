---
title: "Acadian redfish"
author: "Abigail Tyrell"
date: "18 Feb 2021"
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
  
  path: "" # figure path
---

# Acadian redfish {-}









This is a preliminary report of previously collected data. This report is pulling information on all Northeast Acadian redfish stocks.

<!--chapter:end:index.Rmd-->

# Methods

## Stock identification
Northeast stocks were identified from NOAA/EDAB ECSA [seasonal species strata](https://github.com/NOAA-EDAB/ECSA/blob/master/data/seasonal_stock_strata.csv).

## Data collection and presentation

Data sources for each analysis are identified in the Results.

All continuous temporal data were plotted against time. If there were 30 or more years of data, a geom_gls regression line was fit (yellow = significant increase; purple = significant decrease; no line = no significant trend). If there were fewer than 30 years of data, no regression was fit.

### `assessmentdata` methods
Stock assessment and data quality information were compiled into a summary table.

B/Bmsy was classified as "DANGER" if it was below 1 and "GOOD" if it was above 1.

F/Fmsy was classified as "DANGER" if it was above 1 and "GOOD" if it was below 1.

### `survdat` methods
`survdat` data with zero abundance were not included in this analysis. Abundance and biomass were summed for each year and season. All other metrics were averaged for each year and season. The tables show summary statistics for the entire time series and for the most recent 5 years in the time series. 

## Risk assessment

### Risk across stocks

#### Suite of indicators
All stocks were ranked in order of increasing risk. The stock with the highest ranking is the stock determined to be at the highest risk. In this case, high risk has two meanings: (1) high importance (e.g., a stock with a high catch would have a high risk ranking for the catch indicator) or high vulnerability (e.g., a stock with low B/Bmsy would have a high risk ranking for the B/Bmsy indicator). The normalized rank was determined by dividing each stock's rank by the total number of stocks considered for that indicator. Stocks that were missing indicator measurements were assigned a normalized rank of 0.5.

#### Individual indicators
Risk was calculated over time for all indicators that were documented for five or more species in a given year. Risk was calculated as the average of the past 5 years, as a percent of the historical average. The normalized risk value was calculated as the normalized rank of this species compared to all other species in that year.

### Risk within stocks
The normalized risk value was calculated as the normalized rank of each yearly measurement compared to all other years.

<!--chapter:end:01-methods.Rmd-->

# Habitat information

<!--chapter:end:02-habitat-title-page.Rmd-->

## Distribution





### Map of distribution
Strata maps were pulled and compiled using code from [NOAA/EDAB ECSA](https://github.com/NOAA-EDAB/ECSA). Please note, only fall and spring strata are shown on the map.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/ecsa_map-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:ecsa_map)Acadian redfish</p>
</div>

### Latitude and longitude ranges
Latitude and longitude ranges were calculated from NOAA/EDAB ECSA [seasonal species strata](https://github.com/NOAA-EDAB/ECSA/blob/master/data/seasonal_stock_strata.csv) and [Bottom Trawl Survey (BTS) shapefiles](https://github.com/NOAA-EDAB/ECSA/tree/master/data/strata_shapefiles). The coordinate system is WGS84.
<div class="figure" style="text-align: center">
preserve682d8a265fae983d
<p class="caption">(\#fig:latlong)Acadian redfish</p>
</div>

<!--chapter:end:03-latlong.Rmd-->

## Temperature





Surface and bottom temperature data were pulled from `survdat`. 

### Figures

Separate geom_gls() functions were fit for fall and spring measurements; trend lines are only shown when the trend was statistically significant, so some plots may have fewer than two trend lines. Fall has solid trend lines, and spring has dashed trend lines. Please note, sometimes the survey observed a small number of fish outside of the defined stock area.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/temp-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:temp-1)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/temp-2.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:temp-2)Acadian redfish</p>
</div>

### Summary
<div class="figure" style="text-align: center">
preserve28db7c3df1e40c2b
<p class="caption">(\#fig:temp_summary)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
preserve2e8d0f7e6f7829ba
<p class="caption">(\#fig:temp_summary)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve0e796f3d2d9282ad
<p class="caption">(\#fig:temp_data)Acadian redfish</p>
</div>

<!--chapter:end:04-temperature.Rmd-->

## Salinity





Surface and bottom salinity data were pulled from `survdat`. 

### Figures

Separate geom_gls() functions were fit for fall and spring measurements; trend lines are only shown when the trend was statistically significant, so some plots may have fewer than two trend lines. Fall has solid trend lines, and spring has dashed trend lines. Please note, sometimes the survey observed a small number of fish outside of the defined stock area.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/surfsalin-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:surfsalin-1)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/surfsalin-2.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:surfsalin-2)Acadian redfish</p>
</div>

### Summary
<div class="figure" style="text-align: center">
preservef6a16f0f7b55a47b
<p class="caption">(\#fig:salin_summary)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
preserve16ef1a515bf34067
<p class="caption">(\#fig:salin_summary)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserveefa27fb5cbcaf684
<p class="caption">(\#fig:salin_data)Acadian redfish</p>
</div>

<!--chapter:end:05-salinity.Rmd-->

## Depth
Ricky Tabandera



The range of depths that a species occupies is linked to many other habitat characteristics such as benthic structure, food availability, or temperature. Thus, observed depth can signal changes in habitat suitability. Changes in this metric can indicate the required resources are changing their distribution on the landscape. Seasonal differences in occurrence can also help identify essential habitat and the timing of migration to acquire seasonal resources 





### Figures

<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/depth_fig-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:depth_fig)Acadian redfish</p>
</div>

<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/depth_fig2-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:depth_fig2)Acadian redfish</p>
</div>




<!--chapter:end:06-depth.Rmd-->

## Habitat vulnerability



Habitat vulnerability information is sourced from the `ecodata` package. 


```
## [1] "NO DATA"
```

<!--chapter:end:07-habitat-vulnerability.Rmd-->

# Biological information

<!--chapter:end:08-biological-title-page.Rmd-->

## Length





Length data were pulled from `survdat`. Only years with more than 10 fish lengths were considered for analysis. 

### Figures

#### Overview {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length_freq-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length_freq-1)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length_freq-2.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length_freq-2)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length_freq-3.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length_freq-3)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length_freq-4.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length_freq-4)Acadian redfish</p>
</div>

#### Summary statistics {-}
Separate `geom_gls()` functions were fit for the minimum, mean, and maximum lengths; trend lines are only shown when the trend was statistically significant, so some plots may have fewer than three trend lines. Please note, sometimes the survey observed a small number of fish outside of the defined stock area.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length-1)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length-2.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length-2)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/length-3.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:length-3)Acadian redfish</p>
</div>

#### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-38-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-38)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-39-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-39)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-40-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-40)Acadian redfish</p>
</div>

### Summary

|Season |Region             |Mean value +- SD (n fish, n years) |Mean value +- SD (n fish, past 5 years) |Range (total) |Range (past 5 years) |
|:------|:------------------|:----------------------------------|:---------------------------------------|:-------------|:--------------------|
|FALL   |all                |24.18 +- 6.12 (357,257, 57)        |24.9 +- 5.45 (45,149, 5)                |1 - 49        |3 - 44               |
|FALL   |Outside stock area |23.75 +- 6.81 (60,279, 57)         |22.48 +- 6.12 (9,685, 5)                |3 - 48        |4 - 46               |
|SPRING |all                |24.67 +- 6.11 (251,414, 52)        |25.21 +- 5.59 (36,486, 5)               |4 - 49        |4 - 44               |
|SPRING |Outside stock area |24.69 +- 5.4 (58,565, 52)          |24.29 +- 4.74 (10,760, 5)               |3 - 52        |5 - 43               |
|SUMMER |all                |25.14 +- 6.44 (7,019, 7)           |22.06 +- 5.41 (3,652, 3)                |4 - 44        |4 - 44               |
|SUMMER |Outside stock area |21.35 +- 6.33 (112, 3)             |20.24 +- 6.15 (78, 2)                   |6 - 37        |6 - 33               |

### Data
<div class="figure" style="text-align: center">
preserveacf1ad041b6231c2
<p class="caption">(\#fig:length_data)Acadian redfish</p>
</div>

<!--chapter:end:09-length.Rmd-->

## von Bertalanffy growth curve

Ricky Tabandera







### Length at age growth curve

The predicted von Bertalanffy growth curve for NMFS managed fish species. Growth parameters of `Linf` (Length infinty), `K` (growth coefficient), and `t0` (size at time 0) were estimated using non-linear least square model. The starting point for model building is accomplished using `FSA::vbStarts`. Age and length data sourced from `survdat` and spans all years and survey areas. 



<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/single_growth_curve-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:single_growth_curve)Acadian redfish</p>
</div>

<!--chapter:end:10-von_b.Rmd-->

## Condition





Condition information comes from [diet data](https://github.com/Laurels1/Condition/blob/master/data/allfh.RData); only regions and seasons with more than 10 fish observations were considered. We calculated a rough condition factor as: Weight / Length^3, and relative weight was [previously calculated](https://github.com/Laurels1/Condition/tree/master/data).

### Figures

#### Length vs weight

Please note, no trend lines were fit, points are jittered to reduce overlap, and sometimes the survey observed a small number of fish outside of the defined stock area.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/lw-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:lw)Acadian redfish</p>
</div>

#### Condition factor: Weight-volume

If there were more than 30 years of data, a geom_gls() regression was fit. In order to fit the geom_gls() regression, we calculated the mean condition factor for each year and plotted the geom_gls() through those points. Please note, points are jittered to reduce overlap, and sometimes the survey observed a small number of fish outside of the defined stock area.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/condition-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:condition)Acadian redfish</p>
</div>

#### Condition factor: Relative weight

Please note, this data is aggregated by Ecological Protection Unit (EPU), which may differ slightly from the stock assessment regions.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/laurel_cond-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:laurel_cond)Acadian redfish</p>
</div>

### Data

#### Length vs weight with weight-volume condition factor
<div class="figure" style="text-align: center">
preserve6704891ed2adfa35
<p class="caption">(\#fig:lw_data)Acadian redfish</p>
</div>

#### Relative weight condition factor
Please note, this data is aggregated by Ecological Protection Unit (EPU), which may differ slightly from the stock assessment regions.
<div class="figure" style="text-align: center">
preserved5fd645a444b90dc
<p class="caption">(\#fig:laurel_cond_data)Acadian redfish</p>
</div>

<!--chapter:end:11-condition.Rmd-->

## Diet





Diet data were compiled from [existing data](https://github.com/Laurels1/Condition/blob/master/data/allfh.RData). For analysis, all geographic samples were grouped by season, year, and region, and only year-season-region combinations with more than 20 predators sampled were considered. Prey items that made up more than 5% of the predator's diet in at least one year-season-region were identified to the broad category level; all other prey are grouped into the "other" category.

### Figure
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/diet-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:diet)Acadian redfish</p>
</div>

### Summary
<div class="figure" style="text-align: center">
preserved49a92d65db2249f
<p class="caption">(\#fig:diet_summary)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve115ac6fcc13c1a2d
<p class="caption">(\#fig:diet_data)Acadian redfish</p>
</div>

<!--chapter:end:12-diet.Rmd-->

# Population information

<!--chapter:end:13-population-title-page.Rmd-->

## Abundance








Abundance data were pulled from `survdat` and `assessmentdata::stockAssessmentData`. 

### Figures

Separate geom_gls() functions were fit for fall and spring measurements; trend lines are only shown when the trend was statistically significant, so some plots may have fewer than two trend lines. Fall has solid trend lines, and spring has dashed trend lines. Please note, sometimes the survey observed a small number of fish outside of the defined stock area.

#### Survey abundance (raw measurements)
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/abun_survey-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:abun_survey)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-42-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-42)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-43-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-43)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-44-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-44)Acadian redfish</p>
</div>

#### Survey abundance (swept area estimates)

Please note, these estimates are not parsed by region or season. Swept area estimates are based on spring and fall surveys only. The shaded gray region indicates +/- two standard errors.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/abun_survey_swept-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:abun_survey_swept)Acadian redfish</p>
</div>

#### Assessment abundance



```
## [1] "NO DATA"
```

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}

```
## [1] "No Gulf of Maine / Georges Bank data"
```

##### Rank of value (magnitude) compared to other stocks {-}

```
## [1] "No Gulf of Maine / Georges Bank data"
```

##### Rank of value (magnitude) within a single stock, compared to all years {-}

```
## [1] "NO Gulf of Maine / Georges Bank DATA"
```

### Survey summary
<div class="figure" style="text-align: center">
preserve2379331e45fb6935
<p class="caption">(\#fig:abun_summary)Acadian redfish</p>
</div>

### Data

#### Survey data (raw measurements)
<div class="figure" style="text-align: center">
preserved50154b8c6fc4f85
<p class="caption">(\#fig:surv_abun_data)Acadian redfish</p>
</div>

#### Survey data (swept area estimates)
<div class="figure" style="text-align: center">
preserveca0c3d0ef0f952c0
<p class="caption">(\#fig:swept_abun_data)Acadian redfish</p>
</div>

#### Assessment data

```
## [1] "NO DATA"
```

<!--chapter:end:14-abundance.Rmd-->








## Biomass

Biomass data were pulled from `survdat`. 

### Figures

Separate geom_gls() functions were fit for fall and spring measurements; trend lines are only shown when the trend was statistically significant, so some plots may have fewer than two trend lines. Fall has solid trend lines, and spring has dashed trend lines. Please note, sometimes the survey observed a small number of fish outside of the defined stock area.

#### Survey biomass (raw measurements)
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/biomass-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:biomass)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-49-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-49)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-50-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-50)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-51-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-51)Acadian redfish</p>
</div>

#### Survey biomass (swept area estimates)

Please note, these estimates are not parsed by region or season. Swept area estimates are based on spring and fall surveys only. The shaded gray region indicates +/- two standard errors.
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/bio_survey_swept-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:bio_survey_swept)Acadian redfish</p>
</div>

#### Assessment biomass


<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/biomass_asmt-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:biomass_asmt)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-52-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-52)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-53-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-53)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-54-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-54)Acadian redfish</p>
</div>

### Survey summary
<div class="figure" style="text-align: center">
preservee964767c7c5327ea
<p class="caption">(\#fig:biomass_summary)Acadian redfish</p>
</div>

### Data

#### Survey data (raw measurements)
<div class="figure" style="text-align: center">
preservef708d23202f938eb
<p class="caption">(\#fig:biomass_data)Acadian redfish</p>
</div>

#### Survey data (swept area estimates)
<div class="figure" style="text-align: center">
preserve1fd1b64d38796026
<p class="caption">(\#fig:swept_biomass_data)Acadian redfish</p>
</div>

#### Assessment data
<div class="figure" style="text-align: center">
preserve83005aada7db9961
<p class="caption">(\#fig:asmt_biomass_data)Acadian redfish</p>
</div>

<!--chapter:end:15-biomass.Rmd-->

## B/Bmsy 






```
## # A tibble: 137 x 59
##    `Stock Name` Jurisdiction FMP   `Science Center` `Regional Ecosy~ `FSSI Stock?` `ITIS Taxon Ser~ `Scientific Nam~ `Common Name` `Stock Area` `Assessment Yea~
##    <chr>        <chr>        <chr> <chr>            <chr>            <chr>                    <dbl> <chr>            <chr>         <chr>                   <dbl>
##  1 White marli~ Atlantic HMS Cons~ SEFSC            Atlantic Highly~ N                       768126 Kajikia albida   White marlin  Atlantic                 2019
##  2 Yellowfin t~ Atlantic HMS Cons~ SEFSC            Atlantic Highly~ N                       172423 Thunnus albacar~ Yellowfin tu~ Atlantic                 2019
##  3 Lane snappe~ GMFMC        Reef~ SEFSC            Gulf of Mexico   Y                       168860 Lutjanus synagr~ Lane snapper  Gulf of Mex~             2019
##  4 Red grouper~ GMFMC        Reef~ SEFSC            Gulf of Mexico   Y                       167702 Epinephelus mor~ Red grouper   Gulf of Mex~             2019
##  5 Red grouper~ GMFMC        Reef~ SEFSC            Gulf of Mexico   Y                       167702 Epinephelus mor~ Red grouper   Gulf of Mex~             2019
##  6 Brown shrim~ GMFMC        Shri~ SEFSC            Gulf of Mexico   Y                       551570 Farfantepenaeus~ Brown shrimp  Gulf of Mex~             2019
##  7 Pink shrimp~ GMFMC        Shri~ SEFSC            Gulf of Mexico   Y                       551574 Farfantepenaeus~ Pink shrimp   Gulf of Mex~             2019
##  8 White shrim~ GMFMC        Shri~ SEFSC            Gulf of Mexico   Y                       551680 Litopenaeus set~ White shrimp  Gulf of Mex~             2019
##  9 Pacific hal~ IPHC         Spec~ NWFSC / AFSC     California Curr~ N                       172932 Hippoglossus st~ Pacific hali~ Pacific Coa~             2019
## 10 Bluefish - ~ MAFMC        Blue~ NEFSC            Northeast Shelf  Y                       168559 Pomatomus salta~ Bluefish      Atlantic Co~             2019
## # ... with 127 more rows, and 48 more variables: `Assessment Month` <dbl>, `Last Data Year` <dbl>, `Update Type` <chr>, `Review Result` <chr>, `Assessment
## #   Model` <chr>, `Model Version` <chr>, `Lead Lab` <chr>, Citation <chr>, `Final Assessment Report 1` <chr>, `Final Assessment Report 2` <chr>, `Point of
## #   Contact` <chr>, `Life History Data` <dbl>, `Abundance Data` <dbl>, `Catch Data` <dbl>, `Assessment Level` <dbl>, `Assessment Frequency` <dbl>, `Assessment
## #   Type` <chr>, `Model Category` <dbl>, `Catch Input Data` <dbl>, `Abundance Input Data` <dbl>, `Biological Input Data` <lgl>, `Ecosystem Linkage` <dbl>,
## #   `Composition Input Data` <dbl>, `F Year` <dbl>, `Estimated F` <dbl>, `F Unit` <chr>, `F Basis` <chr>, Flimit <dbl>, `Flimit Basis` <chr>, Fmsy <dbl>, `Fmsy
## #   Basis` <chr>, `F/Flimit` <dbl>, `F/Fmsy` <dbl>, Ftarget <dbl>, `Ftarget Basis` <chr>, `F/Ftarget` <dbl>, `B Year` <dbl>, `Estimated B` <dbl>, `B Unit` <chr>,
## #   `B Basis` <chr>, Blimit <dbl>, `Blimit Basis` <chr>, Bmsy <dbl>, `Bmsy Basis` <chr>, `B/Blimit` <dbl>, `B/Bmsy` <dbl>, MSY <dbl>, `MSY Unit` <chr>
```

```
## # A tibble: 0 x 59
## # ... with 59 variables: `Stock Name` <chr>, Jurisdiction <chr>, FMP <chr>, `Science Center` <chr>, `Regional Ecosystem` <chr>, `FSSI Stock?` <chr>, `ITIS Taxon
## #   Serial Number` <dbl>, `Scientific Name` <chr>, `Common Name` <chr>, `Stock Area` <chr>, `Assessment Year` <dbl>, `Assessment Month` <dbl>, `Last Data
## #   Year` <dbl>, `Update Type` <chr>, `Review Result` <chr>, `Assessment Model` <chr>, `Model Version` <chr>, `Lead Lab` <chr>, Citation <chr>, `Final Assessment
## #   Report 1` <chr>, `Final Assessment Report 2` <chr>, `Point of Contact` <chr>, `Life History Data` <dbl>, `Abundance Data` <dbl>, `Catch Data` <dbl>,
## #   `Assessment Level` <dbl>, `Assessment Frequency` <dbl>, `Assessment Type` <chr>, `Model Category` <dbl>, `Catch Input Data` <dbl>, `Abundance Input
## #   Data` <dbl>, `Biological Input Data` <lgl>, `Ecosystem Linkage` <dbl>, `Composition Input Data` <dbl>, `F Year` <dbl>, `Estimated F` <dbl>, `F Unit` <chr>, `F
## #   Basis` <chr>, Flimit <dbl>, `Flimit Basis` <chr>, Fmsy <dbl>, `Fmsy Basis` <chr>, `F/Flimit` <dbl>, `F/Fmsy` <dbl>, Ftarget <dbl>, `Ftarget Basis` <chr>,
## #   `F/Ftarget` <dbl>, `B Year` <dbl>, `Estimated B` <dbl>, `B Unit` <chr>, `B Basis` <chr>, Blimit <dbl>, `Blimit Basis` <chr>, Bmsy <dbl>, `Bmsy Basis` <chr>,
## #   `B/Blimit` <dbl>, `B/Bmsy` <dbl>, MSY <dbl>, `MSY Unit` <chr>
```

```
## # A tibble: 5 x 61
##   `Stock Name` Jurisdiction FMP   `Science Center` `Regional Ecosy~ `FSSI Stock?` `ITIS Taxon Ser~ `Scientific Nam~ `Common Name` `Stock Area` `Assessment Yea~
##   <chr>        <chr>        <chr> <chr>            <chr>            <chr>                    <int> <chr>            <chr>         <chr>                   <int>
## 1 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2005
## 2 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2008
## 3 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2012
## 4 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2015
## 5 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2017
## # ... with 50 more variables: `Assessment Month` <int>, `Last Data Year` <int>, `Update Type` <chr>, `Review Result` <chr>, `Assessment Model` <chr>, `Model
## #   Version` <chr>, `Lead Lab` <chr>, Citation <chr>, `Final Assessment Report 1` <chr>, `Final Assessment Report 2` <chr>, `Point of Contact` <chr>, `Life History
## #   Data` <int>, `Abundance Data` <int>, `Catch Data` <int>, `Assessment Level` <int>, `Assessment Frequency` <int>, `Assessment Type` <chr>, `Model
## #   Category` <int>, `Catch Input Data` <int>, `Abundance Input Data` <int>, `Biological Input Data` <lgl>, `Ecosystem Linkage` <int>, `Composition Input
## #   Data` <int>, `F Year` <int>, `Estimated F` <dbl>, `F Unit` <chr>, `F Basis` <chr>, Flimit <dbl>, `Flimit Basis` <chr>, Fmsy <dbl>, `Fmsy Basis` <chr>,
## #   `F/Flimit` <dbl>, `F/Fmsy` <dbl>, Ftarget <dbl>, `Ftarget Basis` <chr>, `F/Ftarget` <dbl>, `B Year` <int>, `Estimated B` <dbl>, `B Unit` <chr>, `B
## #   Basis` <chr>, Blimit <dbl>, `Blimit Basis` <chr>, Bmsy <dbl>, `Bmsy Basis` <chr>, `B/Blimit` <dbl>, `B/Bmsy` <dbl>, MSY <dbl>, `MSY Unit` <chr>, Species <chr>,
## #   Region <chr>
```

```
## # A tibble: 5 x 61
##   `Stock Name` Jurisdiction FMP   `Science Center` `Regional Ecosy~ `FSSI Stock?` `ITIS Taxon Ser~ `Scientific Nam~ `Common Name` `Stock Area` `Assessment Yea~
##   <chr>        <chr>        <chr> <chr>            <chr>            <chr>                    <int> <chr>            <chr>         <chr>                   <int>
## 1 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2005
## 2 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2008
## 3 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2012
## 4 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2015
## 5 Acadian red~ NEFMC        Nort~ NEFSC            Northeast Shelf  Y                       166774 Sebastes fascia~ Acadian redf~ Gulf of Mai~             2017
## # ... with 50 more variables: `Assessment Month` <int>, `Last Data Year` <int>, `Update Type` <chr>, `Review Result` <chr>, `Assessment Model` <chr>, `Model
## #   Version` <chr>, `Lead Lab` <chr>, Citation <chr>, `Final Assessment Report 1` <chr>, `Final Assessment Report 2` <chr>, `Point of Contact` <chr>, `Life History
## #   Data` <int>, `Abundance Data` <int>, `Catch Data` <int>, `Assessment Level` <int>, `Assessment Frequency` <int>, `Assessment Type` <chr>, `Model
## #   Category` <int>, `Catch Input Data` <int>, `Abundance Input Data` <int>, `Biological Input Data` <lgl>, `Ecosystem Linkage` <int>, `Composition Input
## #   Data` <int>, `F Year` <int>, `Estimated F` <dbl>, `F Unit` <chr>, `F Basis` <chr>, Flimit <dbl>, `Flimit Basis` <chr>, Fmsy <dbl>, `Fmsy Basis` <chr>,
## #   `F/Flimit` <dbl>, `F/Fmsy` <dbl>, Ftarget <dbl>, `Ftarget Basis` <chr>, `F/Ftarget` <dbl>, `B Year` <int>, `Estimated B` <dbl>, `B Unit` <chr>, `B
## #   Basis` <chr>, Blimit <dbl>, `Blimit Basis` <chr>, Bmsy <dbl>, `Bmsy Basis` <chr>, `B/Blimit` <dbl>, `B/Bmsy` <dbl>, MSY <dbl>, `MSY Unit` <chr>, Species <chr>,
## #   Region <chr>
```

```
## # A tibble: 337 x 61
##    `Stock Name` Jurisdiction FMP   `Science Center` `Regional Ecosy~ `FSSI Stock?` `ITIS Taxon Ser~ `Scientific Nam~ `Common Name` `Stock Area` `Assessment Yea~
##    <chr>        <chr>        <chr> <chr>            <chr>            <chr>                    <int> <chr>            <chr>         <chr>                   <int>
##  1 Atlantic su~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        80944 Spisula solidis~ Atlantic sur~ Mid-Atlanti~             2006
##  2 Atlantic su~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        80944 Spisula solidis~ Atlantic sur~ Mid-Atlanti~             2009
##  3 Atlantic su~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        80944 Spisula solidis~ Atlantic sur~ Mid-Atlanti~             2013
##  4 Atlantic su~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        80944 Spisula solidis~ Atlantic sur~ Mid-Atlanti~             2016
##  5 Ocean quaho~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        81343 Arctica islandi~ Ocean quahog  Atlantic Co~             2006
##  6 Ocean quaho~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        81343 Arctica islandi~ Ocean quahog  Atlantic Co~             2009
##  7 Ocean quaho~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        81343 Arctica islandi~ Ocean quahog  Atlantic Co~             2013
##  8 Ocean quaho~ MAFMC        Atla~ NEFSC            Northeast Shelf  Y                        81343 Arctica islandi~ Ocean quahog  Atlantic Co~             2017
##  9 Bluefish - ~ MAFMC        Blue~ NEFSC            Northeast Shelf  Y                       168559 Pomatomus salta~ Bluefish      Atlantic Co~             2005
## 10 Bluefish - ~ MAFMC        Blue~ NEFSC            Northeast Shelf  Y                       168559 Pomatomus salta~ Bluefish      Atlantic Co~             2007
## # ... with 327 more rows, and 50 more variables: `Assessment Month` <int>, `Last Data Year` <int>, `Update Type` <chr>, `Review Result` <chr>, `Assessment
## #   Model` <chr>, `Model Version` <chr>, `Lead Lab` <chr>, Citation <chr>, `Final Assessment Report 1` <chr>, `Final Assessment Report 2` <chr>, `Point of
## #   Contact` <chr>, `Life History Data` <int>, `Abundance Data` <int>, `Catch Data` <int>, `Assessment Level` <int>, `Assessment Frequency` <int>, `Assessment
## #   Type` <chr>, `Model Category` <int>, `Catch Input Data` <int>, `Abundance Input Data` <int>, `Biological Input Data` <lgl>, `Ecosystem Linkage` <int>,
## #   `Composition Input Data` <int>, `F Year` <int>, `Estimated F` <dbl>, `F Unit` <chr>, `F Basis` <chr>, Flimit <dbl>, `Flimit Basis` <chr>, Fmsy <dbl>, `Fmsy
## #   Basis` <chr>, `F/Flimit` <dbl>, `F/Fmsy` <dbl>, Ftarget <dbl>, `Ftarget Basis` <chr>, `F/Ftarget` <dbl>, `B Year` <int>, `Estimated B` <dbl>, `B Unit` <chr>,
## #   `B Basis` <chr>, Blimit <dbl>, `Blimit Basis` <chr>, Bmsy <dbl>, `Bmsy Basis` <chr>, `B/Blimit` <dbl>, `B/Bmsy` <dbl>, MSY <dbl>, `MSY Unit` <chr>,
## #   Species <chr>, Region <chr>
```






B/Bmsy data were pulled from `assessmentdata::stockAssessmentSummary`.

The most recent status of B/Bmsy is: GOOD

### Figure
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/bbmsy_fig-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:bbmsy_fig)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-56-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-56)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-57-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-57)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-58-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-58)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve3dcfc7fe1ea89363
<p class="caption">(\#fig:bbmsy_data)Acadian redfish</p>
</div>

<!--chapter:end:16-bbmsy.Rmd-->

## Recruitment








Recruitment data were pulled from `assessmentdata::stockAssessmentData`. Separate geom_gls() functions were fit for each region; trend lines are only shown when the trend was statistically significant, so some plots may have fewer trend lines than regions.

### Figure


<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/recruitment-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:recruitment)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-60-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-60)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-61-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-61)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-62-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-62)Acadian redfish</p>
</div>

### Data

<div class="figure" style="text-align: center">
preservec5fb58c217465fa7
<p class="caption">(\#fig:recruit_data)Acadian redfish</p>
</div>

<!--chapter:end:17-recruitment.Rmd-->

## Age diversity

Ricky Tabandera






Diversity in age measurements of a stock is a useful indicator of several factors relating to fishing pressure and recruitment. A decrease in diversity can be due to either truncation, the lack of older or younger ages. Diversity changes as a function of an increase of a single/few ages relative to the usual stock age structure or as more ages become less represented. Diagnostic plots of age are constructed below using fisheries independent data from `survdat`.

### Figures

#### Age diversity {-}



<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/age diversity calculations-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:age diversity calculations)Acadian redfish</p>
</div>

#### Density plots of age {-}

Age distribution across years of survey data of Acadian redfish. These plots can help identify strong year classes of recruits and how these classes persist in the fishery.  

<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/age density-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:age density)Acadian redfish</p>
</div>

<!--chapter:end:18-age-diversity.Rmd-->

## Climate vulnerability



Climate vulnerability is sourced from Hare et al. (2016). The overall climate score for Acadian redfish was moderate with high certainty.



### Figures
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-23-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-23-1)Acadian redfish</p>
</div><div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-23-2.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-23-2)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve90badb46e23f74f8
<p class="caption">(\#fig:unnamed-chunk-24)Acadian redfish</p>
</div>

<!--chapter:end:19-climate-vulnerability.Rmd-->

# Socio-economic information

<!--chapter:end:20-socio-economic-title-page.Rmd-->

## Catch








Stock assessment catch data are from `assessmentdata::stockAssessmentData`. Recreational catch data were downloaded from [NOAA MRIP](https://www.st.nmfs.noaa.gov/st1/recreational/MRIP_Estimate_Data/CSV/). Commercial catch data were downloaded from [NOAA FOSS](https://foss.nmfs.noaa.gov/apexfoss/f?p=215:200:4615327020711::NO:::).

### Figures


#### Stock assessment catch
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/catch-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:catch)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-64-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-64)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-65-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-65)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-66-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-66)Acadian redfish</p>
</div>

#### Recreational catch
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/rec-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:rec)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-67-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-67)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-68-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-68)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-69-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-69)Acadian redfish</p>
</div>

#### Commercial catch
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/com-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:com)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-70-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-70)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-71-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-71)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-72-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-72)Acadian redfish</p>
</div>

#### Commercial vs recreational catch
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/comvrec-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:comvrec)Acadian redfish</p>
</div>

### Data

#### Stock assessment catch
<div class="figure" style="text-align: center">
preserve2cf98ab2e092f2ca
<p class="caption">(\#fig:catch_data)Acadian redfish</p>
</div>

#### Recreational catch
<div class="figure" style="text-align: center">
preserve88769a88f082c70d
<p class="caption">(\#fig:rec_data)Acadian redfish</p>
</div>

#### Commercial catch
<div class="figure" style="text-align: center">
preservef37a32e14f3d0d88
<p class="caption">(\#fig:com_data)Acadian redfish</p>
</div>

#### Commercial vs recreational catch
<div class="figure" style="text-align: center">
preserve9c6fb42a05c69bfe
<p class="caption">(\#fig:comvrec_data)Acadian redfish</p>
</div>

#### Commercial, recreational, and stock assessment catch
<div class="figure" style="text-align: center">
preserved1cf5adc242af0b2
<p class="caption">(\#fig:all_catch)Acadian redfish</p>
</div>


<!--chapter:end:21-catch.Rmd-->

## F/Fmsy 










F/Fmsy data were pulled from `assessmentdata::stockAssessmentSummary`.

The most recent status of F/Fmsy is: GOOD

### Figure
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/ffmsy-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:ffmsy)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-74-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-74)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-75-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-75)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-76-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-76)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve11a87495bafd1185
<p class="caption">(\#fig:ffmsy_data)Acadian redfish</p>
</div>

<!--chapter:end:22-ffmsy.Rmd-->

## Revenue 





Commercial catch data were downloaded from [NOAA FOSS](https://foss.nmfs.noaa.gov/apexfoss/f?p=215:200:4615327020711::NO:::).

### Figure
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/revenue-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:revenue)Acadian redfish</p>
</div>

##### Risk {-}

See Methods for risk calculation details.



##### Rank of change compared to historical, ranked among stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-77-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-77)Acadian redfish</p>
</div>

##### Rank of value (magnitude) compared to other stocks {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-78-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-78)Acadian redfish</p>
</div>

##### Rank of value (magnitude) within a single stock, compared to all years {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/unnamed-chunk-79-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:unnamed-chunk-79)Acadian redfish</p>
</div>

### Data
<div class="figure" style="text-align: center">
preserve7ea33d496b830338
<p class="caption">(\#fig:revenue_data)Acadian redfish</p>
</div>

<!--chapter:end:23-revenue.Rmd-->

# Management information





## Stock assessment and data quality information
Stock assessment and data quality information were pulled from `assessmentdata::stockAssessmentSummary`.
<div class="figure" style="text-align: center">
preserve27fe07e307bb5df7
<p class="caption">(\#fig:quality)Acadian redfish</p>
</div>

<!--chapter:end:24-management.Rmd-->

# Risk assessment



A preliminary risk analysis was conducted by ranking all species according to their indicator values. A high rank number and a normalized rank near 1 indicates that the species is at risk or of importance based on the measured indicator values. When a species was missing an indicator, it was assigned a normalized rank of 0.5.

## Figures

### Relative to all other stocks

Risk was calculated over time for all indicators that were documented for five or more species in a given year. Risk was calculated as the average of the past 5 years, as a percent of the historical average. The normalized risk value plotted here reflects the normalized rank of this stock compared to all other stocks in that year.

#### Comprehensive risk assessment {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/comp_risk_plot-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:comp_risk_plot)Acadian redfish</p>
</div>

#### Normalized rank of magnitude of change compared to historical value by year {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/year_risk_hist-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:year_risk_hist)Acadian redfish</p>
</div>

#### Normalized rank of value in each year {-}
<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/year_risk_value-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:year_risk_value)Acadian redfish</p>
</div>

### Within a single stock

For each stock, a five-year running mean was calculated for each indicator. Indicator values were then ranked for all years where a value was present. The normalized risk values plotted here reflects the normalized rank of each year compared to all other years.

<div class="figure" style="text-align: center">
<img src="C:/Users/abigail.tyrell/Documents/esp_data_aggregation/action_reports//Acadian redfish/figures/stock_risk-1.png" alt="Acadian redfish" width="768" />
<p class="caption">(\#fig:stock_risk)Acadian redfish</p>
</div>

## Data

### Relative to all other stocks

#### Comprehensive risk assessment {-}
<div class="figure" style="text-align: center">
preserve598c14c2f3a54d97
<p class="caption">(\#fig:risk_comp)Acadian redfish</p>
</div>

#### Normalized rank of magnitude of change compared to historical value by year {-}
<div class="figure" style="text-align: center">
preserve75292bed33299918
<p class="caption">(\#fig:risk_hist)Acadian redfish</p>
</div>

#### Normalized rank of value in each year {-}
<div class="figure" style="text-align: center">
preserve63109a254abe1e0a
<p class="caption">(\#fig:risk_year)Acadian redfish</p>
</div>

### Value within each stock, ranked by year 
<div class="figure" style="text-align: center">
preserve32883dc50c4382a4
<p class="caption">(\#fig:risk_within)Acadian redfish</p>
</div>


<!--chapter:end:25-risk-assessment.Rmd-->

