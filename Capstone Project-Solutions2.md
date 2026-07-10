# Google Data Analytics Capstone Project

## Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations.

To complete my analysis, I will be following the steps of the data analysis process: **ask**, **prepare**, **process**, **analyze**, **share**, and **act**.

## Ask

#### Clear Statement of the Business Task:
Analyze Cyclistic trip data to understand how casual riders and annual members use Cyclistic bikes differently. Provide these insights to the marketing team to help develop a strategy to convert more casual riders into annual members.

## Prepare

#### Description of All Data Sources Used:
Public data provided by Divvy Bikes and is available [here](https://divvy-tripdata.s3.amazonaws.com/index.html).

## Process

#### Documentation of Any Cleaning or Manipulation of Data:
1. Downloaded 12 months of data ranging from 2022/03 - 2023/02.
2. Converted the .csv files to .xlxs to begin data cleanup in Microsoft Excel.
3. Filtred all columns to search for and remove rows with missing or corrupt data.
4. Created a new column labelled `ride_length` that would calculate the time each ride took by subtracting the `started_at` column from the `ended_at` column and formatted the time as HH:MM:SS.
5. Created another column labelled `day_of_week` and used the WEEKDAY function to extract what day of the week each ride started on from the `started_at` column.

## Analyze

#### Summary of Analysis:
Uploaded my data to **BigQuery** to perform analysis using **SQL**. <br />

Ran the query below to combine all of my individual monthly tables into one and saved that resulting table as `combined_tripdata`.

```SQL
/* Created one large table that contains all of the data from 12 individual tables using FULL JOIN.
Each table shared the same columns and data types */
SELECT *
FROM
  `tripdata-project.tripdata.2022_03_tripdata`
FULL JOIN
  `tripdata-project.tripdata.2022_04_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_05_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  tart_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_06_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_07_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_08_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_09_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_10_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_11_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2022_12_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2023_01_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)
FULL JOIN
  `tripdata-project.tripdata.2023_02_tripdata`
USING
  (ride_id, started_at, rideable_type, ended_at, start_station_name, 
  start_station_id, member_casual, ride_length, day_of_week)

ORDER BY
  started_at ASC
```

Then I ran my next query on the `combined_tripdata` table to find the average minutes that each type of user rode each type of bike. Saved the query results as a new table named `avg_minutes`.

```SQL
/* ride_length is typed as a time expression so I had to extract each part of the HH:MM:SS into seperate numeric 
variables, find the average of each part, round that average, and then concatonate each part back into 
the HH:MM:SS format */
SELECT 
  rideable_type,
  member_casual AS user_type, 
  CONCAT(ROUND(AVG(EXTRACT(HOUR FROM ride_length))), ":", 
    ROUND(AVG(EXTRACT(MINUTE FROM ride_length))), ":", 
    ROUND(AVG(EXTRACT(SECOND FROM ride_length)))) AS avg_ride_length,
  --created the avg_minutes column to get minutes as a FLOAT datatype
  ROUND(AVG(EXTRACT(MINUTE FROM ride_length))) AS avg_minutes
FROM 
  `tripdata-project.tripdata.combined_tripdata`

-- grouped by both rideable_type and member_casual to find the average time for each category
GROUP BY
  rideable_type,
  member_casual
```

**`avg_minutes` Table**

| rideable_type | user_type | avg_ride_length | avg_minutes |
|---------------|-----------|-----------------|-------------|
|electric_bike  | casual    | 0:13:29         | 13.0        |
|electric_bike  | member    | 0:10:29         | 10.0        |
|classic_bike   | member    | 0:12:29         | 12.0        |
|classic_bike   | casual    | 0:17:29         | 17.0        |
|docked_bike    | casual    | 0:24:29         | 24.0        |

Proceeded to run another query on the `combined_tripdata` table to find the average amount of minutes users rode bikes on each day of the week. Saved the results as a new table named `avg_minutes_per_day`.

```SQL
/* ride_length is typed as a time expression so I had to extract each part of the HH:MM:SS into seperate numeric 
variables, find the average of each part, round that average, and then concatonate each part back into 
the HH:MM:SS format */
SELECT 
  CONCAT(ROUND(AVG(EXTRACT(HOUR FROM ride_length))), ":", 
    ROUND(AVG(EXTRACT(MINUTE FROM ride_length))), ":", 
    ROUND(AVG(EXTRACT(SECOND FROM ride_length)))) AS avg_ride_length,
  --created the avg_minutes column to get minutes as a FLOAT datatype
  ROUND(AVG(EXTRACT(MINUTE FROM ride_length))) AS avg_minutes,
  day_of_week
FROM 
  `tripdata-project.tripdata.combined_tripdata`

-- grouped by day_of_week to find the avg_ride_length for each day of the week
GROUP BY
  day_of_week
```

**`avg_minutes_per_day` Table**

avg_ride_length | avg_minutes | day_of_week
----------------|-------------|------------
0:12:29         | 12.0        | Tuesday
0:12:29         | 12.0        | Wednesday
0:12:29         | 12.0        | Thursday
0:13:29         | 13.0        | Friday
0:15:29         | 15.0        | Saturday
0:15:29         | 15.0        | Sunday
0:12:29         | 12.0        | Monday

## Share

#### Supporting Visualizations and Key Findings:
To share my results, I created two visualizations by exporting my `avg_minutes` and `avg_minutes_per_day` tables and uploading them to **Tableau Public**. 

<div class='tableauPlaceholder' id='viz1681327933625' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Co&#47;ComparingCasualandMemberBikeUsage&#47;Sheet1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='ComparingCasualandMemberBikeUsage&#47;Sheet1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Co&#47;ComparingCasualandMemberBikeUsage&#47;Sheet1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

[Tableau Link](https://public.tableau.com/views/ComparingCasualandMemberBikeUsage/Sheet1?:language=en-US&:display_count=n&:origin=viz_share_link)

#### Key Findings:
1. The average ride time of both the classic and electrical bike types is higher for casual riders than annual members.
2. Both casual riders and annual members have a higher ride time on classic bikes.

<div class='tableauPlaceholder' id='viz1681328007923' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Av&#47;AverageRideTimeperDayoftheWeek&#47;Sheet1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='AverageRideTimeperDayoftheWeek&#47;Sheet1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Av&#47;AverageRideTimeperDayoftheWeek&#47;Sheet1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

[Tableau Link](https://public.tableau.com/views/AverageRideTimeperDayoftheWeek/Sheet1?:language=en-US&:display_count=n&:origin=viz_share_link)

#### Key Findings:
1. The average ride time is much higher on the weekends than the weekdays.
2. The average ride time is consistant thoughout both weekdays and weekends with the only outlier being Friday, which averages higher than the rest of the weekdays.

## Act

#### Top Three Recommendations Based on Your Analysis:
1. Casual riders tend to ride for more minutes on average so Cyclistic could advertise how much these casual riders would be able to save if they joined the annual membership. After the casual rider finishes their trip, the app could compare their current rates with the rates of annual members and offer a retroactive discount if they sign up immediately.
2. Riders use Cyclistic bikes for longer on the weekends. Cyclistic could offer a limited time deal to new annual members that offers free or greatly discounted weekends.
3. Classic bikes have a higher average use time than electric bikes for casual riders. Cyclistic could advertise a discounted rate for annual members who ride classic bikes.
