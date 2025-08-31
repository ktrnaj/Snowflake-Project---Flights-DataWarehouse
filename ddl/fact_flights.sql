-- List files in the S3 folder
LIST @PROJECT_DB.PUBLIC.S3_FOLDER/flights.gz;

-- Select rows from the compressed CSV file in S3
SELECT $1, $2, $3, $4, $5FROM @PROJECT_DB.PUBLIC.S3_FOLDER/flights.gz
---------------
--\\As per the case requirement, 
-- \\1. Load the provided data in the file using the provided credentials & named stage to your candidate schema.

--  \\Create or replace file format for CSV files
CREATE OR REPLACE FILE FORMAT my_csv_format
  TYPE = 'CSV'
  FIELD_DELIMITER = '|'
  COMPRESSION = 'GZIP'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  TRIM_SPACE = TRUE;
  
---------------
--\\2. Create and load one fact table named FACT_FLIGHTS to contain data about the flights

--\\ Create FACT_FLIGHTS table
CREATE OR REPLACE TABLE FACT_FLIGHTS (
    TRANSACTIONID VARCHAR,
    FLIGHTDATE VARCHAR,
    AIRLINECODE VARCHAR,
    AIRLINENAME VARCHAR,
    TAILNUM VARCHAR,
    FLIGHTNUM VARCHAR,
    ORIGINAIRPORTCODE VARCHAR,
    ORIGINAIRPORTNAME VARCHAR,
    ORIGINCITYNAME VARCHAR,
    ORIGINSTATE VARCHAR,
    ORIGINSTATENAME VARCHAR,
    DESTAIRPORTCODE VARCHAR,
    DESTAIRPORTNAME VARCHAR,
    DESTCITYNAME VARCHAR,
    DESTSTATE VARCHAR,
    DESTSTATENAME VARCHAR,
    CRSDEPTIME TIME,
    DEPTIME TIME,
    DEPDELAY NUMBER,
    TAXIOUT NUMBER,
    WHEELSOFF TIME,
    WHEELSON TIME,
    TAXIIN NUMBER,
    CRSARRTIME TIME,
    ARRTIME TIME,
    ARRDELAY NUMBER,
    CRSELAPSEDTIME NUMBER,
    ACTUALELAPSEDTIME NUMBER,
    CANCELLED BOOLEAN,
    DIVERTED BOOLEAN,
    DISTANCE STRING
);

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
