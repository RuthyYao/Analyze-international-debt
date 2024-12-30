# Analyze International Debt 

<p align="center">
<img src="https://github.com/RuthyYao/Analyze-international-debt/blob/main/img/front-image.PNG" align="center" width="1200" height="200" >

## Table of Contents
* [Bussiness Task](#bussiness-task)
* [Data Understanding](#Data-understanding)
* [Data Analysis](#Data-analysis)
* [Data Visualization](#Data-visualization)


## Bussiness Task
In this project, I will write SQL query to extract insight on the international debts distribution by countries and the top reasons for borrowing. 

## Data Understanding

``` SQL
SELECT * FROM international_debt LIMIT 5;
```

| # country_name | country_code | indicator_name                                                   | indicator_code | debt       |
|----------------|--------------|------------------------------------------------------------------|----------------|------------|
| Afghanistan    | AFG          | Disbursements on external debt, long-term (DIS, current US$)     | DT.DIS.DLXF.CD | 72894453.7 |
| Afghanistan    | AFG          | Interest payments on external debt, long-term (INT, current US$) | DT.INT.DLXF.CD | 53239440.1 |
| Afghanistan    | AFG          | PPG, bilateral (AMT, current US$)                                | DT.AMT.BLAT.CD | 61739336.9 |
| Afghanistan    | AFG          | PPG, bilateral (DIS, current US$)                                | DT.DIS.BLAT.CD | 49114729.4 |
| Afghanistan    | AFG          | PPG, bilateral (INT, current US$)                                | DT.INT.BLAT.CD | 39903620.1 |

The dataset features the country name, borrowing purposes and the amount of debt. 

## Data Analysis

### 1. How many countries borrow money from World Bank?

``` SQL
SELECT 
	COUNT(DISTINCT country_name) AS num_countries
FROM international_debt;
```
| # num_countries |
|-----------------|
| 124             |

There are 124 countries that borrow money from World Bank.

### 2. What are the purposes of borrowing?

``` SQL
SELECT
	COUNT(DISTINCT indicator_code) AS loan_purpose_count
FROM international_debt;
```

| # loan_purpose_count |
|----------------------|
| 25                   |

```SQL
SELECT
   DISTINCT indicator_code AS purpose_debt_code,
   indicator_name AS purpose_debt,
   ROUND(SUM(debt)/1000000,2) AS debt_amount
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY debt_amount DESC;
```

| # purpose_debt_code | purpose_debt                                                                          | debt_amount |
|---------------------|---------------------------------------------------------------------------------------|-------------|
| DT.AMT.DLXF.CD      | Principal repayments on external debt, long-term (AMT, current US$)                   | 732203.68   |
| DT.AMT.DPNG.CD      | Principal repayments on external debt, private nonguaranteed (PNG) (AMT, current US$) | 407734.35   |
| DT.DIS.DLXF.CD      | Disbursements on external debt, long-term (DIS, current US$)                          | 264701.07   |
| DT.DIS.OFFT.CD      | PPG, official creditors (DIS, current US$)                                            | 238995.98   |
| DT.INT.DLXF.CD      | Interest payments on external debt, long-term (INT, current US$)                      | 203858.98   |
| DT.AMT.PRVT.CD      | PPG, private creditors (AMT, current US$)                                             | 176762.02   |
| DT.AMT.OFFT.CD      | PPG, official creditors (AMT, current US$)                                            | 147707.31   |
| DT.DIS.BLAT.CD      | PPG, bilateral (DIS, current US$)                                                     | 138214.74   |
| DT.DIS.MLAT.CD      | PPG, multilateral (DIS, current US$)                                                  | 100781.24   |
| DT.INT.DPNG.CD      | Interest payments on external debt, private nonguaranteed (PNG) (INT, current US$)    | 96412.46    |
| DT.AMT.BLAT.CD      | PPG, bilateral (AMT, current US$)                                                     | 86939.6     |
| DT.AMT.PBND.CD      | PPG, bonds (AMT, current US$)                                                         | 74701.05    |
| DT.INT.PRVT.CD      | PPG, private creditors (INT, current US$)                                             | 70534.54    |
| DT.AMT.PCBK.CD      | PPG, commercial banks (AMT, current US$)                                              | 61728.97    |
| DT.AMT.MLAT.CD      | PPG, multilateral (AMT, current US$)                                                  | 60767.71    |
| DT.INT.PBND.CD      | PPG, bonds (INT, current US$)                                                         | 55526.6     |
| DT.AMT.PROP.CD      | PPG, other private creditors (AMT, current US$)                                       | 40332       |
| DT.INT.OFFT.CD      | PPG, official creditors (INT, current US$)                                            | 36911.99    |
| DT.INT.BLAT.CD      | PPG, bilateral (INT, current US$)                                                     | 20019.38    |
| DT.INT.MLAT.CD      | PPG, multilateral (INT, current US$)                                                  | 16892.61    |
| DT.DIS.PRVT.CD      | PPG, private creditors (DIS, current US$)                                             | 16500.13    |
| DT.DIS.PCBK.CD      | PPG, commercial banks (DIS, current US$)                                              | 14958.56    |
| DT.INT.PCBK.CD      | PPG, commercial banks (INT, current US$)                                              | 13158.4     |
| DT.INT.PROP.CD      | PPG, other private creditors (INT, current US$)                                       | 1849.54     |
| DT.DIS.PROP.CD      | PPG, other private creditors (DIS, current US$)                                       | 1541.57     |

There are total 25 different reasons for borrowing with principal repayments, long-term debt disbursement and public and publicly guaranteed offical creditors the top reasons for borrowing.

### 3. What is the total amount of debts by all countries?

``` SQL
SELECT
   SUM(debt)/1000000 AS total_debts
FROM international_debt;
```

| # total_debts      |
|--------------------|
| 3079734.4876757916 |

Total borrowing is $3.1 trillion.

### 4. What are the top 10 countries with the highest debt?

``` SQL
SELECT 
    country_name,
    SUM(debt)/1000000 AS total_debts
FROM international_debt
GROUP BY country_name
ORDER BY total_debts DESC
LIMIT 10;
```

| # country_name                               | total_debts        |
|----------------------------------------------|--------------------|
| China                                        | 285793.4947342     |
| Brazil                                       | 280623.9661408     |
| South Asia                                   | 247608.72399060006 |
| Least developed countries: UN classification | 212880.99279190003 |
| Russian Federation                           | 191289.05725920002 |
| IDA only                                     | 179048.12720730001 |
| Turkey                                       | 151125.7580353     |
| India                                        | 133627.06095840002 |
| Mexico                                       | 124596.78621729999 |
| Indonesia                                    | 113435.6966935     |

### 5. What is the highest amount of principal repayments?

``` SQL
SELECT
    country_name,
    ROUND(debt / 1000000, 2) AS debt_amount
FROM international_debt
WHERE debt = 
	(SELECT MAX(debt) FROM international_debt WHERE indicator_code = 'DT.AMT.DLXF.CD');
```

| # country_name | debt_amount |
|----------------|--------------------------|
| China          | 96218.62                 |

The highest amount of principal repayment is from China for $96 trillion.

### 6. The top 10 highest amount of debt, which countries they are from and what are the borrowing purposes?

``` SQL
SELECT
    indicator_code,
    indicator_name,
    country_name,
    MAX(debt) / 1000000 AS maximum_debt
FROM international_debt
GROUP BY indicator_code, indicator_name, country_name
ORDER BY maximum_debt DESC
LIMIT 10;
```

| # indicator_code | indicator_name                                                                        | country_name                                 | maximum_debt       |
|------------------|---------------------------------------------------------------------------------------|----------------------------------------------|--------------------|
| DT.AMT.DLXF.CD   | Principal repayments on external debt, long-term (AMT, current US$)                   | China                                        | 96218.6208357      |
| DT.AMT.DLXF.CD   | Principal repayments on external debt, long-term (AMT, current US$)                   | Brazil                                       | 90041.84030410001  |
| DT.AMT.DPNG.CD   | Principal repayments on external debt, private nonguaranteed (PNG) (AMT, current US$) | China                                        | 72392.9862138      |
| DT.AMT.DLXF.CD   | Principal repayments on external debt, long-term (AMT, current US$)                   | Russian Federation                           | 66589.7618335      |
| DT.AMT.DLXF.CD   | Principal repayments on external debt, long-term (AMT, current US$)                   | Turkey                                       | 51555.0310058      |
| DT.AMT.DLXF.CD   | Principal repayments on external debt, long-term (AMT, current US$)                   | South Asia                                   | 48756.2958982      |
| DT.AMT.PRVT.CD   | PPG, private creditors (AMT, current US$)                                             | Brazil                                       | 43598.6974986      |
| DT.AMT.DPNG.CD   | Principal repayments on external debt, private nonguaranteed (PNG) (AMT, current US$) | Russian Federation                           | 42800.154974900004 |
| DT.AMT.DPNG.CD   | Principal repayments on external debt, private nonguaranteed (PNG) (AMT, current US$) | Brazil                                       | 41831.4440533      |
| DT.DIS.DLXF.CD   | Disbursements on external debt, long-term (DIS, current US$)                          | Least developed countries: UN classification | 40160.7662616      |

Majority of the highest amount of borrowing are for the reasons of repaying the long-term debts which come from a couple of countries including China, Brazil, Russia, Turkey. 

## Data Visualization

<br>

<p align="center">
<img src="https://github.com/RuthyYao/Analyze-international-debt/blob/main/img/dashboard.PNG" align="center" width="1200" height="600" >

---
* View the complete syntax [HERE](https://github.com/RuthyYao/Analyze-international-debt/blob/main/International_debt_query.sql).
