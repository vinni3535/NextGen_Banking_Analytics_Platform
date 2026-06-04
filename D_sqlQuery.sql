create database banking_dashboard;

-- SELECT
SELECT * FROM sat;
CREATE TABLE sat (
    Client_ID VARCHAR(20),
    Name VARCHAR(100),
    Age INT,
    Location_ID INT,
    Joined_Bank DATE,
    Banking_Contact VARCHAR(100),
    Nationality VARCHAR(50),
    Occupation VARCHAR(100),
    Fee_Structure VARCHAR(20),
    Loyalty_Classification VARCHAR(30),
    Estimated_Income DECIMAL(15,2),
    Superannuation_Savings DECIMAL(15,2),
    Amount_of_Credit_Cards INT,
    Credit_Card_Balance DECIMAL(15,2),
    Bank_Loans DECIMAL(15,2),
    Bank_Deposits DECIMAL(15,2),
    Checking_Accounts DECIMAL(15,2),
    Saving_Accounts DECIMAL(15,2),
    Foreign_Currency_Account DECIMAL(15,2),
    Business_Lending DECIMAL(15,2),
    Properties_Owned INT,
    Risk_Weighting INT,
    BRId INT,
    GenderId INT,
    IAId INT
);

-- SHOW 
SHOW TABLES;

SELECT DATABASE();

USE banking_dashboard;
DESCRIBE sat;

USE banking_dashboard;
SHOW TABLES;

SELECT COUNT(*) FROM sat;

SELECT * FROM sat LIMIT 10;

-- SELECT with condition
SELECT name, age FROM sat WHERE age > 30;

-- EXPLAIN (query analysis)
EXPLAIN SELECT * FROM sat;

--- Total missing values per column
SELECT 
  COUNT(*) AS total_rows,

  SUM(CASE WHEN Client_ID IS NULL OR Client_ID = '' THEN 1 ELSE 0 END) AS missing_client_id,
  SUM(CASE WHEN Name IS NULL OR Name = '' THEN 1 ELSE 0 END) AS missing_name,
  SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS missing_age,
  SUM(CASE WHEN Location_ID IS NULL THEN 1 ELSE 0 END) AS missing_location_id,
  SUM(CASE WHEN Joined_Bank IS NULL THEN 1 ELSE 0 END) AS missing_joined_bank,
  SUM(CASE WHEN Banking_Contact IS NULL OR Banking_Contact = '' THEN 1 ELSE 0 END) AS missing_contact,
  SUM(CASE WHEN Nationality IS NULL OR Nationality = '' THEN 1 ELSE 0 END) AS missing_nationality,
  SUM(CASE WHEN Occupation IS NULL OR Occupation = '' THEN 1 ELSE 0 END) AS missing_occupation,
  SUM(CASE WHEN Fee_Structure IS NULL OR Fee_Structure = '' THEN 1 ELSE 0 END) AS missing_fee_structure,
  SUM(CASE WHEN Loyalty_Classification IS NULL OR Loyalty_Classification = '' THEN 1 ELSE 0 END) AS missing_loyalty,

  SUM(CASE WHEN Estimated_Income IS NULL THEN 1 ELSE 0 END) AS missing_income,
  SUM(CASE WHEN Superannuation_Savings IS NULL THEN 1 ELSE 0 END) AS missing_superannuation,
  SUM(CASE WHEN Amount_of_Credit_Cards IS NULL THEN 1 ELSE 0 END) AS missing_cards,

  SUM(CASE WHEN Credit_Card_Balance IS NULL THEN 1 ELSE 0 END) AS missing_card_balance,
  SUM(CASE WHEN Bank_Loans IS NULL THEN 1 ELSE 0 END) AS missing_loans,
  SUM(CASE WHEN Bank_Deposits IS NULL THEN 1 ELSE 0 END) AS missing_deposits,
  SUM(CASE WHEN Checking_Accounts IS NULL THEN 1 ELSE 0 END) AS missing_checking,
  SUM(CASE WHEN Saving_Accounts IS NULL THEN 1 ELSE 0 END) AS missing_saving,
  SUM(CASE WHEN Foreign_Currency_Account IS NULL THEN 1 ELSE 0 END) AS missing_foreign_account,
  SUM(CASE WHEN Business_Lending IS NULL THEN 1 ELSE 0 END) AS missing_business_lending,

  SUM(CASE WHEN Properties_Owned IS NULL THEN 1 ELSE 0 END) AS missing_properties,
  SUM(CASE WHEN Risk_Weighting IS NULL THEN 1 ELSE 0 END) AS missing_risk,
  SUM(CASE WHEN BRId IS NULL THEN 1 ELSE 0 END) AS missing_brid,
  SUM(CASE WHEN GenderId IS NULL THEN 1 ELSE 0 END) AS missing_genderid,
  SUM(CASE WHEN IAId IS NULL THEN 1 ELSE 0 END) AS missing_iaid

FROM sat;

--- Only “problem records”
SELECT *
FROM sat
WHERE 
  Client_ID IS NULL OR Client_ID = '' OR
  Name IS NULL OR Name = '' OR
  Age IS NULL OR
  Location_ID IS NULL OR
  Joined_Bank IS NULL OR
  Banking_Contact IS NULL OR Banking_Contact = '' OR
  Nationality IS NULL OR Nationality = '' OR
  Occupation IS NULL OR Occupation = '' OR
  Estimated_Income IS NULL OR
  Bank_Loans IS NULL;
  
  --- Data quality summary
  SELECT 
  COUNT(Name) AS filled_name,
  COUNT(Age) AS filled_age,
  COUNT(Estimated_Income) AS filled_income,
  COUNT(Bank_Loans) AS filled_loans
FROM sat;

SELECT 
  (SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) / COUNT(*) ) * 100 AS age_missing_percent,
  (SUM(CASE WHEN Estimated_Income IS NULL THEN 1 ELSE 0 END) / COUNT(*) ) * 100 AS income_missing_percent
FROM sat;

--- Missing data check
SELECT COUNT(*) 
FROM sat
WHERE Name IS NULL OR Name = '';

SELECT COUNT(*) 
FROM sat
WHERE Age IS NULL;

SELECT COUNT(*) 
FROM sat
WHERE Estimated_Income IS NULL;


-- 1. Total records
SELECT COUNT(*) AS total_customers FROM sat;

-- 2. Show all data
SELECT * FROM sat;

-- 3. Show first 10 rows
SELECT * FROM sat LIMIT 10;

-- 4. Unique occupations
SELECT DISTINCT Occupation FROM sat;

-- 5. Total unique nationalities
SELECT COUNT(DISTINCT Nationality) AS total_nationalities FROM sat;

-- 6. Average age
SELECT AVG(Age) AS avg_age FROM sat;

-- 7. Minimum and maximum age
SELECT MIN(Age) AS min_age, MAX(Age) AS max_age FROM sat;

-- 8. Gender wise count
SELECT GenderId, COUNT(*) AS total
FROM sat
GROUP BY GenderId;

-- 9. Average income by gender
SELECT GenderId, AVG(`Estimated Income`) AS avg_income
FROM sat
GROUP BY GenderId;

-- 10. Total bank loans by gender
SELECT GenderId, SUM(`Bank Loans`) AS total_loans
FROM sat
GROUP BY GenderId;

-- 11. Customer count by nationality
SELECT Nationality, COUNT(*) AS total_customers
FROM sat
GROUP BY Nationality
ORDER BY total_customers DESC;

-- 12. Average income by nationality
SELECT Nationality, AVG(`Estimated Income`) AS avg_income
FROM sat
GROUP BY Nationality
ORDER BY avg_income DESC;

-- 13. Highest deposits nationality wise
SELECT Nationality, SUM(`Bank Deposits`) AS total_deposits
FROM sat
GROUP BY Nationality
ORDER BY total_deposits DESC;

-- 14. Occupation wise customers
SELECT Occupation, COUNT(*) AS total
FROM sat
GROUP BY Occupation
ORDER BY total DESC;

-- 15. Top 10 occupations with highest income
SELECT Occupation, AVG(`Estimated Income`) AS avg_income
FROM sat
GROUP BY Occupation
ORDER BY avg_income DESC
LIMIT 10;

-- 16. Occupation wise loans
SELECT Occupation, SUM(`Bank Loans`) AS total_loans
FROM sat
GROUP BY Occupation
ORDER BY total_loans DESC;

-- 17. Total bank deposits
SELECT SUM(`Bank Deposits`) AS total_deposits
FROM sat;

-- 18. Total loans
SELECT SUM(`Bank Loans`) AS total_loans
FROM sat;

-- 19. Total saving accounts amount
SELECT SUM(`Saving Accounts`) AS total_savings
FROM sat;

-- 20. Total checking accounts amount
SELECT SUM(`Checking Accounts`) AS total_checking
FROM sat;

-- 21. Average credit card balance
SELECT AVG(`Credit Card Balance`) AS avg_cc_balance
FROM sat;

-- 22. Highest bank deposit customer
SELECT Name, `Bank Deposits`
FROM sat
ORDER BY `Bank Deposits` DESC
LIMIT 1;

-- 23. Highest loan customer
SELECT Name, `Bank Loans`
FROM sat
ORDER BY `Bank Loans` DESC
LIMIT 1;

-- 24. Customers by fee structure
SELECT `Fee Structure`, COUNT(*) AS total
FROM sat
GROUP BY `Fee Structure`;

-- 25. Average income by fee structure
SELECT `Fee Structure`, AVG(`Estimated Income`) AS avg_income
FROM sat
GROUP BY `Fee Structure`;

-- 26. Total deposits by fee structure
SELECT `Fee Structure`, SUM(`Bank Deposits`) AS total_deposits
FROM sat
GROUP BY `Fee Structure`;

-- 27. Loyalty classification count
SELECT `Loyalty Classification`, COUNT(*) AS total
FROM sat
GROUP BY `Loyalty Classification`;

-- 28. Average deposits by loyalty class
SELECT `Loyalty Classification`,
AVG(`Bank Deposits`) AS avg_deposit
FROM sat
GROUP BY `Loyalty Classification`;

-- 29. Highest income loyalty group
SELECT `Loyalty Classification`,
AVG(`Estimated Income`) AS avg_income
FROM sat
GROUP BY `Loyalty Classification`
ORDER BY avg_income DESC;

-- 30. Risk weighting count
SELECT `Risk Weighting`, COUNT(*) AS total
FROM sat
GROUP BY `Risk Weighting`;

-- 31. Average loans by risk level
SELECT `Risk Weighting`,
AVG(`Bank Loans`) AS avg_loans
FROM sat
GROUP BY `Risk Weighting`;

-- 32. Total deposits by risk level
SELECT `Risk Weighting`,
SUM(`Bank Deposits`) AS total_deposits
FROM sat
GROUP BY `Risk Weighting`;

-- 33. Property owned count
SELECT `Properties Owned`, COUNT(*) AS total
FROM sat
GROUP BY `Properties Owned`;

-- 34. Avg income by property ownership
SELECT `Properties Owned`,
AVG(`Estimated Income`) AS avg_income
FROM sat
GROUP BY `Properties Owned`;

-- 35. Top 10 richest customers
SELECT Name, `Estimated Income`
FROM sat
ORDER BY `Estimated Income` DESC
LIMIT 10;

-- 36. Customers with loans greater than deposits
SELECT Name, `Bank Loans`, `Bank Deposits`
FROM sat
WHERE `Bank Loans` > `Bank Deposits`;

-- 37. Customers having high credit card balance
SELECT Name, `Credit Card Balance`
FROM sat
WHERE `Credit Card Balance` > 50000;

-- 38. Customers age above 60
SELECT Name, Age
FROM sat
WHERE Age > 60;

-- 39. Customers age between 20 and 30
SELECT Name, Age
FROM sat
WHERE Age BETWEEN 20 AND 30;

-- 40. Total business lending
SELECT SUM(`Business Lending`) AS total_business_lending
FROM sat;

-- 41. Top 10 customers with business lending
SELECT Name, `Business Lending`
FROM sat
ORDER BY `Business Lending` DESC
LIMIT 10;

-- 42. Income vs loan comparison
SELECT Name,
`Estimated Income`,
`Bank Loans`
FROM sat
ORDER BY `Bank Loans` DESC;

-- 43. Customers with multiple properties
SELECT Name, `Properties Owned`
FROM sat
WHERE `Properties Owned` > 2;

-- 44. Average superannuation savings
SELECT AVG(`Superannuation Savings`) AS avg_super_savings
FROM sat;

-- 45. Top 5 nationalities with highest loans
SELECT Nationality,
SUM(`Bank Loans`) AS total_loans
FROM sat
GROUP BY Nationality
ORDER BY total_loans DESC
LIMIT 5;

-- 46. KPI Total Income
SELECT SUM(`Estimated Income`) AS total_income FROM sat;

-- 47. KPI Total Deposits
SELECT SUM(`Bank Deposits`) AS total_deposits FROM sat;

-- 48. KPI Total Loans
SELECT SUM(`Bank Loans`) AS total_loans FROM sat;

-- 49. KPI Total Customers
SELECT COUNT(*) AS total_customers FROM sat;

-- 50. KPI Average Credit Card Balance
SELECT AVG(`Credit Card Balance`) AS avg_cc_balance FROM sat;