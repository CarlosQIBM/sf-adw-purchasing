with source as (

    select * from {{ ref('adw_core', 'brz_adventure_works_purchasing__product_vendor') }}

),

renamed as (

    select
        product_id                  as product_id,
        business_entity_id          as business_entity_id,
        unit_measure_code           as unit_measure_code,
        average_lead_time           as product_vendor_average_lead_time_days,
        standard_price              as product_vendor_standard_price_dollars,
        last_receipt_cost           as product_vendor_last_receipt_cost_dollars,
        last_receipt_date::date     as product_vendor_last_receipt_date,
        min_order_qty               as product_vendor_min_order_qty,
        max_order_qty               as product_vendor_max_order_qty,
        on_order_qty                as product_vendor_on_order_qty
        -- dropped: modified_date
    from source

)

select * from renamed