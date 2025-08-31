---------------
--\\ Copy data from S3 into FACT_FLIGHTS table
COPY INTO FACT_FLIGHTS
FROM @PROJECT_DB.PUBLIC.S3_FOLDER/flights.gz
FILE_FORMAT = my_csv_format
FORCE = TRUE;

---------------
-- Checked for Date inconsistencies and formatted it to appropriate 'YYYY-MM-DD' date format inorder to match the required format
//UPDATE FACT_FLIGHTS
//SET FLIGHTDATE = TO_DATE(FLIGHTDATE, 'YYYY-MM-DD');

UPDATE FACT_FLIGHTS
SET FLIGHTDATE = TO_CHAR(TO_DATE(FLIGHTDATE, 'YYYYMMDD'), 'YYYY-MM-DD');

---------------
--Just to check if the date discrepancies are resolved. I have selected date from oldest to Newest Date
SELECT MIN(FLIGHTDATE), MAX(FLIGHTDATE) FROM FACT_FLIGHTS;

---------------
-- Show and describe the table
SHOW TABLES LIKE 'FACT_FLIGHTS';
DESC TABLE FACT_FLIGHTS;

---------------
-- Just fetching data and viewing the table
SELECT * FROM FACT_FLIGHTS LIMIT 100
