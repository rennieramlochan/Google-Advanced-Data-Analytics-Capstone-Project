-- Check the data type of each column.

SELECT column_name, data_type
FROM `cyclistic-bike-proj-capstone.cyclistic_bike_data`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'combined_data'


-- To determine the count of null values in each column of a table, where the initial column is ride_id, you can substitute ride_id with the desired column name to examine other columns.

SELECT COUNTIF(ride_id IS NULL) AS null_count
FROM `cyclistic_bike_data.combined_data`

--I check to see if there are duplicate rides. There are none. 

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM `cyclistic_bike_data.combined_data`;

--To make sure each ride_id value really is 16 characters, I check the length of the string.

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM `cyclistic_bike_data.combined_data`
GROUP BY length_ride_id;

-- We check to see the most used type of bike. 
SELECT DISTINCT rideable_type, COUNT(rideable_type) AS no_of_trips
FROM `cyclistic_bike_data.combined_data`
GROUP BY rideable_type;

-- Create a new table with the number of minutes, day of the week and month of the year

CREATE TABLE `cyclistic_bike_data.combined_data_new` AS ( 
SELECT 
ride_id, rideable_type, started_at, ended_at,
ROUND(TIMESTAMP_DIFF(ended_at, started_at, second)/60,1) AS ride_length_minutes,
EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
EXTRACT(MONTH FROM started_at) AS month,
start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM `cyclistic_bike_data.combined_data`
)

-- Now we test our new table. We check the minimum, maximum and average of our data.

SELECT AVG(ride_length_minutes) AS avg,
MIN(ride_length_minutes) AS min,
MAX(ride_length_minutes) AS max
FROM `cyclistic_bike_data.combined_data_new`

--The minimum value shows a negative value and the maximum values shows a ride that took more than a day. Clearly these are wrong and should be omitted from our table. 

SELECT COUNT(*) as negative_ride_lengths
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes < 0
--96 rides with negative ride length

SELECT COUNT(*) AS rides_longer_than_24h
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 1440
--5360 rides that lasted for more than a day

--To address data inaccuracies, I will apply filters to exclude negative ride lengths and rides exceeding a day's duration, as these are likely errors. Typically, I would delete these rows from the dataset, but due to the limitations of the free version of BigQuery, row deletion is not possible. Therefore, I will utilize filtering techniques to exclude these erroneous entries from the dataset.
