
  create view "ny_taxi"."public_staging"."src_green__dbt_tmp"
    
    
  as (
    SELECT * FROM "ny_taxi"."public"."green_taxi"
  );