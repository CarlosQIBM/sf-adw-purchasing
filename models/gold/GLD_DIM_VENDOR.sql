{{ config(
    materialized='view'
) }}

with source as (

    select * from {{ ref('SLV_PURCHASING_VENDOR_STANDARDIZED') }}

),

with_surrogate_key as (

    select
        {{ dbt_utils.generate_surrogate_key(['business_entity_id']) }} as vendor_id,
        business_entity_id,
        vendor_account_number,
        vendor_company_name as vendor_name,
        vendor_credit_rating,
        case vendor_credit_rating
            when 1 then 'Superior'
            when 2 then 'Excellent'
            when 3 then 'Good'
            when 4 then 'Average'
            when 5 then 'Below Average'
            else 'Unknown'
        end as vendor_credit_rating_description,
        vendor_is_preferred,
        vendor_is_active,
        vendor_purchasing_web_service_url
    from source

)

select * from with_surrogate_key
