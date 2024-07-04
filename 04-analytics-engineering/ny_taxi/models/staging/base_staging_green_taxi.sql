with source as (
      select * from {{ source('staging', 'green_taxi') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  