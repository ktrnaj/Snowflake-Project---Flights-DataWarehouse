--------------------------------------------------------
-- transformations.sql
-- Purpose: Apply data transformations and enrichments
--          to the FACT_FLIGHTS table after initial load
--------------------------------------------------------

-- 1. Standardize FLIGHTDATE to 'YYYY-MM-DD' format
UPDATE FACT_FLIGHTS
SET FLIGHTDATE = TO_CHAR(TO_DATE(FLIGHTDATE, 'YYYYMMDD'), 'YYYY-MM-DD');

--------------------------------------------------------

-- 2. Create DISTANCEGROUP column values (bucketize distances)
UPDATE FACT_FLIGHTS
SET DISTANCEGROUP = 
    CASE
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) <= 100 
            THEN '0-100 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 101 AND 200 
            THEN '101-200 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 201 AND 300 
            THEN '201-300 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 301 AND 400 
            THEN '301-400 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 401 AND 500 
            THEN '401-500 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 501 AND 600 
            THEN '501-600 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 601 AND 700 
            THEN '601-700 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 701 AND 800 
            THEN '701-800 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 801 AND 900 
            THEN '801-900 miles'
        WHEN TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER) BETWEEN 901 AND 1000 
            THEN '901-1000 miles'
        ELSE CONCAT(
                FLOOR(TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER)/100)*100+1, 
                '-', 
                FLOOR(TRY_CAST(REPLACE(DISTANCE, ' miles', '') AS NUMBER)/100)*100+100, 
                ' miles'
             )
    END;

--------------------------------------------------------

-- 3. Flag flights with departure delay > 15 minutes
UPDATE FACT_FLIGHTS
SET DEPDELAYGT15 = DEPDELAY > 15;

--------------------------------------------------------

-- 4. Flag flights that arrive the next day
UPDATE FACT_FLIGHTS
SET NEXTDAYARR = (ARRTIME < DEPTIME);

--------------------------------------------------------
-- End of transformations.sql
--------------------------------------------------------
