# Amazon Sales Anlaysis using SQL

![amazon-dp](https://github.com/sa-hin/SQL_Project_Amazon_Sales_Analysis/assets/57092234/51755085-56e7-4b4c-8ea7-abc41fc786e1)

##  🔍Project Overview:

This project involves the analysis of Amazon sales data using SQL in MySQL Workbench. The primary goal is to extract valuable insights and trends from the dataset, which can help in making informed business decisions. The project includes tasks such as data quality checks, feature engineering, and answering various business-related questions through SQL queries.

## :page_facing_up:Data Description:

| Column                     | Description                              | Data Type             |
|----------------------------|------------------------------------------|-----------------------|
| invoice_id                 | Invoice of the sales made                | VARCHAR(30)           |
| branch                     | Branch at which sales were made          | VARCHAR(5)            |
| city                       | The location of the branch               | VARCHAR(30)           |
| customer_type              | The type of the customer                 | VARCHAR(30)           |
| gender                     | Gender of the customer                   | VARCHAR(10)           |
| product_line               | Product line of the product sold         | VARCHAR(100)          |
| unit_price                 | The price of each product                | DECIMAL(10, 2)        |
| quantity                   | The amount of the product sold           | INT                   |
| VAT                        | The amount of tax on the purchase        | FLOAT(6, 4)           |
| total                      | The total cost of the purchase           | DECIMAL(10, 2)        |
| date                       | The date on which the purchase was made  | DATE                  |
| time                       | The time at which the purchase was made  | TIMESTAMP             |
| payment_method             | The payment method used                  | VARCHAR(15)           |
| cogs                       | Cost Of Goods sold                       | DECIMAL(10, 2)        |
| gross_margin_percentage    | Gross margin percentage                  | FLOAT(11, 9)          |
| gross_income               | Gross Income                             | DECIMAL(10, 2)        |
| rating                     | Rating                                   | FLOAT(2, 1)           |


 
## 🔧Tools Used 
<img src="https://edent.github.io/SuperTinyIcons/images/svg/mysql.svg" width="100" title="MySQL">

:green_circle:**MySQL Workbench:** Utilized for writing and executing SQL queries. 

:green_circle:**SQL:** Used extensively for data manipulation, querying, and analysis.


## 🛠️Steps Undertaken

:green_circle:**Database and Table Setup:** Created a new database and a sales table with appropriate fields to store the sales data.

:green_circle:**Data Quality Checks:** Performed checks to identify and handle missing or null values in the dataset, ensuring data integrity.

:green_circle:**Feature Engineering:** Created new features such as time_of_day, day_name, and month_name to enrich the dataset and facilitate more detailed analysis.

:green_circle:**Business Analysis:** Conducted comprehensive analysis by formulating and answering various business questions. This includes identifying sales trends, customer behaviors, revenue patterns, and 
                more.

## :books:Learnings

:green_circle:**Data Cleaning:** Gained experience in identifying and managing missing data to maintain data quality.

:green_circle:**Feature Engineering:** Learned how to create and integrate new features to enhance the analytical capabilities of the dataset.

:green_circle:**SQL Proficiency:** Improved proficiency in SQL, particularly in writing complex queries, performing aggregations, and utilizing window functions.

:green_circle:**Business Insights:** Developed the ability to derive actionable business insights from raw data, contributing to strategic decision-making.


## :checkered_flag:Conclusion

The project highlights the effectiveness of SQL in analyzing sales data and extracting meaningful insights. Through a series of structured steps, including data preparation, feature engineering, and in-depth analysis, we have uncovered valuable trends and patterns in Amazon's sales data.These insights can help optimize business strategies and improve customer satisfaction.
