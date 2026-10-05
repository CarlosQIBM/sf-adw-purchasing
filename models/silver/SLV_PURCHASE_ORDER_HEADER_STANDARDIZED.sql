with source as (

    select * from {{ ref('adw_core', 'brz_adventure_works_purchasing__purchase_order_header') }}

),

renamed as (

    select
        purchase_order_id          as purchase_order_header_purchase_order_id,
        revision_number            as purchase_order_header_revision_number,
        status                     as purchase_order_header_status,
        case status
            when 1 then 'Pending'
            when 2 then 'Approved'
            when 3 then 'Rejected'
            when 4 then 'Complete'
        end                        as purchase_order_header_status_description,
        employee_id                as purchase_order_header_employee_id,
        vendor_id                  as purchase_order_header_vendor_id,
        ship_method_id             as purchase_order_header_ship_method_id,
        cast(order_date as date)   as purchase_order_header_order_date,
        cast(ship_date as date)    as purchase_order_header_estimated_ship_date,
        sub_total                  as purchase_order_header_sub_total_dollars,
        tax_amt                    as purchase_order_header_tax_amount_dollars,
        freight                    as purchase_order_header_freight_cost_dollars,
        total_due                  as purchase_order_header_total_due_dollars
        -- dropped: modified_date
    from source

)

select * from renamed
