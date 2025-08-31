# Snowflake-Project---Flights-DataWarehouse
Snowflake Data Warehouse project for loading, transforming, and analyzing airline flights data from S3 into fact and dimension tables
Objective: Build a Snowflake data warehouse from S3 airline data.

Steps performed:

Load data from S3 → FACT_FLIGHTS

Create DIM_* tables

Transform and enrich data (distance groups, delay flags, etc.)

Build analytical view VW_FLIGHTS

Run sample queries for insights

How to run: Snowflake SQL scripts in /ddl, /dml, /analysis

Requirements: Snowflake account, S3 access.


Snowflake-Project/
│── README.md              # Overview of project
│── LICENSE                # License file (MIT, Apache, etc.)
│── .gitignore
│
├── ddl/                   # DDL scripts (create tables, views)
│   ├── fact_flights.sql
│   ├── dim_airline.sql
│   ├── dim_airport.sql
│   ├── dim_date.sql
│   └── vw_flights.sql
│
├── dml/                   # DML scripts (insert, update, transform)
│   ├── load_fact_flights.sql
│   ├── load_dim_airline.sql
│   ├── load_dim_airport.sql
│   ├── load_dim_date.sql
│   └── transformations.sql
│
├── analysis/              # Example analytical queries
│   ├── flights_per_year.sql
│   ├── flights_per_airline.sql
│   └── delays_analysis.sql
│
└── docs/                  # Documentation (ER diagrams, notes, etc.)
    └── schema.png
