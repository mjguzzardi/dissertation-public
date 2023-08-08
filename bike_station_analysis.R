#######INDEGO##########

setwd("/Users/michaelguzzardi/Desktop/LSE/Dissertation/Data/indego/")

#load your indego data here
indego_trips_2019q1  <- read_csv('indego-trips-2019-q1.csv')
indego_trips_2019q2  <- read_csv('indego-trips-2019-q2.csv')
indego_trips_2019q3  <- read_csv('indego-trips-2019-q3.csv')
indego_trips_2019q4  <- read_csv('indego-trips-2019-q4.csv')



#subset data, and make sure to also include station columns
indego_trips_2019q1 <- subset(indego_trips_2019q1, select=c(start_time, start_station, end_station))
indego_trips_2019q2 <- subset(indego_trips_2019q2, select=c(start_time, start_station, end_station))
indego_trips_2019q3 <- subset(indego_trips_2019q3, select=c(start_time, start_station, end_station)) %>%
  mutate(start_time=as.Date(start_time,'%m/%d/%Y'))
indego_trips_2019q4 <- subset(indego_trips_2019q4, select=c(start_time, start_station, end_station))

#bind into one dataset
indego_trips_all <- rbind(indego_trips_2019q1,indego_trips_2019q2,indego_trips_2019q3,indego_trips_2019q4)

start_stations <- subset(indego_trips_all, select = c(start_time, start_station))
end_stations <- subset(indego_trips_all, select = c(start_time, end_station))

#rename columns to make row-binding the data possible
start_stations <- dplyr::rename(indego_trips_all,station=start_station) %>%
  select(start_time,station)
end_stations <- dplyr::rename(indego_trips_all,station=end_station) %>%
  select(start_time,station)

#row-bind the data
#we combine the station columns because we just need to know which stations are active in a given month
indego_trips_combined <- rbind(start_stations, end_stations)

#create a month column for each trip (we'll aggregate by month since station expansion is unlikely to vary much at the daily scale)
indego_trips_combined <- indego_trips_combined %>%
  # mutate(start_time_day=trunc(start_time, unit='days')) %>%
  mutate(start_time_month=trunc(start_time, unit='months')) %>%
  select(start_time_month, station)
  
#find all unique stations
indego_trips_combined <- unique(indego_trips_combined)

#export a CSV so that you don't have to re-run the above code every time you tweak your code (THIS IS LATER LOADED INTO THE MAIN FILE, "dissertation_supplement_core" AS A DATAFRAME)
write.csv(indego_trips_combined, "/Users/michaelguzzardi/Desktop/LSE/Dissertation/indego_trips_combined.csv", row.names=FALSE)

######################

#####CITI BIKE#######

setwd("/Users/michaelguzzardi/Desktop/LSE/Dissertation/Data/citi_bike/")

#import data csvs citi bike nyc
cb_trips_201901  <- read_csv('201901-citibike-tripdata.csv')
cb_trips_201902  <- read_csv('201902-citibike-tripdata.csv')
cb_trips_201903  <- read_csv('201903-citibike-tripdata.csv')
cb_trips_201904  <- read_csv('201904-citibike-tripdata.csv')
cb_trips_201905  <- read_csv('201905-citibike-tripdata.csv')
cb_trips_201906  <- read_csv('201906-citibike-tripdata.csv')
cb_trips_201907  <- read_csv('201907-citibike-tripdata.csv')
cb_trips_201908  <- read_csv('201908-citibike-tripdata.csv')
cb_trips_201909  <- read_csv('201909-citibike-tripdata.csv')
cb_trips_201910  <- read_csv('201910-citibike-tripdata.csv')
cb_trips_201911  <- read_csv('201911-citibike-tripdata.csv')
cb_trips_201912  <- read_csv('201912-citibike-tripdata.csv')

#select start time and station data in your dfs
cb_trips_201901 <- cb_trips_201901 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201902 <- cb_trips_201902 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201903 <- cb_trips_201903 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201904 <- cb_trips_201904 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201905 <- cb_trips_201905 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201906 <- cb_trips_201906 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201907 <- cb_trips_201907 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201908 <- cb_trips_201908 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201909 <- cb_trips_201909 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201910 <- cb_trips_201910 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201911 <- cb_trips_201911 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_201912 <- cb_trips_201912 %>%
  subset(select=c(starttime, `start station id`, `end station id`))

cb_trips_all <- rbind(cb_trips_201912,cb_trips_201911,cb_trips_201910,
                      cb_trips_201909,cb_trips_201908,cb_trips_201907,
                      cb_trips_201906,cb_trips_201905,cb_trips_201904,
                      cb_trips_201903,cb_trips_201902,cb_trips_201901)


start_stations_cb <- subset(cb_trips_all, select = c(starttime, `start station id`))
end_stations_cb <- subset(cb_trips_all, select = c(starttime, `end station id`))


start_stations_cb <- dplyr::rename(cb_trips_all,station_cb=`start station id`) %>%
  select(starttime,station_cb)
end_stations_cb <- dplyr::rename(cb_trips_all,station_cb=`end station id`) %>%
  select(starttime,station_cb)

#combine start and end stations together because we just need to know how many unique stations there are in a given month
cb_trips_combined <- rbind(start_stations_cb, end_stations_cb)


#round start time dates to the nearest day and month for agg purposes
cb_trips_combined <- cb_trips_combined %>%
  # mutate(starttime_day=trunc(starttime, unit='days')) %>%
  mutate(starttime_month=trunc(starttime, unit='months')) %>%
  select(starttime_month,station_cb) 

#find all unique stations (THIS TAKES A LONG TIME TO RUN)
cb_trips_combined <- unique(cb_trips_combined)

#export a CSV so that you don't have to re-run the above code every time you tweak your code (THIS IS LATER LOADED INTO THE MAIN FILE, "dissertation_supplement_core" AS A DATAFRAME)
write.csv(cb_trips_combined, "/Users/michaelguzzardi/Desktop/LSE/Dissertation/cb_trips_combined.csv", row.names=FALSE)
