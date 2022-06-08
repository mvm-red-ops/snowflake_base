

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





set month = 7, quarter = 'q3' where year_month_day in ('20210701', '20200701', '20190701', '20180701')
set month = 8, quarter = 'q3' where year_month_day in ('20210801', '20200801', '20190801', '20180801')
set month = 9, quarter = 'q3' where year_month_day in ('20210901', '20200901', '20190901', '20180901')
set month = 10, quarter = 'q4' where year_month_day in ('20211001', '20201001', '20191001', '20181001')
set month = 11, quarter = 'q4' where year_month_day in ('20211101', '20201101', '20191101', '20181101')
set month = 12, quarter = 'q4' where year_month_day in ('20211201', '20201201', '20191201', '20181201')

