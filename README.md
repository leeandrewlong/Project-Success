# Project-Success Report:

#Extract: your original data sources and how the data were formatted (CSV, JSON, pgAdmin 4, etc.). 

Our two original data sources had data from data.world for regional sales and a Walmart retail data set. We chose two large CSV data files and broke down the large files into multiple smaller files to transform the data later into six tables for analysis. 

#Transform: what data cleaning or transformation was required.

The two original CSV files were fairly clean to start, but they were quite large with multiple sheets for each. We decided to break down the various sheets on each CSV into new CSV files to create better tables for our database in PostGres. We also needed to remove all quotation marks and commas within the data to properly import the CSV files into pgAdmin. We also deleted a column of product names from the Walmart data because we didn’t need the product names, just the unit prices for sales comparisons, and it was throwing an error with the commas for our delimiter. From there, we used ERD to link some of our tables with Primary and foregin keys. Then with our 7 tables loaded, we were able to query and transform our data with joins to compare the state data from Walmart and the regional sales data. 

#Load: the final database, tables/collections, and why this was chosen

For our final database, we imported our CSV files into our tables we created in pgAdmin. We added 7 tables to compare our retail data from Walmart with our regional sales data. We chose to load these tables to our database to be able to query our tables to compare how the Walmart retail data looks with the regional data on a State by State comparison. We also wanted to compare the data for the Southern region specifically for Walmart vs. the Regional “the Other Guys” data. To find those, we were able to perform some aggregations, group bys, and order bys to analyze states and the Southern region and their total sales.
