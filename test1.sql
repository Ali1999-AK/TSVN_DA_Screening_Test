SELECT * FROM loan.Customers;
SELECT * FROM Products;
USE loan;
CREATE TABLE Leads(customer_id int,
product_id int,
apply_date datetime,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
primary key(customer_id,product_id));

INSERT INTO Leads Values(201,111,"2017-04-17"),
(202,111,"2017-04-17"),(203,111,"2017-05-17"),(204,111,"2017-05-17"),
(205,111,"2017-06-17"),(206,111,"2017-06-17"),(207,111,"2017-06-17");

SELECT COUNT(customer_id) As Cnt_each,MONTHNAME(apply_date) AS MONTH_EACH FROM Leads WHERE YEAR(apply_date)=2017 GROUP BY MONTH_EACH; 

SELECT AVG(Cnt_each) 
FROM  (
SELECT COUNT(customer_id) As Cnt_each ,monthname(apply_date) AS Month_each
FROM Leads
WHERE YEAR(apply_date)=2017 
GROUP BY MONTH(Month_each)
) AS T;


WITH avg_count_month AS (
SELECT AVG(Cnt_each) as loan_avg
FROM (
SELECT COUNT(customer_id) As Cnt_each ,monthname(apply_date) AS Month_each
FROM Leads
WHERE YEAR(apply_date)=2017 
GROUP BY Month_each) t1
)
SELECT MONTHNAME(apply_date),COUNT(customer_id) AS MONTHLY_COUNT FROM
Leads WHERE YEAR(apply_date)=2017 
GROUP BY MONTHNAME(apply_date)
HAVING MONTHLY_COUNT > (1.2*(SELECT loan_avg FROM avg_count_month)) ;

SELECT * FROM CUSTOMERS;

INSERT INTO CUSTOMERS VALUES(222,'R',16,"low","Google","2016-04-16"),
(223,'R',17,"low","Google","2016-04-16"),(224,'R',18,"low","Google","2016-04-16"),
(225,'R',19,"low","Google","2016-04-16"),(226,'R',20,"low","Google","2016-04-16")
,(227,'R',21,"low","Google","2016-04-16"),(228,'R',22,"low","Google","2016-04-16")
,(229,'R',23,"low","Google","2016-04-16"),(230,'R',24,"low","Google","2016-04-16"),
(231,'R',25,"low","Google","2016-04-16");



SELECT * FROM Leads;

INSERT INTO LEADS Values(208,111,"2017-12-12"),
(209,111,"2017-12-12"),(210,111,"2017-12-12"),
(211,111,"2017-12-12"),(212,111,"2017-12-12"),(213,111,"2017-12-12"),(214,111,"2017-12-12"),(215,111,"2017-12-12")
,(216,111,"2017-12-12"),(217,111,"2017-12-12"),(218,111,"2017-12-12"),(219,111,"2017-12-12")
;
insert into Leads Values(222,111,'2016-12-12'),(223,111,'2016-12-12'),
(224,111,'2016-12-12'),(225,111,'2016-12-12'),(226,111,'2016-12-12'),(227,111,'2016-12-12')
,(228,111,'2016-12-12'),(229,111,'2016-12-12'),(230,111,'2016-12-12'),(231,111,'2016-12-12');

SELECT * FROM Customers;

SELECT * FROM Leads;

SELECT Customer_name,Customer_age,percent_rank() OVER(ORDER BY Customer_age) from Customers;


SELECT Customer_age,PERCENT FROM
(
SELECT Customer_age,percent_rank() OVER(ORDER BY Customer_age) AS PERCENT from Customers JOIN LEADS WHERE YEAR(apply_date)=2016
) T WHERE PERCENT>0.95 ORDER BY Customer_age;

SELECT Customer_age,percent_rank() OVER(ORDER BY Customer_age) AS PERCENT from Customers right JOIN Leads ON Customers.Customer_id=Leads.Customer_id  WHERE YEAR(apply_date)=2016;
SELECT * FROM Customers;

SELECT Customer_age FROM
(
SELECT Customer_age,percent_rank() OVER(ORDER BY Customer_age) AS PERCENT from Customers right JOIN Leads ON Customers.Customer_id=Leads.Customer_id  WHERE YEAR(apply_date)=2017
) T;


WITH ONE_SIX AS (
SELECT Customer_age FROM
(
SELECT Customer_age,percent_rank() OVER(ORDER BY Customer_age) AS PERCENT from Customers right JOIN Leads ON Customers.Customer_id=Leads.Customer_id  WHERE YEAR(apply_date)=2016
) T WHERE PERCENT>0.9 ORDER BY Customer_age ASC limit 1
)
SELECT Customer_name,Customer_age From Customers JOIN Leads ON Customers.Customer_id=Leads.Customer_id WHERE Customer_age>(SELECT Customer_age FROM ONE_SIX);


SHOW TABLES;

SELECT * FROM BANKS;

SELECT * FROM Products;

SELECT * FROM CUSTOMERS;

SELECT * FROM lEADS;

SELECT accepted_risk_level,COUNT(product_id) FROM Products GROUP BY accepted_risk_level;

SELECT AVG(interest_rate)  As Avg_of_HSBC,bank_name 
FROM loan.Products 
JOIN loan.Banks ON loan.Products.bank_id = loan.Banks.bank_id 
where Banks.bank_name="HSBC";

SELECT DISTINCT bank_name from loan.Products 
JOIN loan.Banks ON loan.Products.bank_id = loan.Banks.bank_id 
WHERE accepted_risk_level = "High" 
ORDER BY interest_rate DESC LIMIT 2;

SELECT source,COUNT(customer_id) 
FROM loan.Customers 
WHERE estimated_risk_level="low"  
GROUP BY source 
LIMIT 1;

WITH avg_count_month AS (
SELECT AVG(Cnt_each) as loan_avg
FROM (
SELECT COUNT(customer_id) As Cnt_each ,monthname(apply_date) AS Month_each
FROM Leads
WHERE YEAR(apply_date)=2017
GROUP BY Month_each) AS t1
)
SELECT MONTHNAME(apply_date),COUNT(customer_id) AS MONTHLY_COUNT FROM
Leads WHERE YEAR(apply_date)=2017
GROUP BY MONTHNAME(apply_date)
HAVING MONTHLY_COUNT > (1.2*(SELECT loan_avg FROM avg_count_month)) ;


WITH ONE_SIX AS (
SELECT Customer_age FROM
(
SELECT Customer_age,percent_rank() OVER(ORDER BY Customer_age) AS PERCENT from Customers right JOIN Leads ON Customers.Customer_id=Leads.Customer_id  WHERE YEAR(apply_date)=2016
) T WHERE PERCENT>0.9 ORDER BY Customer_age ASC limit 1
)
SELECT Customer_name,Customer_age From Customers JOIN Leads ON Customers.Customer_id=Leads.Customer_id WHERE Customer_age>(SELECT Customer_age FROM ONE_SIX);
