# Write your MySQL query statement below
with cte
as
(
    select row_number() over() as 'rowNum',
    x, y
    from Point2D
)

select ROUND(SQRT(POWER((c2.x - c1.x),2) + POWER((c2.y - c1.y),2)) ,2) as 'shortest'
from cte c1, cte c2 
where c1.rowNum != c2.rowNum
order by 1 limit 1