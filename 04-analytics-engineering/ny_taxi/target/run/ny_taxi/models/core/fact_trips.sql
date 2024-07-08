
  
    

  create  table "ny_taxi"."public_staging"."fact_trips__dbt_tmp"
  
  
    as
  
  (
    

with green_tripdata as (
    select *
        , 'Green' as service_type
    from "ny_taxi"."public_staging"."base_staging_green_taxi"
)
, yellow_tripdata as (
    select *
        , 'yellow' as service_type
    from "ny_taxi"."public_staging"."base_staging_yellow_taxi"
)

, trips_unioned as(
    select *
    from green_tripdata
    union all
    select *
    from yellow_tripdata
)
, dim_zones as(
    select *
    from "ny_taxi"."public_staging"."dim_zones"
    where
        borough != 'Unknown'
)

select 
    trips_unioned.*
from trips_unioned
    inner join dim_zones as pickup_zone
        on pickup_zone.locationid = trips_unioned.pickup_locationid
    inner join dim_zones as dropoff_zone
        on dropoff_zone.locationid = trips_unioned.dropoff_locationid
  );
  