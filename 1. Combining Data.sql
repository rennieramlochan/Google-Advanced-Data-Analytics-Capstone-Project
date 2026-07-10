-- After importing the 12 files as tables, I merged them all into one single table for ease of use.

CREATE TABLE `cyclistic_bike_data.combined_data` AS (
  SELECT * 
  FROM `cyclistic_bike_data.202201-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202202-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202203-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202204-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202205-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202206-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202207-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202208-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202209-divvy-publictripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202210-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202211-divvy-tripdata` 
  UNION ALL
  SELECT * 
  FROM `cyclistic_bike_data.202212-divvy-tripdata`
)

-- Count the number of rows in our new table (5,667,717 rows)

SELECT
  COUNT(*)
FROM
  `cyclistic_bike_data.combined_data`
