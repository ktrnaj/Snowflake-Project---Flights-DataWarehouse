--\\4. Create a view named VW_FLIGHTS that joins your fact table to your dimension tables and returns columns useful 
--\\for analysis.
-- Create a view for flight data
CREATE OR REPLACE VIEW "VW_FLIGHTS" AS

SELECT 
    f."TRANSACTIONID",
    f."DISTANCEGROUP",
    f."DEPDELAYGT15",
    f."NEXTDAYARR",
    al."AIRLINENAME",
    a1."AIRPORTNAME" AS "ORIGINAIRPORTNAME",
    a2."AIRPORTNAME" AS "DESTAIRPORTNAME",
    f."FLIGHTDATE",
    f."DEPTIME",
    f."ARRTIME",
    f."DEPDELAY",
    f."ARRDELAY",
    f."DISTANCE",
FROM "FACT_FLIGHTS" f
JOIN "DIM_AIRLINE" al ON f."AIRLINECODE" = al."AIRLINECODE"
JOIN "DIM_AIRPORT" a1 ON f."ORIGINAIRPORTCODE" = a1."AIRPORTCODE"
JOIN "DIM_AIRPORT" a2 ON f."DESTAIRPORTCODE" = a2."AIRPORTCODE"
