--SQL Online Retail--
--Phase 1 Raw data Overview
-- Data imported into Oracle using SQL Developer import utility without transformation.

-- Total number of rows--
SELECT COUNT(*) FROM RETAIL;

-- Preview sample records--
SELECT * FROM RETAIL WHERE ROWNUM <=10;

-- Distinct business entities--
SELECT COUNT(DISTINCT INVOICE) AS Total_Invoices,
       COUNT(DISTINCT CUSTOMER_ID) AS Total_Customers,
       COUNT(DISTINCT STOCKCODE) AS Total_Products 
FROM RETAIL;

-- Time range of transactions--
-- Note: INVOICEDATE is stored as VARCHAR2 in raw data
SELECT
  MIN(INVOICEDATE) AS Min_Invoice_Date,
  MAX(INVOICEDATE) AS Max_Invoice_Date
FROM RETAIL;