# Ecosystem and Socioeconomic Profiles

![gitleaks](https://github.com/NOAA-EDAB/esp_data_aggregation/workflows/gitleaks/badge.svg)

## View current data products
https://noaa-edab.github.io/ESP_docs/docs

## Introduction
Ecosystem and Socioeconomic Profiles (ESPs) are a scientific product to support [Integrated Ecosystem Assessment](https://www.integratedecosystemassessment.noaa.gov/) (IEA). IEA seeks to improve understanding and management of fisheries through incorporating natural, social, and economic data into fisheries analyses and management plans. ESPs are a structured framework developed by the Alaska Science Center to integrate ecosystem and socioeconomic information into the stock assessment process.<sup>[1]</sup>

Here we adapt the ESP process for use in the management of Northeast stocks. Our scientific roadmap consists of these steps:
1. Gather existing data on ecology, biology, socioeconomics, and the human dimension of Northeast fisheries.
2. Conduct a risk analysis of Northeast stocks to determine which stocks are most vulnerable.
3. Create detailed reports for the most vulnerable stocks, incorporating data from the originial risk assessment as well as detailed species-specific information.

## Running a report
The current preliminary report pulls data from many existing sources and creates several data visualizations. Reports for all northeast stocks have been compiled and can be viewed [here](https://noaa-edab.github.io/ESP_docs/docs). We have recently aggregated our data, functions, and report templates into a preliminary R package that can be viewed on the [package branch](https://github.com/NOAA-EDAB/esp_data_aggregation/tree/package). The package can be downloaded locally in R with the command `devtools::install_github("NOAA-EDAB/esp_data_aggregation@package")`. A report can then be generated locally with the command `NEesp::render_ind_report("Acadian redfish")` (replace "Acadian redfish" with the name of species of interest). Please note, report generation will take some time (2+ minutes per species). These reports are a work in progress and should not be viewed as a final or complete product at this time. We do not guarantee that these reports are free from errors; please contact us if you notice any issues.

## Next steps
We continue to synthesize existing data on Northeast stocks, environment, and socioeconomics. We are currently refining our data analyses and beginning the preliminary risk assessment process. 

[1]: https://meetings.npfmc.org/CommentReview/DownloadFile?p=8f5233fb-3b62-4571-9b49-8bb7ce675916.pdf&fileName=ESP_Shotwell.pdf

## Developers

| [atyrell3](https://github.com/atyrell3)                                                         | [rtabandera](https://github.com/rtabandera)                                                                                                    |
|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| [![](https://avatars.githubusercontent.com/u/77738923?s=100&u=92e54f60ca179f3e41c1a3610fb3ecdb9e233434&v=4)](https://github.com/atyrell3) | [![](https://avatars.githubusercontent.com/u/64960823?s=100&u=ea5abeca602e43d461e964fe8283f703aef63c61&v=4)](https://github.com/rtabandera) |

#### Legal disclaimer

*This repository is a scientific product and is not official
communication of the National Oceanic and Atmospheric Administration, or
the United States Department of Commerce. All NOAA GitHub project code
is provided on an 'as is' basis and the user assumes responsibility for
its use. Any claims against the Department of Commerce or Department of
Commerce bureaus stemming from the use of this GitHub project will be
governed by all applicable Federal law. Any reference to specific
commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.*
