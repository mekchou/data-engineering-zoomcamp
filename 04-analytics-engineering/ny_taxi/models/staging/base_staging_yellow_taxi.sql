with source as (
      select * from {{ source('staging', 'yellow_taxi') }}
),
renamed as (
    select
    	"VendorID"
	    , tpep_pickup_datetime
	    , tpep_dropoff_datetime
	    , passenger_count
	    , trip_distance
	    , "RatecodeID"
	    , store_and_fwd_flag
	    , "PULocationID"
	    , "DOLocationID"
	    , {{get_payment_type_description("payment_type")}} as payment_type_descripted
	    , fare_amount
	    , extra
	    , mta_tax
	    , tip_amount
	    , tolls_amount
	    , improvement_surcharge
	    , total_amount
	    , congestion_surcharge

    from source
)
select * from renamed
  