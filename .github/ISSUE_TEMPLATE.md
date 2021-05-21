---
title: Error in report creation {{ date | date('dddd, MMMM Do') }}
labels: bug
---

There is one or more error(s) in the `bookdown` folder on the branch: {{ env.GITHUB_REF }} .

Please check the [error logs](https://github.com/NOAA-EDAB/esp_data_aggregation/tree/main/logs) and resolve the error(s).

This message was automatically produced by the workflow: {{ env.GITHUB_WORKFLOW }} .
