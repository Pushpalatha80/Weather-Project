SELECT * FROM dbo.Weather_data;

---1.	Give the count of the minimum number of days for the time when temperature reduced

WITH diffs as (
SELECT Date, Temperature, Temperature-LAG(Temperature) OVER (ORDER BY (Date)) diff
FROM dbo.Weather_data)
SELECT MIN(diff) minimum_temp
FROM diffs

--2.	Find the temperature as Cold / hot by using the case and avg of values of the given data set
SELECT temperature,Date,CASE
WHEN (SELECT Avg(temperature) FROM dbo.Weather_data) <Temperature THEN 'Hot'
ELSE 'Cold'
END AS Season
FROM dbo.Weather_data


--3.	Can you check for all 4 consecutive days when the temperature was below 30 Fahrenheit
WITH diffa as
(
SELECT Date, Temperature, LAG(Temperature,1) OVER (ORDER BY Date DESC) second_cons_day, lag(Temperature,2) OVER (ORDER BY Date DESC) third_cons_day,
 LAG(Temperature,3) OVER (ORDER BY Date DESC) fourth_cons_day
FROM dbo.Weather_data

)
SELECT  *
FROM diffa
WHERE Temperature<30
AND second_cons_day<30
AND third_cons_day<30
AND fourth_cons_day<30
ORDER BY Date 


--4.	Can you find the maximum number of days for which temperature dropped

WITH diffs as (
SELECT Date, Temperature, Temperature-LAG(Temperature) OVER (ORDER BY (Date)) diff
FROM dbo.Weather_data)
SELECT MAX(diff) minimum_temp
FROM diffs


--5.	Can you find the average of average humidity from the dataset 



SELECT Year(Date), ROUND(AVG(Average_humidity_P),2) avg
FROM dbo.weather_data
GROUP BY Year(Date)
ORDER BY Year(Date)

--6.	Use the GROUP BY clause on the Date column and make a query to fetch details for average windspeed ( which is now windspeed done in task 3 )

SELECT YEAR(Date), ROUND(AVG(Average_windspeed_mph),2) avg
FROM dbo.weather_data
GROUP BY YEAR(Date)


--8.	If the maximum gust speed increases from 55mph, fetch the details for the next 4 days

WITH diffa as
(
SELECT Date, Maximum gust speed, LAG( Maximum gust speed,1) OVER (ORDER BY Date DESC) second_day, lag( Maximum_gust_speed_mph,2) OVER (ORDER BY Date DESC) Third_day,
 LAG( Maximum gust speed,3) OVER (ORDER BY Date DESC) Fourth_day
FROM dbo.weather_data

)
SELECT  top 1 *
FROM diffa
WHERE Maximum gust speed<30
AND second_day<30
AND Third_day<30
AND Fourth_day<30
ORDER BY Date 

WITH diffa as
(
SELECT Date, Maximum_gust_speed_mph, LAG( Maximum_gust_speed_mph,1) OVER (ORDER BY Date DESC) second_day, lag( Maximum_gust_speed_mph,2) OVER (ORDER BY Date DESC) Third_day,
 LAG( Maximum_gust_speed_mph,3) OVER (ORDER BY Date DESC) Fourth_day
FROM dbo.weather_data 

)
SELECT  top 1 *
FROM diffa
WHERE Maximum_gust_speed_mph<30
AND second_day<30
AND Third_day<30
AND Fourth_day<30
ORDER BY Date 



-- 9 Find the number of days when the temperature went below 0 degrees Celsius 
SELECT COUNT(Date) C
FROM dbo.weather_data
WHERE ((Temperature-32)*5/9)<0






----10.	 Create another table with a “Foreign key” relation with the existing given data set.

-- created table weatherdata1 to create foreign_key relation

ALTER TABLE Weather.weatherdata2
add constraint FK_Temperature
Foreign key (Temperature)
references Weather_data(Temperature)


SELECT Temperature FROM dbo.Weather_data
SELECT *FROM dbo.Weather_data

CREATE Table Weather1(id  int Primary key,Temperature DECIMAL(3,1) )
INSERT INTO Weather1 Values(1,33.1),(2,29.1),(3,52.1),(4,37.1),(5,46.5),(6,61.9),(7,6.1),(8,3.2),(9,12.4),(10,32.5);

SELECT *FROM dbo.Weather1

---10
ALTER TABLE dbo.Weather1
ADD CONSTRAINT Temp_fk
Foreign key (Temperature)
References dbo.weather_data(Temperature)

ALTER TABLE dbo.Weather_data2
ADD primary key(Date)

SELECT *FROM dbo.Weather_data2
WHERE Date is NULL
DELETE FROM dbo.Weather_data2  WHERE Date is NULL
















SELECT *FROM dbo.Weather1