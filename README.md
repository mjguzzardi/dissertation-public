# Overview and information for this repository

This is a repository to supplement the MSc dissertation: "*Convenience, technology, and urban mobility: quantifying the effect of user-friendly public bike system improvements on Citi Bike ridership*"

All code is in R and will either be in a .Rmd file format (R Markdown) or in a .R file format if it is a smaller script.

**Note**: Some files have duplicative code or variables, so it is best to run entire files rather than switching between files in the same environment, just in case it overwrites certain variables. The duplicative code is often to include a new variable from the source data (and sometimes for prioritizing time rather than perfection).

## Files needed and file summaries

The file named: `dissertation_supplement_core` will contain the primary code for replicating the following:
* Loading csv data (bike trips, weather)
  * System data from Indego and Citi Bike
  * Weather data from NOAA     
* Produce charts for visually checking for parallel trends (Figures 1 and 6)
* Running regressions (Adapted from Equations 1 and 2) to output Tables 5 and 3
  * Including code that produces a simplified table for copy-pasting into a Word document

The following files are also needed:
* `bike_station_analysis`
  * This script produces a csv that is loaded in the main file, `dissertation_supplement_core`, and therefore the underlying code for our `Station Count` variable
* `event_study`
  * This script produces the event study regression (Equation 3 and Table 4) that is found in our robustness checks
* `summary_stats_rmd`
  * This script produces the following summary data tables:
    * Table 1 (public bike data)
    * Table 2 (weather data)
  
## Downloading source data

### Public Bicycle Data

**Lyft/Citi Bike**

* Navigate to the Citi Bike System Data website here: https://citibikenyc.com/system-data
* Click into the downloadable files to access s3 buckets: https://s3.amazonaws.com/tripdata/index.html
* Download all zip files for 2019
* Load csv files into R where specified (make sure to reference the correct file path for where you saved them)

**Indego**

* Navigate to the Indego Bike System Data website here: https://www.rideindego.com/about/data/
* Download Q1-Q4 2019 files
* Load csv files into R where specified (make sure to reference the correct file path for where you saved them)

### Weather data

* Navigate to NOAA weather station data center here: https://www.ncdc.noaa.gov/cdo-web/datatools/findstation
* Acquire NYC weather data
  * Search the weather station for New York City, `JFK Airport, New York, NY, USA`
  * Select `Daily Summaries`
  * Select all days of 2019
  * Add the weather station data to your cart
  * Select csv file type
  * Select all data types (precipitation, air temperature, wind, weather type)
  * Input email address and submit the order
* Acquire Philadelphia weather data
  * Search the weather station for Philadelphia, `PHILADELPHIA FRANKLIN INSTITUTE, PA US`
  * Select `Daily Summaries`
  * Select all days of 2019
  * Add the weather station data to your cart
  * Select csv file type
  * Select all data types (precipitation, air temperature, wind, weather type)
  * Input email address and submit the order
