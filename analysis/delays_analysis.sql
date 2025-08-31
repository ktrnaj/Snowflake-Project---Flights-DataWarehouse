--------------------------------------------------------
-- delays_analysis.sql
-- Purpose: Analyze flight delays by calculating average
--          departure and arrival delays per airline and year
--------------------------------------------------------

SELECT  
    d."YEAR",  
    al."AIRLINENAME",  
    ROUND(AVG(f."DEPDELAY"), 2) AS "AVG_DEP_DELAY",  
    ROUND(AVG(f."ARRDELAY"), 2) AS "AVG_ARR_DELAY",  
    COUNT(f."TRANSACTIONID") AS "TOTAL_FLIGHTS"
FROM "FACT_FLIGHTS" f
JOIN "DIM_AIRLINE" al  
    ON f."AIRLINECODE" = al."AIRLINECODE"  
JOIN "DIM_DATE" d  
    ON f."FLIGHTDATE" = d."DATE"  
WHERE f."CANCELLED" = FALSE  
  AND f."DIVERTED" = FALSE  
GROUP BY d."YEAR", al."AIRLINENAME"  
ORDER BY d."YEAR", "AVG_DEP_DELAY" DESC;

--------------------------------------------------------
-- End of delays_analysis.sql
--------------------------------------------------------
