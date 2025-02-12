-- external table creation

CREATE OR REPLACE EXTERNAL TABLE `kestra-orquestation.ny_city_taxi.external-yellow-tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://kestra-zoom-camp-data-enginering/ny_city_taxi_data/*.parquet']
);

--check wether there is data
select * from `kestra-orquestation.ny_city_taxi.external-yellow-tripdata` limit 10;


--check regular table non-partitioned
CREATE OR REPLACE TABLE `kestra-orquestation.ny_city_taxi.yellow-tripdata-no-patitioned` AS
select * from `kestra-orquestation.ny_city_taxi.external-yellow-tripdata`;

--query for question 2
EXPLAIN SELECT COUNT(DISTINCT PULocationID) FROM `kestra-orquestation.ny_city_taxi.external-yellow-tripdata`;


select count(distinct PULocationID) from `kestra-orquestation.ny_city_taxi.external-yellow-tripdata`;

select count(distinct PULocationID) from `kestra-orquestation.ny_city_taxi.yellow-tripdata-no-patitioned`;

--question 4
select 
  count(*) 
from 
  `kestra-orquestation.ny_city_taxi.external-yellow-tripdata`
where
  fare_amount = 0;


--question 5
--Partitioning by tpep_dropoff_datetime
-- Since your queries always filter based on tpep_dropoff_datetime, partitioning by this column significantly reduces the amount of data scanned.
-- Each partition stores data for a specific range of tpep_dropoff_datetime, so BigQuery will only scan the necessary partitions rather than the entire dataset.
--
CREATE OR REPLACE TABLE `kestra-orquestation.ny_city_taxi.yellow-tripdata-partitioned-clustered`
  PARTITION BY DATE(tpep_dropoff_datetime)
  CLUSTER BY VendorID
  AS
  SELECT * 
  FROM  
  `kestra-orquestation.ny_city_taxi.external-yellow-tripdata`;


--question 6
-- non-partitioned data

 select 
  distinct VendorID 
from 
  `kestra-orquestation.ny_city_taxi.yellow-tripdata-no-patitioned`
where
  DATE(tpep_dropoff_datetime) between '2024-03-01' and '2024-03-15';

--partitioned data
 select 
  distinct VendorID 
from 
  `kestra-orquestation.ny_city_taxi.yellow-tripdata-partitioned-clustered`
where
  DATE(tpep_dropoff_datetime) between '2024-03-01' and '2024-03-15';  