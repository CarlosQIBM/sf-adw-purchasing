with source as (

    select * from {{ ref('adw_core', 'brz_adventure_works_purchasing__purchase_order_detail') }}

),

renamed as (

    select
        purchase_order_id        as purchase_order_detail_purchase_order_id,
        purchase_order_detail_id as purchase_order_detail_id,
        cast(due_date as date)    as purchase_order_detail_expected_receipt_date,
        order_qty                as purchase_order_detail_ordered_qty,
        product_id               as purchase_order_detail_product_id,
        unit_price               as purchase_order_detail_unit_price_dollars,
        line_total               as purchase_order_detail_line_total_dollars,
        received_qty             as purchase_order_detail_received_qty,
        rejected_qty             as purchase_order_detail_rejected_qty,
        stocked_qty              as purchase_order_detail_stocked_qty
        -- dropped: modified_date
    from source

)

select * from renamed
