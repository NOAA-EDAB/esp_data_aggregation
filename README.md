# Ecosystem and Socioeconomic Profiles

## View current data products
https://NOAA-EDAB.github.io/esp_data_aggregation/index

## Introduction
Ecosystem and Socioeconomic Profiles (ESPs) are a scientific product to support [Integrated Ecosystem Assessment](https://www.integratedecosystemassessment.noaa.gov/) (IEA). IEA seeks to improve understanding and management of fisheries through incorporating natural, social, and economic data into fisheries analyses and management plans. ESPs are a structured framework developed by the Alaska Science Center to integrate ecosystem and socioeconomic information into the stock assessment process.<sup>[1]</sup>


Here we adapt the ESP process for use in the management of Northeast stocks. Our scientific roadmap consists of these steps:
1. Gather existing data on ecology, biology, socioeconomics, and the human dimension of Northeast fisheries.
2. Conduct a risk analysis of Northeast stocks to determine which stocks are most vulnerable.
3. Create a detailed report for the most vulnerable stocks, incorporating data from the originial risk assessment as well as detailed species-specific information.

## Running a report
The current preliminary report pulls data from many existing sources and creates several data visualizations. Reports for all northeast stocks have been compiled and can be viewed [here](https://NOAA-EDAB.github.io/esp_data_aggregation/index). 

To create a report, download the repo and run the file `R/get_full_report.R` with the common name of your species of interest specified in sentence case (ex, "Acadian redfish". Functions used for data analysis and visualization can be viewed in the `R/full_report_functions` folder. The report template is the file `R/full_report_template.Rmd`.

## Next steps
We continue to synthesize existing data on Northeast stocks, environment, and socioeconomics. We are currently refining our data analyses and beginning the preliminary risk assessment process. 

[1]: https://meetings.npfmc.org/CommentReview/DownloadFile?p=8f5233fb-3b62-4571-9b49-8bb7ce675916.pdf&fileName=ESP_Shotwell.pdf
---
This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
