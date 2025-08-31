--------------------------------------------------------
-- flights_per_airline.sql
-- Purpose: Retrieve the total number of flights per 
--          airline by year, grouped by airline name 
--          and year, ordered by year and total flights
--------------------------------------------------------

SELECT  
    d."YEAR",  
    al."AIRLINENAME",  
    COUNT(f."TRANSACTIONID") AS "TOTAL_FLIGHTS"  
FROM "FACT_FLIGHTS" f  
JOIN "DIM_AIRLINE" al  
    ON f."AIRLINECODE" = al."AIRLINECODE"  
JOIN "DIM_DATE" d  
    ON f."FLIGHTDATE" = d."DATE"  
GROUP BY d."YEAR", al."AIRLINENAME"  
ORDER BY d."YEAR", "TOTAL_FLIGHTS" DESC;

--------------------------------------------------------
-- End of flights_per_airline.sql
--------------------------------------------------------
