//monthly viewership - sum viewership minutes, grouped. by department and year_month_day
//content provider viewership - sum viewership minutes grouped by content_provider and year_month_day and department
//content provider share is determined by content provider viewership / monthly_viewership 

select sum(watch_time_seconds),CONTENT_PROVIDER from powr_viewership
group by CONTENT_PROVIDER




select * from monthly_viewership
where usage = 'powr viewership share'
order by year_month_Day, department_id




select d.department_id, p.year_month_day,sum(watch_time_seconds) from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
group by  d.department_id, p.year_month_day
order by p.year_month_Day, d.department_id


//content provider share is determined by total viewership 
insert into content_provider_share (content_provider, department_id, year_month_day, total_viewership)
select p.CONTENT_PROVIDER, d.department_id, p.year_month_day,sum(watch_time_seconds) from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
group by p.CONTENT_PROVIDER, d.department_id, p.year_month_day
order by p.year_month_Day, d.department_id






//set the share of the content provider so that we can multiply by revenue to get rev_share
update content_provider_share c
set c.cp_share = q.cp_share
from (
  select c.id as id, c.year_month_day,c.department_id,c.content_provider, c.total_viewership / mv.tot_viewership as cp_share  from content_provider_share c
  join monthly_viewership mv on (mv.department_id = c.department_id and mv.year_month_day = c.year_month_day)
  where mv.usage = 'powr viewership share' and mv.department_id is not null 
) q
where c.id = q.id

//should roughly equal 1
select sum(cp_share) from content_provider_share
group by year_month_day, department_id


//overview of cp share by month and dept
select sum(cp_share), content_provider, year_month_day, department_id from content_provider_share
group by year_month_day, department_id, content_provider

//share query
select c.id as id, c.year_month_day,c.department_id,c.content_provider, c.total_viewership / mv.tot_viewership as cp_share  from content_provider_share c
join monthly_viewership mv on (mv.department_id = c.department_id and mv.year_month_day = c.year_month_day)
where mv.usage = 'powr viewership share' and mv.department_id is not null 


//revenue query
select c.id as id, c.year_month_day,c.department_id,c.content_provider, c.cp_share * mr.tot_revenue as rev_share, cp_share, partner from content_provider_share c
join monthly_revenue mr on (mr.department_id = c.department_id and mr.year_month_day = c.year_month_day)
where  mr.department_id is not null 

select * from monthly_revenue
select * from content_provider_share

insert into register (
    year_month_day,
    dpeartment_id, 
    content_provider, 
    rev_share, 
    cp_share,
    partner 
)
select c.year_month_day,c.department_id,c.content_provider, c.cp_share * mr.tot_revenue as rev_share, cp_share, partner from content_provider_share c
join monthly_revenue mr on (mr.department_id = c.department_id and mr.year_month_day = c.year_month_day)
where  mr.department_id is not null 








//regiser query
select year_month_day, nd.name,partner as title,  content_provider, cp_share as content_provider_share, rev_share as revenue from register r
join nosey_staging.public.departments nd on (nd.id = r.department_id)


