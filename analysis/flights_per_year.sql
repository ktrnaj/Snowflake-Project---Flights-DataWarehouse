--------------------------------------------------------
-- flights_per_year.sql
-- Purpose: Calculate the total number of flights 
--          for each year using FACT_FLIGHTS and DIM_DATE
--------------------------------------------------------

SELECT  
    d."YEAR",  
    COUNT(f."TRANSACTIONID") AS "TOTAL_FLIGHTS"  
FROM "FACT_FLIGHTS" f  
JOIN "DIM_DATE" d  
    ON f."FLIGHTDATE" = d."DATE"  
GROUP BY d."YEAR"  
ORDER BY d."YEAR";

--------------------------------------------------------
-- End of flights_per_year.sql
--------------------------------------------------------
