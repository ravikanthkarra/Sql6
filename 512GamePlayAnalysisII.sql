# Write your MySQL query statement below
select a.player_id, a.device_id 
from Activity a, 
(select player_id, min(event_date) as 'dt'
from Activity a
group by player_id) as p
where a.player_id = p.player_id and a.event_date = p.dt