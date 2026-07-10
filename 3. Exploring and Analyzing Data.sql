--Checking the mean, lowest, and highest ride durations, excluding any inaccurate data.

SELECT
AVG(ride_length_minutes) AS avg,
MIN(ride_length_minutes) AS min,
MAX(ride_length_minutes) AS max
FROM `cyclistic_bike_data.combined_data_new`
WHERE 
ride_length_minutes > 0
AND ride_length_minutes < 1440

--Avg: 16.3 minutes Min: .1 minutes Max: 1439.9 minutes

--Calculating the average ride length for members, casual riders.

SELECT AVG(ride_length_minutes)
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual= 'member'
  
--member avg: 12.4 minutes

SELECT AVG(ride_length_minutes)
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual= 'casual'
  
--casual avg: 21.9 minutes

--Next, I want to calculate the average ride length for each day of the week, for both members and causal riders. (1=Sunday, 7=Saturday)
--Member:
SELECT 
day_of_week,
AVG(ride_length_minutes) AS member_avg_ride_length
FROM `cyclistic_bike_data.combined_data_new`
WHERE member_casual= 'member'
AND ride_length_minutes > 0
AND ride_length_minutes < 1440
GROUP BY day_of_week
ORDER BY day_of_week

--Casual:
SELECT 
day_of_week,
AVG(ride_length_minutes) AS casual_avg_ride_length
FROM `cyclistic_bike_data.combined_data_new`
WHERE member_casual= 'casual'
AND ride_length_minutes > 0
AND ride_length_minutes < 1440
GROUP BY day_of_week
ORDER BY day_of_week

--Average ride length by month for members, then casual riders
--Member:
SELECT month,
AVG(ride_length_minutes) AS member_avg_ride_length
FROM `cyclistic_bike_data.combined_data_new`
WHERE member_casual= 'member'
AND ride_length_minutes > 0
AND ride_length_minutes < 1440
GROUP BY month
ORDER BY month

--Casual:
SELECT month,
AVG(ride_length_minutes) AS casual_avg_ride_length
FROM `cyclistic_bike_data.combined_data_new`
WHERE member_casual= 'casual'
AND ride_length_minutes > 0
AND ride_length_minutes < 1440
GROUP BY month
ORDER BY month

--Number of Rides¶
--How many rides were taken by members, and how many rides were taken by casual riders?

SELECT member_casual,
COUNT(*) AS rides_taken
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
GROUP BY member_casual

--How many rides were taken on each day of the week for each group?
--Member:
SELECT day_of_week,
COUNT(*) AS rides_taken_by_members
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual = 'member'
GROUP BY day_of_week
ORDER BY day_of_week

--Casual:
SELECT day_of_week,
COUNT(*) AS rides_taken_by_casual
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual = 'casual'
GROUP BY day_of_week
ORDER BY day_of_week

--How many rides were taken by each group in each month?
--Member:
SELECT month,
COUNT(*) AS rides_taken_by_member
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual = 'member'
GROUP BY month
ORDER BY month

--Casual:
SELECT month,
COUNT(*) AS rides_taken_by_casual
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual = 'casual'
GROUP BY month
ORDER BY month

--I would like to analyze the number of rides taken during each hour of the day for both members and casual riders. To ensure clarity when filtering by the day of the week in Tableau, I have modified the "day_of_week" column to display the days as "Monday" through "Friday" instead of using numerical values from 1 through 7. This adjustment will help avoid any confusion during the analysis process.

--Member:
SELECT CASE
            WHEN day_of_week = 1 THEN 'Sunday'
            WHEN day_of_week = 2 THEN 'Monday'
            WHEN day_of_week = 3 THEN 'Tuesday'
            WHEN day_of_week = 4 THEN 'Wednesday'
            WHEN day_of_week = 5 THEN 'Thursday'
            WHEN day_of_week = 6 THEN 'Friday'
            WHEN day_of_week = 7 THEN 'Saturday' END AS day_of_the_week,
            EXTRACT(hour FROM started_at) AS hour,
            COUNT(*) AS rides_taken
FROM `cyclistic_bike_data.combined_data_new`
WHERE member_casual = 'member'
            AND ride_length_minutes > 0
            AND ride_length_minutes < 1440
GROUP BY day_of_week, hour
ORDER BY day_of_week, hour
--Casual:
SELECT CASE
            WHEN day_of_week = 1 THEN 'Sunday'
            WHEN day_of_week = 2 THEN 'Monday'
            WHEN day_of_week = 3 THEN 'Tuesday'
            WHEN day_of_week = 4 THEN 'Wednesday'
            WHEN day_of_week = 5 THEN 'Thursday'
            WHEN day_of_week = 6 THEN 'Friday'
            WHEN day_of_week = 7 THEN 'Saturday' END AS day_of_the_week,
            EXTRACT(hour FROM started_at) AS hour,
            COUNT(*) AS rides_taken
FROM `cyclistic_bike_data.combined_data_new`
WHERE member_casual = 'casual'
            AND ride_length_minutes > 0
            AND ride_length_minutes < 1440
GROUP BY day_of_week, hour
ORDER BY day_of_week, hour

--Rideable Type¶
--Checking to see if there are differences in the type of vehicles chosen.
--Member:
SELECT rideable_type,
COUNT(*) AS member_rides
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual = 'member'
GROUP BY rideable_type

--Casual:
SELECT rideable_type,
COUNT(*) AS casual_rides
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes > 0
AND ride_length_minutes < 1440
AND member_casual = 'casual'
GROUP BY rideable_type

--Most Popular Locations¶
--Finding most popular start stations for members and casual riders
--Member:
SELECT start_station_name,
COUNT(*) AS number_of_member_rides
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes < 1440
AND ride_length_minutes > 0
AND member_casual = 'member'
AND start_station_name != 'null'
GROUP BY start_station_name
ORDER BY COUNT(*) DESC

--Casual:
SELECT start_station_name,
COUNT(*) AS number_of_casual_rides
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes < 1440
AND ride_length_minutes > 0
AND member_casual = 'casual'
AND start_station_name != 'null'
GROUP BY start_station_name
ORDER BY COUNT(*) DESC

--Finding the most popular end stations for members and casual riders
--Member:
SELECT end_station_name,
COUNT(*) AS number_of_member_rides
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes < 1440
AND ride_length_minutes > 0
AND member_casual = 'member'
AND end_station_name != 'null'
GROUP BY end_station_name
ORDER BY COUNT(*) DESC

--Casual:
SELECT end_station_name,
COUNT(*) AS number_of_casual_rides
FROM `cyclistic_bike_data.combined_data_new`
WHERE ride_length_minutes < 1440
AND ride_length_minutes > 0
AND member_casual = 'casual'
AND end_station_name != 'null'
GROUP BY end_station_name
ORDER BY COUNT(*) DESC

--I saved the results of each of these queries as new tables so I could join the tables to get a complete count of how many times members and casual riders started or ended at each station.

--Calculate the total number of visits to each station for members and casual riders
--Member:
SELECT
  s.start_station_name AS station_name,
  s.number_of_member_rides + e.number_of_member_rides AS total_member_visits
FROM
  `cyclistic-bike-proj-capstone.cyclistic_bike_data.start_station_count_members` AS s
JOIN
  `cyclistic-bike-proj-capstone.cyclistic_bike_data.end_station_count_members` AS e
ON s.start_station_name = e.end_station_name
ORDER BY
  total_member_visits DESC;

--Casual:
SELECT
  s.start_station_name AS station_name,
  s.number_of_casual_rides + e.number_of_casual_rides AS total_casual_visits
FROM
  `cyclistic-bike-proj-capstone.cyclistic_bike_data.start_station_count_casual` AS s
JOIN
  `cyclistic-bike-proj-capstone.cyclistic_bike_data.end_station_count_casual` AS e
ON s.start_station_name = e.end_station_name
ORDER BY
  total_casual_visits DESC;
