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
<!--html_preserve--><div id="htmlwidget-7a2f88cb4b5cdfd42203" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7a2f88cb4b5cdfd42203">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"disabled\" style=\"vertical-align: top;\">\n    <div class=\"form-group\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"2005\" data-max=\"2019\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0.46\" data-max=\"1.12\" data-scale=\"2\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","extensions":["Scroller"],"data":[["Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast"],[2005,2007,2008,2009,2010,2011,2012,2013,2014,2015,2019],[0.71,0.95,1.05,1.11,1.06,0.95,0.9,0.86,0.84,0.78,0.46]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>Region<\/th>\n      <th>Year<\/th>\n      <th>B/Bmsy<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"search":{"regex":true},"deferRender":true,"scrollY":200,"scrollX":true,"scroller":true,"language":{"thousands":","},"columnDefs":[{"className":"dt-right","targets":[1,2]}],"order":[],"autoWidth":false,"orderClasses":false,"orderCellsTop":true}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
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
<!--html_preserve--><div id="htmlwidget-c37e075399b6f0808c51" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c37e075399b6f0808c51">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"disabled\" style=\"vertical-align: top;\">\n    <div class=\"form-group\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"2007\" data-max=\"2019\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0.51\" data-max=\"0.92\" data-scale=\"2\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","extensions":["Scroller"],"data":[["Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast","Atlantic Coast"],[2007,2008,2009,2010,2011,2012,2013,2014,2015,2019],[0.79,0.79,0.63,0.53,0.74,0.6,0.51,0.62,0.92,0.8]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>Region<\/th>\n      <th>Year<\/th>\n      <th>F/Fmsy<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"search":{"regex":true},"deferRender":true,"scrollY":200,"scrollX":true,"scroller":true,"language":{"thousands":","},"columnDefs":[{"className":"dt-right","targets":[1,2]}],"order":[],"autoWidth":false,"orderClasses":false,"orderCellsTop":true}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:ffmsy_data)Bluefish</p>
</div>

<!--chapter:end:21-ffmsy.Rmd-->

