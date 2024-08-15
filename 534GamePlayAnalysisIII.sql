# Write your MySQL query statement below
/*
select a1.player_id, a1.event_date
, (select sum(a2.games_played) from Activity a2 where a1.player_id = a2.player_id and a2.event_date <= a1.event_date) as 'games_played_so_far'
from Activity a1

*/

select player_id, event_date, SUM(games_played) over (Partition by player_id order by event_date) as 'games_played_so_far'
from Activity

