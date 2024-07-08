
  create view "ny_taxi"."public_staging"."base_staging_yellow_taxi__dbt_tmp"
    
    
  as (
    with tripdata as 
(
    select * 
		, row_number() over(partition by "VendorID", tpep_dropoff_datetime) as rn
	from "ny_taxi"."public"."yellow_taxi"
)

select
	-- identifiers
	md5(cast(coalesce(cast("VendorID" as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(tpep_pickup_datetime as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as tripid
	, "VendorID" as vendorid
    , "RatecodeID" as ratecodeid
    , "PULocationID" as pickup_locationid
    , "DOLocationID" as dropoff_locationid
	-- timestamps
    , tpep_pickup_datetime as pickup_datetime
    , tpep_dropoff_datetime as dropoff_datetime
    -- trip_info
	, store_and_fwd_flag
    , passenger_count
    , trip_distance
    -- yellow cabs are always street-hail
	, 1 as trip_type
	-- payment info
    , fare_amount
    , extra
    , mta_tax
    , tip_amount
    , tolls_amount
	, 0 as ehail_fee
    , improvement_surcharge
    , congestion_surcharge
    , total_amount
	, payment_type
	, case cast(payment_type as integer)
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
        else 'EMPTY'
    end as payment_type_description
from tripdata
where
	rn = 1


  );