
select WATCH_TIME_SECONDS / mv.TOT_VIEWERSHIP as share, p.year_month_day, nd.name   from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join monthly_viewership mv on (mv.year_month_day = p.year_month_day and mv.department_id  = d.department_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
where mv.usage = 'powr viewership share' 
order by share desc


//departments (roku, firetv) are self containted things
//its not arbitrary to split out powr viewership by roku_app, firetv and have each have their own shares


//monthly_viewership we need departments 
select tot_viewership, year_month_day, department_name from monthly_viewership
where department_name is not null



//powr viewership by dept and month
select sum(watch_time_seconds), nd.id, nd.name, year_month_day, 'powr viewership share' as usage  from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
group by nd.name, p.year_month_day, nd.id


//insert viewership by dept and month
insert into  monthly_viewership(tot_viewership, department_id, department_name, year_month_day, usage, quarter )
select sum(watch_time_seconds), nd.id, nd.name, year_month_day, 'powr viewership share' as usage, 'q4'  from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
group by nd.name, p.year_month_day, nd.id





//update share on records
update powr_viewership p
set p.share = q.powr_share
from
 (
  select p.id as id, ref_id, WATCH_TIME_SECONDS / mv.TOT_VIEWERSHIP as powr_share, p.year_month_day, nd.name   from powr_viewership p
  join nosey_staging.public.devices d on (d.id = p.device_id)
  join monthly_viewership mv on (mv.year_month_day = p.year_month_day and mv.department_id  = d.department_id)
  join nosey_staging.public.departments nd on (nd.id = d.department_id)
  where mv.usage = 'powr viewership share' 
 ) q
where p.id = q.id
