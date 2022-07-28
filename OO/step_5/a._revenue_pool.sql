

-- create revenue pool and insert
  -- fire tv and roku
  insert into rev_pool(revenue, department_id, year_month_day)
  select sum(tot_revenue), department_id, year_month_day 
  from monthly_revenue 
  where department_id in (2, 5)
  group by department_id, year_month_day
  
  -- non fire tv and roku
  insert into rev_pool(revenue, department_id, year_month_day)
  select sum(tot_revenue), 0, year_month_day 
  from monthly_revenue 
  where department_id not in (2, 5)
  group by year_month_day



-- roku and firetv update
update powr_viewership  p
set p.rev_share = q.rev_share
from(
    select p.id as id, ref_id, p.year_month_Day, p.SHARE * r.revenue as rev_share, p.content_provider from powr_viewership p
    join rev_pool r on (p.year_month_day = r.year_month_day and p.department_id = r.department_id) 
    where r.department_id != 0
    order by ref_id asc
) q 
where p.id = q.id 


-- mobile/web update
update powr_viewership  p
set p.rev_share = q.rev_share
from(
    select p.id as id, ref_id, p.year_month_Day, p.SHARE * r.revenue as rev_share, p.content_provider from powr_viewership p
    join rev_pool r on (p.year_month_day = r.year_month_day and p.department_id in (1,3,4)) 
    where r.department_id = 0
    order by ref_id asc
) q 
where p.id = q.id 



