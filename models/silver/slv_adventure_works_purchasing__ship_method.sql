with source as (

    select * from {{ ref('adw_core', 'brz_adventure_works_purchasing__ship_method') }}

),

renamed as (

    select
        ship_method_id  as ship_method_id,
        name            as ship_method_company_name,
        ship_base       as ship_method_minimum_charge,
        ship_rate       as ship_method_rate_per_pound
        -- dropped: rowguid, modified_date
    from source

)

select * from renamed