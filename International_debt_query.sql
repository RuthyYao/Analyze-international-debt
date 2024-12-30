-----------------------------------
-- Analyzing International Debts --
-----------------------------------

-- Author: Ruthy Yao
-- Date: 27/12/2024
-- Tool used: MYSQL

-------------------------------------
-- Data Exploration 
-------------------------------------

SELECT * FROM international_debt LIMIT 5;

-- 1. Finding the number of distinct countries
SELECT 
	COUNT(DISTINCT country_name) AS num_countries
FROM international_debt;

-- 2. Finding out the distinct debt indicators
SELECT
	DISTINCT indicator_code AS purpose_debt_code,
    indicator_name AS purpose_debt,
    ROUND(SUM(debt)/1000000,2) AS debt_amount
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY debt_amount DESC;

SELECT
	COUNT(DISTINCT indicator_code) AS loan_purpose_count
FROM international_debt;

-- 3. Totaling the amount of debt owned by the countries
SELECT
	SUM(debt)/1000000 AS total_debts
FROM international_debt;

-- 4. Countries with the highest debt
SELECT 
	country_name,
    SUM(debt)/1000000 AS total_debts
FROM international_debt
GROUP BY country_name
ORDER BY total_debts DESC
LIMIT 10;

-- 5. Average amount of debt across indicators
SELECT
	indicator_code,
    indicator_name,
    ROUND(AVG(debt) / 1000000, 2) AS avg_debt
FROM International_debt
GROUP BY Indicator_code, Indicator_name
ORDER BY avg_debt DESC
LIMIT 10;

-- 6. The highest amount of principal repayments
SELECT
	country_name,
    ROUND(debt / 1000000, 2)
FROM international_debt
WHERE debt = 
	(SELECT MAX(debt) FROM international_debt WHERE indicator_code = 'DT.AMT.DLXF.CD');

-- 7. The most common debt indicator
SELECT
	indicator_code,
    indicator_name,
    COUNT(indicator_code) AS occurence
FROM international_debt
GROUP BY indicator_code,indicator_name
ORDER BY occurence DESC
LIMIT 10;

-- 8. The highest amount of debt, the purpose of the debt and the country.
SELECT
	indicator_code,
    indicator_name,
	country_name,
    MAX(debt) / 1000000 AS maximum_debt
FROM international_debt
GROUP BY indicator_code, indicator_name, country_name
ORDER BY maximum_debt DESC
LIMIT 10;


	
