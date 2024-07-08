select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    tripid as unique_field,
    count(*) as n_records

from "ny_taxi"."public_staging"."base_staging_green_taxi"
where tripid is not null
group by tripid
having count(*) > 1



      
    ) dbt_internal_test