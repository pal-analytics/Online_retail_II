-- Phase 2: Data Quality Checks--
-- Objective: Identify missing values, invalid records, duplicates,
-- cancelled transactions, and date format issues

SELECT COUNT(*) AS Total_Rows FROM RETAIL;

-- Unique invoices
SELECT COUNT(DISTINCT INVOICE) AS Unique_Invoices FROM RETAIL;

-- Null value checks
SELECT 
SUM(CASE WHEN INVOICE IS NULL THEN 1 ELSE 0 END) AS Invoice_Nulls,
SUM(CASE WHEN STOCKCODE IS NULL THEN 1 ELSE 0 END) AS Stockcode_Nulls,
SUM(CASE WHEN DESCRIPTION IS NULL THEN 1 ELSE 0 END) AS Description_Nulls,
SUM(CASE WHEN QUANTITY IS NULL THEN 1 ELSE 0 END) AS Quantity_Nulls,
SUM(CASE WHEN INVOICEDATE IS NULL THEN 1 ELSE 0 END) AS Invoicedate_Nulls,
SUM(CASE WHEN PRICE IS NULL THEN 1 ELSE 0 END) AS Price_Nulls,
SUM(CASE WHEN CUSTOMER_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Nulls,
SUM(CASE WHEN COUNTRY IS NULL THEN 1 ELSE 0 END) AS Country_Nulls
FROM RETAIL;

-- Invalid quantity records
SELECT COUNT(*) AS Invalid_Quantity_Rows FROM RETAIL
WHERE QUANTITY <= 0;

-- Invalid price records
SELECT COUNT(*) AS Invalid_Price_Rows FROM RETAIL
WHERE PRICE <= 0;

-- Cancelled transactions (Invoices starting with 'C')
SELECT COUNT(*) AS Cancelled_Transactions FROM RETAIL
WHERE INVOICE LIKE 'C%';

-- Percentage of cancelled transactions
SELECT ROUND(
    COUNT(CASE WHEN INVOICE LIKE 'C%' THEN 1 END) * 100.0 / COUNT(*),
    2) AS Cancellation_Percentage
FROM RETAIL;

-- Duplicate invoice-product-customer combinations
SELECT INVOICE, STOCKCODE, COUNT(*) AS Duplicate_rows FROM RETAIL
GROUP BY INVOICE, STOCKCODE
HAVING COUNT(*) > 1;

-- Invalid date formats
-- Accepts both dd-mm-yyyy and dd/mm/yyyy
SELECT COUNT(*) AS Invalid_Date_Rows FROM RETAIL
WHERE NOT REGEXP_LIKE(INVOICEDATE,
'^\d{2}[-/]\d{2}[-/]\d{4}');