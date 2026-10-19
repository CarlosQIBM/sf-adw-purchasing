-- Gold buyer dimension. One row per employee who has placed at least one purchase order.
-- "Buyer" is decided by behavior (appears as employee_id on a PO header), not by job title
-- or person_type. buyer_key is core's person_key, selected and never recalculated.
-- SCD Type 1. No Unknown row.

with buyers as (

    select distinct
        purchase_order_header_employee_id as business_entity_id
    from {{ ref('SLV_PURCHASING_ORDER_HEADER_STANDARDIZED') }}

),

person as (

    select
        person_key,
        business_entity_id,
        person_full_name,
        person_sort_name
    from {{ ref('adw_core', 'slv_adventure_works_person__person') }}

),

-- Decision 1, option (a): read core bronze employee and cast here until core ships
-- slv_employee. When it does, swap this CTE to ref('adw_core', 'slv_employee') and drop the casts.
-- HR PII (national_idnumber, login_id, birth_date, marital_status, gender, salaried_flag,
-- vacation_hours, sick_leave_hours) and organization_node are deliberately not selected.
employee as (

    select
        business_entity_id,
        job_title,
        cast(organization_level as integer) as organization_level,
        cast(hire_date as date)             as hire_date,
        cast(current_flag as boolean)       as is_active
    from {{ ref('adw_core', 'brz_adventure_works_human_resources__employee') }}

),

final as (

    select
        person.person_key               as buyer_key,
        person.business_entity_id       as buyer_id,
        person.person_full_name         as buyer_full_name,
        person.person_sort_name         as buyer_sort_name,
        employee.job_title              as buyer_job_title,
        employee.organization_level     as buyer_organization_level,
        employee.hire_date              as buyer_hire_date,
        employee.is_active              as buyer_is_active
    from buyers
    inner join person
        on buyers.business_entity_id = person.business_entity_id
    left join employee
        on buyers.business_entity_id = employee.business_entity_id

)

select * from final
