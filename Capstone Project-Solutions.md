# Cyclistic Case Study using SQL and Tableau
#### Prepared by: Edward Aguilar

## Introduction
This project serves as the culminating assignment for my Google Data Analytics course, focusing on utilizing SQL and Tableau. Within this case study, I will simulate the responsibilities of a junior data analyst at Cyclistic, a fictional company. By adhering to the data analysis process stages of **Ask, Prepare, Process, Analyze, Share, and Act**, I aim to address crucial business inquiries and generate actionable insights.

## Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations. 

## Ask
### Business Task
My manager has assigned me a specific responsibility of examining the contrasting usage patterns between annual members and casual riders of Cyclistic bikes. Additionally, I am responsible for devising strategies to convert casual riders into annual members.

## Prepare
### Data Source
I will use Cyclistic’s historical trip data to analyze and identify trends from January 2022 to December 2022 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).  

All personally identifiable information have been removed.  The data consists of 12 CSV files of long format data, ranging from January 2022 through December 2022. Each file consists of 13 columns:
ride_id,  rideable_type,  started_at,  ended_at,  start_station_name,  start_station_id,  end_station_name,  end_station_id,  start_lat,  start_lng,  end_lat,  end_lng,  member_casual. 

## Process
BigQuery is employed to merge multiple datasets into a single dataset and perform data cleansing tasks. This decision is driven by the limitations of Microsoft Excel, which can only handle up to 1,048,576 rows per worksheet, making it inadequate for managing extensive data sets. Given that the Cyclistic dataset exceeds 5.6 million rows, utilizing a platform such as BigQuery becomes imperative due to its capability to handle large data volumes effectively.
### Combining Data
SQL Query: [Combining Data](https://github.com/edjohna/Cyclistic/blob/main/Combining%20Data.sql) 

12 csv files are uploaded as tables in the 'cyclistic.bike.data' dataset. I then used the UNION ALL operator to combine all the files into one table, titled "combined_data". The table contains 5,667,717 rows. 
### Checking Data Types and Omitting Duplicates
SQL Query: [Checking Data Types and Duplicates](https://github.com/edjohna/Cyclistic/blob/main/2.%20Checking%20Data%20Types%20and%20Duplicates.sql)

In the data analysis process, several checks and evaluations were performed. Firstly, the data type of each column was examined. Additionally, the count of null values in each column was determined, starting with the ride_id column, but substituting it with other column names for further analysis. Duplicate rides were checked, with none found. The length of the ride_id string was also verified to ensure it consistently contained 16 characters. Furthermore, the most frequently used type of bike was identified. 

Subsequently, a new table was created, incorporating the minutes, day of the week, and month of the year. This new table was then tested. During the testing, the minimum, maximum, and average values were assessed. It was discovered that negative values and excessively long ride durations beyond a day were present, indicating errors that needed to be excluded. To address these data inaccuracies, filtering techniques will be employed to exclude rows with negative ride lengths and rides exceeding a day's duration, as deleting rows is not feasible in the free version of BigQuery.
### Exploring and Analyzing Data
SQL Query: [Exploring and Analyzing Data](https://github.com/edjohna/Cyclistic/blob/main/3.%20Exploring%20and%20Analyzing%20Data.sql)

Various analyses were conducted to derive meaningful insights from the data. This involved examining the mean, lowest, and highest ride durations while excluding inaccurate data. Average ride lengths were calculated for both members and casual riders, followed by determining the average ride length for each day of the week for both groups. Additionally, the average ride length by month was determined for members and casual riders. The total number of rides taken by members and casual riders was also evaluated. Furthermore, the count of rides taken on each day of the week for each group and the count of rides taken by each group in each month were determined. To analyze ride patterns throughout the day, the number of rides taken during each hour was analyzed separately for members and casual riders. 

To ensure clarity in data filtering within Tableau, the "day_of_week" column was modified to display weekdays as "Monday" through "Friday" instead of numerical values. The most popular start and end stations were identified for both member and casual riders. Results from each analysis were saved as new tables, enabling the joining of tables to obtain a comprehensive count of how often members and casual riders started or ended their rides at each station. Finally, the total number of visits to each station was calculated for members and casual riders.

## Analyze and Share
To access the dashboard, kindly click on the following link: [Tableau](https://public.tableau.com/views/CyclisticDashboard_16892138256590/RidesTakenperMonth?:language=en-US&:display_count=n&:origin=viz_share_link)

<img src= "https://raw.githubusercontent.com/edjohna/Cyclistic/d22ff3d3755342684a543dd3c0a4ef35e0252353/Tableau/Trips%20Taken%20by%20Bike%20Type.png" width="800">
Based on the displayed pie chart, electric bikes emerge as the most popular bike type, with approximately 2.8 million rides recorded. Regular bikes follow closely behind with around 2.6 million rides.
<img src= "https://raw.githubusercontent.com/edjohna/Cyclistic/d22ff3d3755342684a543dd3c0a4ef35e0252353/Tableau/Avg%20Ride%20Length%20Per%20Day.png" width="600">
Upon analyzing the average ride length per day for casual riders and annual members, it becomes apparent that, on average, casual riders tend to have longer rides compared to annual members.
<img src= "https://raw.githubusercontent.com/edjohna/Cyclistic/d22ff3d3755342684a543dd3c0a4ef35e0252353/Tableau/Rides%20Taken%20by%20Day.png" width="600">
Based on the chart, a notable trend is observed. Annual members exhibit higher ride frequencies on weekdays compared to weekends. Conversely, casual riders display the opposite pattern, with the highest ride frequencies occurring on weekends.
<img src= "https://raw.githubusercontent.com/edjohna/Cyclistic/d22ff3d3755342684a543dd3c0a4ef35e0252353/Tableau/Rides%20Taken%20per%20Month.png" width="800">
When examining the rides taken per month, a similar pattern emerges for both annual members and casual riders. The data reveals that there is a higher number of rides during the warmer months compared to the colder months of the year. Specifically, August records the highest number of rides for annual members, while July takes the lead as the month with the highest number of rides for casual riders.
<img src= "https://raw.githubusercontent.com/edjohna/Cyclistic/d22ff3d3755342684a543dd3c0a4ef35e0252353/Tableau/Rides%20Per%20Hour.png" width="600">
A consistent trend is observed when analyzing the riding patterns of both annual members and casual riders. Both groups exhibit peak ridership between 4 pm and 6 pm, with 5 pm being the hour with the highest number of rides. This suggests a shared preference for biking during late afternoon hours among both annual members and casual riders.

## Act
### Conclusion
In conclusion, the analysis of the data reveals interesting insights about the bike usage patterns. Electric bikes emerge as the most popular bike type, with regular bikes following closely behind. Casual riders tend to have longer rides on average compared to annual members. Moreover, annual members demonstrate higher ride frequencies on weekdays, while casual riders display higher ride frequencies on weekends. There is a consistent trend of higher ride counts during the warmer months, with August being the peak month for annual members and July for casual riders. Additionally, both groups exhibit peak ridership between 4 pm and 6 pm, with 5 pm recording the highest number of rides. These findings suggest a shared preference for biking during the late afternoon among both annual members and casual riders.
### Recommendations
To convert casual riders into annual members, here are my recommendations:
1. Offer Trial Memberships: Provide short-term trial memberships at a discounted rate or with additional perks to allow casual riders to experience the benefits of being an annual member.
2. Improve User Experience: Continuously enhance the user experience for annual members, ensuring that they have a seamless and enjoyable riding experience. This includes convenient booking processes, reliable bikes, and excellent customer support.
3. Target Seasonal Riders: Identify casual riders who use the service frequently during peak seasons and offer targeted promotions or discounted rates to encourage them to become annual members.
4. Incentivize Long-Term Commitment: Create incentives for long-term commitment, such as offering discounted rates for multi-year memberships or rewarding loyal members with exclusive rewards and privileges.
5. Gather Feedback and Adapt: Continuously seek feedback from casual riders who have become annual members to understand their needs and preferences better. Adapt membership offerings and benefits accordingly to improve the conversion rate and retention of casual riders as annual members.

By implementing these recommendations, it is possible to attract more casual riders and successfully convert them into loyal annual members, ultimately growing the customer base and promoting long-term engagement with the bike-sharing service.
