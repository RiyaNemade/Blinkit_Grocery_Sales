DROP TABLE IF EXISTS blinkit_data;

CREATE TABLE blinkit_data(
Item_Fat_Content VARCHAR(10),	
Item_Identifier	VARCHAR(20),
Item_Type 	VARCHAR(30),
Outlet_Establishment_Year INT,
Outlet_Identifier VARCHAR(30),
Outlet_Location_Type VARCHAR(30),	
Outlet_Size VARCHAR(30),	
Outlet_Type VARCHAR(30),	
Item_Visibility	NUMERIC(10,2),
Item_Weight	NUMERIC(10,2),
Sales NUMERIC(10,2),	
Rating NUMERIC(10,2)
);

SELECT * FROM blinkit_data;

--Data cleaning
UPDATE blinkit_data
SET item_fat_content = 'Low Fat'
WHERE item_fat_content='LF';

UPDATE blinkit_data
SET item_fat_content = 'Low Fat'
WHERE item_fat_content='low fat';

UPDATE blinkit_data
SET item_fat_content = 'Regular'
WHERE item_fat_content='reg';

--Total Sales

SELECT SUM(sales)
FROM blinkit_data;

--Average Sales

SELECT ROUND(AVG(sales),2)
FROM blinkit_data;

--Number of items

SELECT COUNT(*) AS no_of_items
FROM blinkit_data;

--Average Rating

SELECT ROUND(AVG(rating),2)
FROM blinkit_data;

SELECT * FROM blinkit_data;

--Total Sales by Fat Content

SELECT item_fat_content,
		SUM(sales) AS total_sales,
		ROUND(AVG(sales),2) AS avg_sales,
		COUNT(*) AS no_of_items,
		ROUND(AVG(rating),2) AS avg_rating
FROM blinkit_data
GROUP BY item_fat_content;

SELECT SUM(sales) AS total_sales
FROM blinkit_data
WHERE item_fat_content = 'Low Fat'
GROUP BY outlet_type;

--Total Sales by Item Type

SELECT item_type,
		SUM(sales) AS total_sales,
		ROUND(AVG(sales),2) AS avg_sales,
		COUNT(*) AS no_of_items,
		ROUND(AVG(rating),2) AS avg_rating
FROM blinkit_data
GROUP BY item_type
ORDER BY total_sales DESC
LIMIT 5;

SELECT * FROM blinkit_data;

--Fat Content by Outlet for Total Sales

SELECT outlet_location_type,item_fat_content,
		SUM(sales) AS total_sales,
		ROUND(AVG(sales),2) AS avg_sales,
		COUNT(*) AS no_of_items,
		ROUND(AVG(rating),2) AS avg_rating
FROM blinkit_data
GROUP BY outlet_location_type,item_fat_content
ORDER BY total_sales DESC

SELECT outlet_location_type,item_fat_content,
		SUM(sales) AS total_sales
FROM blinkit_data
GROUP BY outlet_location_type,item_fat_content
ORDER BY total_sales DESC


--Total Sales by Outlet Established

SELECT outlet_establishment_year,
		SUM(sales) AS total_sales,
		ROUND(AVG(sales),2) AS avg_sales,
		COUNT(*) AS no_of_items,
		ROUND(AVG(rating),2) AS avg_rating
FROM blinkit_data
GROUP BY outlet_establishment_year
ORDER BY total_sales DESC;

--Percentage of Sales by Outlet Size
SELECT outlet_size
		CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
		CAST((SUM(total_sales)*100/SUM(SUM(total_sales)) OVER()) AS DECIMAL(10,2)) AS sales_per
FROM blinkit_data
GROUP BY outlet_size

SELECT outlet_size,SUM(sales)
FROM blinkit_data
GROUP BY outlet_size

SELECT outlet_size,
	SUM(sales) AS total_sales,
	SUM(total_sales)/(SUM(total_sales))*100 AS sales_percentage
FROM blinkit_data
GROUP BY outlet_size



SELECT * FROM blinkit_data;

--Sales by Outlet Location
SELECT outlet_location_type,SUM(sales) AS total_sales
FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY total_sales DESC;


--All Metrics by Outlet Type
--Total Sales by Outlet Type
SELECT outlet_type,SUM(sales) AS total_sales
FROM blinkit_data
GROUP BY outlet_type
ORDER BY total_sales DESC;



--Average Sales by Outlet Type

SELECT outlet_type,ROUND(AVG(sales),2) AS avg_sales
FROM blinkit_data
GROUP BY outlet_type
ORDER BY avg_sales DESC;

--Number of items by Outlet Type

SELECT outlet_type,COUNT(item_identifier) AS no_of_item
FROM blinkit_data
GROUP BY outlet_type
ORDER BY no_of_item DESC;

--Average Rating by Outlet Type

SELECT outlet_type,ROUND(AVG(rating),2) AS avg_rating
FROM blinkit_data
GROUP BY outlet_type
ORDER BY avg_rating DESC;