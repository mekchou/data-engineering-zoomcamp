with source as (
      select * from {{ source('staging', 'yellow_taxi') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  