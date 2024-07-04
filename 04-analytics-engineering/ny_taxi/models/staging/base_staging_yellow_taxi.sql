with tripdata as 
(
    select * 
		, row_number() over(partition by "VendorID", tpep_dropoff_datetime) as rn
	from {{ source('staging', 'yellow_taxi') }}
)

select
	-- identifiers
	{{ dbt_utils.generate_surrogate_key(['"VendorID"', 'tpep_pickup_datetime']) }} as tripid
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
	, {{get_payment_type_description("payment_type")}} as payment_type_description
from tripdata
where
	rn = 1

{% if var('is_test_run', default=true) %}
limit 100
{% endif %}