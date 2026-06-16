with orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

final as (
    select
        order_id,
        customer_id,
        amount

    from orders

    left join payments using (order_id)
)

-- granularity is order-payment; 1 order to multiple payments
select * from final
