use credit_card
-- 1.	Retrieve a unique collection of education levels from the database
select distinct Education_Level from customer 

-- 2.	Find count of customers who own a car and a house 
select count(Client_Num) as Client_Number from customer  where Car_Owner = 'yes' and House_Owner = 'yes' ;

-- 3.  Retrieve the Client number and Income for customers where the income exceeds 50,000.
select Client_Num as Number , income from customer where income > 50000 order by income;

-- 4.   Extract the Client_Num, Customer_Age, Gender, and Credit_Limit attributes from the 
--      dataset for records where Customer_Age falls within the range of 20 to 40 years inclusive  
SELECT 
    customer.Client_Num,
    customer.Customer_Age,
    customer.Gender,
    credit_card.Credit_Limit
FROM
    customer
        JOIN
    credit_card ON credit_card.Client_Num = customer.Client_Num
where Customer_Age between 20 and 40 ;

-- 5.	Calculate the average utilization ratio for customers in the cc_ table.

SELECT 
    ROUND(AVG(cc_add.Avg_Utilization_Ratio), 2) AS Avg_Utilization_Ratio
FROM
   customer 

-- 6. What is the total revenue generated from male customers

SELECT 
    SUM(credit_card.Annual_Fees + credit_card.Interest_Earned + credit_card.Total_Trans_Amt) AS Revenue
FROM
    credit_card join customer on customer.Client_Num = credit_card.Client_Num
WHERE customer.Gender = 'M'
GROUP BY customer.Gender
ORDER BY Revenue DESC

-- 7.	Count the number of customers from each state.
SELECT 
    state_cd AS State, COUNT(Client_Num) AS Count_of_people
FROM
    customer
GROUP BY State;

-- 8.	Find the total transaction amount for each customer.

SELECT 
    (Client_Num) AS Client,
    SUM(Total_Trans_Amt) AS Count_of_Transaction
FROM
    credit_card
GROUP BY Client;

-- 9.Find the average Annual Fees for each Card Category among customers who have a Customer Satisfaction Score greater than 4.
SELECT 
    Card_Category, AVG(Annual_Fees) AS Annual_fee
FROM
    credit_card
        JOIN
    customer ON customer.Client_Num = credit_card.Client_Num
WHERE
    customer.Cust_Satisfaction_Score > 4
GROUP BY Card_Category
order by Annual_fee desc
 

-- 10. Determine the number of customers using each distinct category of credit card grouped by Gender.

SELECT 
    customer.Gender,
    credit_card.Card_Category,
    COUNT(customer.Client_Num) AS Count_of_Client
FROM
    credit_card join customer on customer.Client_Num = credit_card.Client_Num
GROUP BY customer.Gender , credit_card.Card_Category

-- 11. "What are the top three expenditure types that generate the highest revenue, 
   -- and what is the total revenue for each of these types?"

SELECT 
    Exp_Type AS Expenditure_Type,
    SUM(Annual_Fees + Interest_Earned + Total_Trans_Amt) AS Revenue
FROM
    credit_card
GROUP BY Expenditure_Type
order by Revenue desc
limit 3

-- 12. What is the count of credit card usage, grouped by gender?

SELECT 
    customer.Gender,
    credit_card.Use_Chip,
    COUNT(customer.Client_Num) AS Count_of_Client
FROM
    credit_card
        JOIN
    customer ON customer.Client_Num = credit_card.Client_Num
GROUP BY customer.Gender , credit_card.Use_Chip ;

-- 13.	Find the number of customers who have taken a personal loan 
SELECT 
    customer.Personal_loan,
    COUNT(Client_Num) AS Number_of_Customer
FROM
    customer 
WHERE
    customer.Personal_loan = 'yes'
    
-- 14.	Determine the average income of customers based on their education

SELECT 
    Education_Level, AVG(Income) as Income 
FROM
    customer
GROUP BY Education_Level
order by Income desc

-- 15.Retrieve the top 5 customers with the highest credit limits , and include their age and Income .

SELECT 
    (customer.Client_Num) AS Customer,
    customer.Customer_Age,
    customer.Income,
    credit_card.Credit_Limit
FROM
    customer
        JOIN
    credit_card ON customer.Client_Num = credit_card.Client_Num
ORDER BY credit_card.Credit_Limit DESC
LIMIT 5

-- 16. Create a view that shows customers' basic information, their total transaction amount, and average utilization 

SELECT 
    Customer_Age,
    Gender,
    Marital_Status,
    state_cd,
    Total_Trans_Amt,
    Avg_Utilization_Ratio
FROM
    customer
        JOIN
    credit_card ON customer.Client_Num = credit_card.Client_Num

 -- 17.	Find customers who have a delinquent account, an annual income over 50,000. 

SELECT 
    (customer.Client_Num) AS Customer,
    credit_card.Delinquent_Acc,
    customer.Income
FROM
    customer
        JOIN
    credit_card ON customer.Client_Num = credit_card.Client_Num
WHERE
    customer.Income >= 50000
        AND Delinquent_Acc != 0
        
-- 18. Calculate the total customer acquisition cost and the average annual fees for each card category , grouped by quarter.
SELECT 
    Qtr,
    Card_Category,
    SUM(Customer_Acq_Cost) AS Acquisition_cost,
    SUM(Annual_Fees) AS Annual_Fees
FROM
    credit_card
GROUP BY Qtr , Card_Category

-- 19.The average Customer_Age, Income,and Cust_Satisfaction_Score of customers grouped by their Marital_Status
--   and sorted in descending order of average Income.
SELECT 
    Marital_Status,
    AVG(Customer_Age) as Average_age,
    AVG(Income) AS AVG_Income,
    AVG(Cust_Satisfaction_Score)
FROM
    customer
GROUP BY Marital_Status
ORDER BY AVG_Income DESC

-- 20.The count of delinquent accounts for each Card_Category grouped by Gender.
SELECT 
   Gender, Card_Category, COUNT(Delinquent_Acc) AS Delinquent_Account
FROM
    credit_card JOIN customer on customer.Client_Num = credit_card.Client_Num
WHERE
    Delinquent_Acc != 0
GROUP BY  Gender, Card_Category 

