---
title: "Preliminary Bluefish ESP"
author: "Abigail Tyrell"
date: "16 Feb 2021"
site: bookdown::bookdown_site
output: 
  bookdown::gitbook:
    split_by: section
documentclass: book
github-repo: NOAA-EDAB/esp_data_aggregation
---



# Introduction

These are prliminary regressions that compare bluefish catch, abundance, recruitment, and F to various indicators.

# Regression analysis

<!--chapter:end:index.Rmd-->

## Trends with time

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-2-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-3)Catch vs Time</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 1812634.60 </td>
   <td style="text-align:right;"> 402618.02 </td>
   <td style="text-align:right;"> 4.50 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -889.38 </td>
   <td style="text-align:right;"> 201.16 </td>
   <td style="text-align:right;"> -4.42 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 19.55 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.38 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.36 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-3)Fmort vs Time</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 12.73 </td>
   <td style="text-align:right;"> 2.78 </td>
   <td style="text-align:right;"> 4.57 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.01 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> -4.45 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 19.78 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.38 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.36 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

<!--chapter:end:01-time-trends.Rmd-->

## Physical indicators

### Cold pool index

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-5-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Warm core rings

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-8-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-9)Fmort vs Warm Core Rings
n</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.51 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 10.49 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.01 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> -3.47 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 12.06 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.27 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.25 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Marine heatwave index

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-11-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-12)Recruitment vs cumulative intensity
degrees C</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 52315.63 </td>
   <td style="text-align:right;"> 3391.65 </td>
   <td style="text-align:right;"> 15.42 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -42.06 </td>
   <td style="text-align:right;"> 19.35 </td>
   <td style="text-align:right;"> -2.17 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.73 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 28 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.11 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-12)Recruitment vs maximum intensity
degrees C</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 84882.20 </td>
   <td style="text-align:right;"> 17174.51 </td>
   <td style="text-align:right;"> 4.94 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -16430.84 </td>
   <td style="text-align:right;"> 7433.42 </td>
   <td style="text-align:right;"> -2.21 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.89 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 28 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### GLORYS bottom temperature

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-14-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Long-term sea surface temperature

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-17-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Sea surface temperature anomaly

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-20-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Spring offshore bottom temperature
Bluefish are typically found offshore in the spring.

### Fall onshore bottom temperature
Bluefish are typically found onshore in the fall.

### Stratification

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-23-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Winter wind speed

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-26-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-27)Fmort vs tke winter
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.79 </td>
   <td style="text-align:right;"> 0.14 </td>
   <td style="text-align:right;"> 5.65 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.62 </td>
   <td style="text-align:right;"> 0.20 </td>
   <td style="text-align:right;"> -3.17 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 10.04 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.21 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-27)Abundance vs total wind speed winter
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 45313.88 </td>
   <td style="text-align:right;"> 22718.38 </td>
   <td style="text-align:right;"> 1.99 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 19019.50 </td>
   <td style="text-align:right;"> 7099.74 </td>
   <td style="text-align:right;"> 2.68 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 7.18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.16 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Spring wind speed

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-29-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-30)Fmort vs tke spring
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.70 </td>
   <td style="text-align:right;"> 0.17 </td>
   <td style="text-align:right;"> 4.10 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -1.02 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> -2.06 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.23 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.09 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Summer wind speed

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-32-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-33)Catch vs hcly summer
m^2/sec^2</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> -22273.90 </td>
   <td style="text-align:right;"> 22809.43 </td>
   <td style="text-align:right;"> -0.98 </td>
   <td style="text-align:right;"> 0.34 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 786.09 </td>
   <td style="text-align:right;"> 325.46 </td>
   <td style="text-align:right;"> 2.42 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 5.83 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.13 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-33)Catch vs tke summer
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 107151.5 </td>
   <td style="text-align:right;"> 26995.45 </td>
   <td style="text-align:right;"> 3.97 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -254762.9 </td>
   <td style="text-align:right;"> 91851.25 </td>
   <td style="text-align:right;"> -2.77 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 7.69 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.19 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.17 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-33)Catch vs total wind speed summer
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 50583.43 </td>
   <td style="text-align:right;"> 6758.57 </td>
   <td style="text-align:right;"> 7.48 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -11754.86 </td>
   <td style="text-align:right;"> 4153.25 </td>
   <td style="text-align:right;"> -2.83 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 8.01 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.18 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-33)Fmort vs hcly summer
m^2/sec^2</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> -0.10 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> -0.65 </td>
   <td style="text-align:right;"> 0.52 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.01 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 2.97 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 8.84 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.19 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-33)Fmort vs tke summer
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.93 </td>
   <td style="text-align:right;"> 0.18 </td>
   <td style="text-align:right;"> 5.09 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -1.96 </td>
   <td style="text-align:right;"> 0.62 </td>
   <td style="text-align:right;"> -3.18 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 10.08 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.22 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-33)Fmort vs total wind speed summer
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 9.55 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.07 </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> -2.41 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 5.81 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.13 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Fall wind speed

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-35-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-36)Recruitment vs vwnd fall
J/kg</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 57747.24 </td>
   <td style="text-align:right;"> 6055.71 </td>
   <td style="text-align:right;"> 9.54 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 8618.42 </td>
   <td style="text-align:right;"> 4186.19 </td>
   <td style="text-align:right;"> 2.06 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 31 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.09 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Gulf Stream Index

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-38-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-39)Catch vs gulf stream index
latitude anomaly</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 26378.28 </td>
   <td style="text-align:right;"> 826.75 </td>
   <td style="text-align:right;"> 31.91 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -4143.45 </td>
   <td style="text-align:right;"> 1165.85 </td>
   <td style="text-align:right;"> -3.55 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 12.63 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.34 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.32 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-39)Abundance vs gulf stream index
latitude anomaly</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 101326.00 </td>
   <td style="text-align:right;"> 3012.08 </td>
   <td style="text-align:right;"> 33.64 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -10612.06 </td>
   <td style="text-align:right;"> 4247.52 </td>
   <td style="text-align:right;"> -2.50 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 6.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.17 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### North Atlantic Oscillation

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-41-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-42)Abundance vs north atlantic oscillation
unitless</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 108751.36 </td>
   <td style="text-align:right;"> 4425.43 </td>
   <td style="text-align:right;"> 24.57 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -3833.18 </td>
   <td style="text-align:right;"> 1853.57 </td>
   <td style="text-align:right;"> -2.07 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.28 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.09 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Chlorophyll

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-44-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

<!--chapter:end:02-physical-indicators.Rmd-->

## Trophic indicators

### Spring zooplankton abundance by species

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-47-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-48)Catch vs centropages zoo spring
log N m^-3</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 135087.98 </td>
   <td style="text-align:right;"> 42994.83 </td>
   <td style="text-align:right;"> 3.14 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -24919.68 </td>
   <td style="text-align:right;"> 10482.53 </td>
   <td style="text-align:right;"> -2.38 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 5.65 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-48)Catch vs temora zoo spring
log N m^-3</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 49100.27 </td>
   <td style="text-align:right;"> 7892.33 </td>
   <td style="text-align:right;"> 6.22 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -7310.29 </td>
   <td style="text-align:right;"> 3392.88 </td>
   <td style="text-align:right;"> -2.15 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.64 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-48)Fmort vs centropages zoo spring
log N m^-3</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.89 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 3.50 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.13 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> -2.15 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-48)Abundance vs temora zoo spring
log N m^-3</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 141683.71 </td>
   <td style="text-align:right;"> 13312.73 </td>
   <td style="text-align:right;"> 10.64 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -14869.74 </td>
   <td style="text-align:right;"> 5723.09 </td>
   <td style="text-align:right;"> -2.60 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 6.75 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.18 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Fall zooplankton abundance by species

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-50-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-51)Fmort vs pseudocalanus zoo fall
log N m^-3</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> 9.01 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.07 </td>
   <td style="text-align:right;"> 0.02 </td>
   <td style="text-align:right;"> 3.71 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 13.77 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 28 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.33 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.31 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Zooplankton abundance by group

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-53-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-54)Catch vs Euphausiacea
Absolute Number of Individuals</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 41295.74 </td>
   <td style="text-align:right;"> 4445.28 </td>
   <td style="text-align:right;"> 9.29 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> -2.31 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 5.33 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-54)Fmort vs SmallCalanoida
Absolute Number of Individuals</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.29 </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> 8.86 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 2.06 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.09 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-54)Abundance vs Euphausiacea
Absolute Number of Individuals</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 122223.5 </td>
   <td style="text-align:right;"> 7570.34 </td>
   <td style="text-align:right;"> 16.15 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> -2.63 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 6.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.15 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-54)Abundance vs SmallCalanoida
Absolute Number of Individuals</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 129372.4 </td>
   <td style="text-align:right;"> 7291.97 </td>
   <td style="text-align:right;"> 17.74 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> -3.81 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 14.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.31 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.29 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Abundance of Calanus CV and adults

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-56-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-57)Abundance vs Calanus CV and adult</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 88057.70 </td>
   <td style="text-align:right;"> 7550.32 </td>
   <td style="text-align:right;"> 11.66 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 1.04 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 2.75 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 7.58 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 31 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.17 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Zooplankton abundance anomaly

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-59-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-60)Fmort vs small
Abundance anomaly unitless</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.02 </td>
   <td style="text-align:right;"> 21.80 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.11 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 2.22 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.93 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.13 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.11 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-60)Abundance vs small
Abundance anomaly unitless</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 104623.70 </td>
   <td style="text-align:right;"> 4103.24 </td>
   <td style="text-align:right;"> 25.50 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -25087.12 </td>
   <td style="text-align:right;"> 12187.37 </td>
   <td style="text-align:right;"> -2.06 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.09 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Zooplankton diversity index

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-62-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-63)Fmort vs Zoo_Shannon-Wiener_Diversity_index
Unitless</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.74 </td>
   <td style="text-align:right;"> 0.14 </td>
   <td style="text-align:right;"> 5.27 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.16 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> -2.80 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 7.81 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.17 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Small/large copepod anomaly

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-65-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-66)Abundance vs Sm-Lg copepod anom
Abundance anomaly unitless</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 105639.1 </td>
   <td style="text-align:right;"> 3857.85 </td>
   <td style="text-align:right;"> 27.38 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -21094.0 </td>
   <td style="text-align:right;"> 7106.17 </td>
   <td style="text-align:right;"> -2.97 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 8.81 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.19 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Spring ichthyoplankton diversity

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-68-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-69)Fmort vs Number_Of_Species_Caught
Unitless</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0.07 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 1.65 </td>
   <td style="text-align:right;"> 0.14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.01 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 5.06 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 25.56 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.76 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.73 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Fall ichthyoplankton diversity

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-71-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Forage fish abundance

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-74-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-75)Catch vs Forage_Lower</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 25921.79 </td>
   <td style="text-align:right;"> 1388.95 </td>
   <td style="text-align:right;"> 18.66 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -6375.72 </td>
   <td style="text-align:right;"> 2958.52 </td>
   <td style="text-align:right;"> -2.16 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.64 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.17 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-75)Catch vs Forage_Mean</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 27454.46 </td>
   <td style="text-align:right;"> 1141.77 </td>
   <td style="text-align:right;"> 24.05 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -6821.80 </td>
   <td style="text-align:right;"> 2881.81 </td>
   <td style="text-align:right;"> -2.37 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 5.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.2 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-75)Catch vs Forage_Upper</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 29167.23 </td>
   <td style="text-align:right;"> 1285.33 </td>
   <td style="text-align:right;"> 22.69 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -7113.19 </td>
   <td style="text-align:right;"> 2782.99 </td>
   <td style="text-align:right;"> -2.56 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 6.53 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.28 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.24 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-75)Abundance vs Forage_Upper</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 112357.21 </td>
   <td style="text-align:right;"> 3142.75 </td>
   <td style="text-align:right;"> 35.75 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -14739.45 </td>
   <td style="text-align:right;"> 6804.69 </td>
   <td style="text-align:right;"> -2.17 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.69 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.17 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Species distribution

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-77-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-78)Catch vs along-shelf distance
km</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 286566.45 </td>
   <td style="text-align:right;"> 73110.2 </td>
   <td style="text-align:right;"> 3.92 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -301.72 </td>
   <td style="text-align:right;"> 86.8 </td>
   <td style="text-align:right;"> -3.48 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 12.08 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.27 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.25 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-78)Catch vs Latitude
degreesN</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 1748889.20 </td>
   <td style="text-align:right;"> 512764.27 </td>
   <td style="text-align:right;"> 3.41 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -42323.45 </td>
   <td style="text-align:right;"> 12644.11 </td>
   <td style="text-align:right;"> -3.35 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 11.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.24 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-78)Catch vs Longitude
degreesW</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> -2650990.32 </td>
   <td style="text-align:right;"> 793028.25 </td>
   <td style="text-align:right;"> -3.34 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -38010.96 </td>
   <td style="text-align:right;"> 11232.85 </td>
   <td style="text-align:right;"> -3.38 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 11.45 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.26 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.24 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-78)Fmort vs along-shelf distance
km</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 1.87 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 3.52 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> -2.86 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 8.18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.18 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-78)Fmort vs Latitude
degreesN</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 9.59 </td>
   <td style="text-align:right;"> 3.79 </td>
   <td style="text-align:right;"> 2.53 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.23 </td>
   <td style="text-align:right;"> 0.09 </td>
   <td style="text-align:right;"> -2.44 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 5.94 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.16 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.13 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-78)Fmort vs Longitude
degreesW</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> -17.47 </td>
   <td style="text-align:right;"> 5.58 </td>
   <td style="text-align:right;"> -3.13 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> -0.25 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> -3.20 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 10.21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.22 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

<!--chapter:end:03-trophic-indicators.Rmd-->

## Larvae and YOY indicators

### Recruitment

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-80-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-81)Recruitment vs Recruitment</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6.180000e+00 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 9.942338e+15 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 9.88500805510043e+31 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Larval growth

<!--chapter:end:04-larvae-YOY.Rmd-->

## Juvenile indicators

### Length-age curves

### Condition

### CPUE

<!--chapter:end:05-juvenile.Rmd-->

## Adult indicators

### Size of spawning stock

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-83-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}

<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-84)Catch vs Abundance</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> -6959.50 </td>
   <td style="text-align:right;"> 8331.64 </td>
   <td style="text-align:right;"> -0.84 </td>
   <td style="text-align:right;"> 0.41 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 4.87 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 23.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 0.43 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 0.41 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->



<!-- -->

<table class="kable_wrapper">
<caption>(\#tab:unnamed-chunk-84)Abundance vs Abundance</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Std. Error </th>
   <th style="text-align:right;"> t value </th>
   <th style="text-align:right;"> Pr(&gt;|t|) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -1.288000e+01 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6.975294e+16 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> F-statistic </td>
   <td style="text-align:left;"> 4.86547320610076e+33 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> df </td>
   <td style="text-align:left;"> 1, 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-adj </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>


<!-- -->

### Mean age of spawning stock

### Age distribution

### Length-age curves

### Condition

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-86-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Stomach fullness

#### Figures {-}
<img src="bluefish-esp_files/figure-html/unnamed-chunk-89-1.png" width="768" style="display: block; margin: auto;" />

#### Regression statistics {-}
[1] "No statistically significant results"

### Center of gravity and area occupied

<!--chapter:end:06-adult.Rmd-->

## Socioeconomic indicators

### CPUE by catch strategy

<!--chapter:end:07-socioeconomic.Rmd-->

