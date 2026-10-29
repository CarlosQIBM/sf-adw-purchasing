{{ config(alias='STG_DIM_SHIP_METHOD') }}

with source as (

    select * from {{ ref('adw_core', 'brz_adventure_works_purchasing__ship_method') }}

),

renamed as (

    select
        ship_method_id  as ship_method_id,
        name            as ship_method_name,
        ship_base       as ship_method_minimum_charge_dollars,
        ship_rate       as ship_method_rate_per_pound_dollars,
        modified_date   as ship_method_modified_date
        -- dropped: rowguid
    from source

)

select * from renamed
