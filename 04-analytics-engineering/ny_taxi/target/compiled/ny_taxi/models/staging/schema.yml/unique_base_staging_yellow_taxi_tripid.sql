
    
    

select
    tripid as unique_field,
    count(*) as n_records

from "ny_taxi"."public_staging"."base_staging_yellow_taxi"
where tripid is not null
group by tripid
having count(*) > 1


