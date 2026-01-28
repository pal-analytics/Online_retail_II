-- Phase 4: Business Analysis & SQL Analysis --
-- Objective: Answer key business questions using cleaned retail data

-- Q1: Overall business performance metrics
SELECT
  COUNT(DISTINCT INVOICE) AS total_orders,
  COUNT(DISTINCT CUSTOMER_ID) AS total_customers,
  SUM(TOTAL_AMOUNT) AS total_revenue,
  ROUND(AVG(TOTAL_AMOUNT), 2) AS avg_order_value
FROM RETAIL_CLEAN;

-- Q2: Monthly revenue trend over time
SELECT
  INVOICE_YEAR,
  INVOICE_MONTH,
  ROUND(SUM(TOTAL_AMOUNT), 2) AS monthly_revenue
FROM RETAIL_CLEAN
GROUP BY INVOICE_YEAR, INVOICE_MONTH
ORDER BY INVOICE_YEAR, INVOICE_MONTH;

-- Q3: Top 10 products by revenue
SELECT * FROM (
  SELECT STOCKCODE,
  DESCRIPTION,
  ROUND(SUM(TOTAL_AMOUNT), 2) AS product_revenue
FROM RETAIL_CLEAN
GROUP BY STOCKCODE, DESCRIPTION
ORDER BY product_revenue DESC )
WHERE ROWNUM <= 10;

-- Q4: Top 10 customers by revenue contribution
SELECT * FROM(
SELECT CUSTOMER_ID,
  ROUND(SUM(TOTAL_AMOUNT), 2) AS customer_revenue
FROM RETAIL_CLEAN
GROUP BY CUSTOMER_ID
ORDER BY customer_revenue DESC)
WHERE ROWNUM <= 10;

-- Q5: Country-wise customer count and revenue
SELECT
  COUNTRY,
  COUNT(DISTINCT CUSTOMER_ID) AS customers,
  ROUND(SUM(TOTAL_AMOUNT), 2) AS revenue
FROM RETAIL_CLEAN
GROUP BY COUNTRY
ORDER BY revenue DESC;

-- Q6: Customer ranking using window functions
SELECT * FROM (
SELECT CUSTOMER_ID,
  ROUND(SUM(TOTAL_AMOUNT), 2) AS revenue,
  RANK() OVER (ORDER BY SUM(TOTAL_AMOUNT) DESC) AS revenue_rank
FROM RETAIL_CLEAN
GROUP BY CUSTOMER_ID)
WHERE ROWNUM <= 10;

-- Q7: Monthly revenue with cumulative growth
SELECT
  INVOICE_YEAR,
  INVOICE_MONTH,
  ROUND(SUM(TOTAL_AMOUNT), 2) AS monthly_revenue,
  ROUND(
    SUM(SUM(TOTAL_AMOUNT)) OVER (
    ORDER BY INVOICE_YEAR, INVOICE_MONTH),2) AS cumulative_revenue
FROM RETAIL_CLEAN
GROUP BY INVOICE_YEAR, INVOICE_MONTH
ORDER BY INVOICE_YEAR, INVOICE_MONTH;