
    
    

with child as (
    select pickup_locationid as from_field
    from "ny_taxi"."public_staging"."base_staging_green_taxi"
    where pickup_locationid is not null
),

parent as (
    select locationid as to_field
    from "ny_taxi"."public_staging"."taxi_zone_lookup"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


