with source as (

    select * from {{ ref('SLV_DIM_ADVENTURE_WORKS_SHIP_METHOD') }}

),

with_surrogate_key as (

    select
        {{ dbt_utils.generate_surrogate_key(['ship_method_id']) }} as ship_method_key,
        ship_method_id,
        ship_method_name,
        ship_method_minimum_charge_dollars,
        ship_method_rate_per_pound_dollars
    from source

)

select * from with_surrogate_key
