# Write your MySQL query statement below 
with cte as
(
    select customer_id, 
        year(order_date) as 'year'
        ,sum(price) as 'price'
        from Orders
        group by 2, customer_id
        order by customer_id, 2

), cte2 as
(
select *, ifnull(lag(year) over (partition by customer_id order by year), year-1) as 'prev_year' ,
ifnull(lag(price) over (partition by customer_id order by year), 0) as 'prev_total' 
from cte
),
cte3 as
(
    select *, if(year-prev_year = 1, 0, -100000000) as 'year_ok'
    , if(price > prev_total, 0, -10000000) as 'price_ok'
    from cte2
    order by customer_id
)

select customer_id from cte3
group by customer_id
having sum(year_ok) = 0 and sum(price_ok) = 0
order by customer_id
