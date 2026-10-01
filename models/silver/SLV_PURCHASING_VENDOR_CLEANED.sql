with source as (

    select * from {{ ref('adw_core', 'brz_adventure_works_purchasing__vendor') }}

),

renamed as (

    select
        business_entity_id                          as business_entity_id,
        account_number                              as vendor_account_number,
        name                                        as vendor_company_name,
        credit_rating                               as vendor_credit_rating,
        cast(preferred_vendor_status as boolean)    as vendor_is_preferred,
        cast(active_flag as boolean)                as vendor_is_active,
        purchasing_web_service_url                  as vendor_purchasing_web_service_url
        -- dropped: modified_date
    from source

)

select * from renamed
