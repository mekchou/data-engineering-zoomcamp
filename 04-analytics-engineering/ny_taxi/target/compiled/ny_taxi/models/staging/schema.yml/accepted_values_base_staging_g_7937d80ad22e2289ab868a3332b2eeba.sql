
    
    

with all_values as (

    select
        Payment_type as value_field,
        count(*) as n_records

    from "ny_taxi"."public_staging"."base_staging_green_taxi"
    group by Payment_type

)

select *
from all_values
where value_field not in (
    1,2,3,4,5
)


