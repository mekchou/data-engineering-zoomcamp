
  create view "ny_taxi"."public_staging"."dim_zones__dbt_tmp"
    
    
  as (
    select
    locationid
    , borough
    , zone
    , replace(service_zone, 'Boro', 'Green') as service_zone
from "ny_taxi"."public_staging"."taxi_zone_lookup"
  );