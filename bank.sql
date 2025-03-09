select * from bank_cs;

describe bank_cs;


--What is the average age of customers?--
SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(CustomerDOB, 'DD-MON-RR'))) AS average_age
FROM bank_cs;


--What is the distribution of customers by gender?--
SELECT custgender, COUNT(*) AS count FROM bank_cs GROUP BY custgender;

--How many customers are there in each location?--
SELECT custlocation, COUNT(*) AS count FROM bank_cs GROUP BY custlocation ORDER BY count DESC;


--What is the average account balance of customers?--
SELECT AVG(custaccountbalance) AS average_balance FROM bank_cs;


--What is the total number of transactions per customer?--
SELECT CustomerID, COUNT(*) AS transaction_count FROM bank_cs GROUP BY CustomerID;

--What is the average transaction amount?--
SELECT AVG(transactionamount_in_inr) AS average_transaction_amount FROM bank_cs;


--Who are the customers with the highest account balances?--
SELECT CustomerID, CustAccountBalance FROM bank_cs
WHERE CustAccountBalance IS NOT NULL
ORDER BY CustAccountBalance DESC
FETCH FIRST 10 ROWS ONLY;


--How many customers fall into different age groups (e.g., 18-25, 26-35, etc.)?--
SELECT CASE
          WHEN FLOOR((SYSDATE - TO_DATE(CustomerDOB, 'DD-MON-RR')) / 365.25) BETWEEN 18 AND 25 THEN '18-25'
          WHEN FLOOR((SYSDATE - TO_DATE(CustomerDOB, 'DD-MON-RR')) / 365.25) BETWEEN 26 AND 35 THEN '26-35'
          WHEN FLOOR((SYSDATE - TO_DATE(CustomerDOB, 'DD-MON-RR')) / 365.25) BETWEEN 36 AND 45 THEN '36-45'
          ELSE '46+'
        END AS age_group, COUNT(*) AS count
FROM bank_cs
GROUP BY CASE
          WHEN FLOOR((SYSDATE - TO_DATE(CustomerDOB, 'DD-MON-RR')) / 365.25) BETWEEN 18 AND 25 THEN '18-25'
          WHEN FLOOR((SYSDATE - TO_DATE(CustomerDOB, 'DD-MON-RR')) / 365.25) BETWEEN 26 AND 35 THEN '26-35'
          WHEN FLOOR((SYSDATE - TO_DATE(CustomerDOB, 'DD-MON-RR')) / 365.25) BETWEEN 36 AND 45 THEN '36-45'
          ELSE '46+'
        END;



--Who are the customers with the highest number of transactions?--
SELECT CustomerID, COUNT(*) AS transaction_count FROM bank_cs GROUP BY CustomerID ORDER BY transaction_count DESC FETCH FIRST 10 ROWS ONLY;


--What is the average transaction amount by gender?--
SELECT CustGender, AVG(TransactionAmount_in_inr) AS average_transaction_amount FROM bank_cs GROUP BY CustGender;


--What is the distribution of customers by account balance range?--
SELECT CASE
         WHEN CustAccountBalance < 10000 THEN '<10K'
         WHEN CustAccountBalance BETWEEN 10000 AND 50000 THEN '10K-50K'
         WHEN CustAccountBalance BETWEEN 50001 AND 100000 THEN '50K-100K'
         ELSE '>100K'
       END AS balance_range, COUNT(*) AS count
FROM bank_cs
GROUP BY CASE
         WHEN CustAccountBalance < 10000 THEN '<10K'
         WHEN CustAccountBalance BETWEEN 10000 AND 50000 THEN '10K-50K'
         WHEN CustAccountBalance BETWEEN 50001 AND 100000 THEN '50K-100K'
         ELSE '>100K'
       END;


--How do transactions vary by day of the week?--
SELECT TO_CHAR(TransactionDate, 'Day') AS day_of_week, 
COUNT(*) AS transaction_count FROM bank_cs GROUP BY TO_CHAR(TransactionDate, 'Day') ORDER BY transaction_count DESC;


--What is the average account balance of customers segmented by their tenure?--
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) AS customer_tenure, 
AVG(CustAccountBalance) AS average_balance FROM bank_cs GROUP BY EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB);


--What are the key segments of customers based on age, gender, location, and account balance?--
SELECT CustLocation, CustGender, CASE
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) BETWEEN 18 AND 25 THEN '18-25'
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) BETWEEN 26 AND 35 THEN '26-35'
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) BETWEEN 36 AND 45 THEN '36-45'
         ELSE '46+'
       END AS age_group, AVG(CustAccountBalance) AS average_balance
FROM bank_cs
GROUP BY CustLocation, CustGender, CASE
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) BETWEEN 18 AND 25 THEN '18-25'
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) BETWEEN 26 AND 35 THEN '26-35'
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CustomerDOB) BETWEEN 36 AND 45 THEN '36-45'
         ELSE '46+'
       END;




