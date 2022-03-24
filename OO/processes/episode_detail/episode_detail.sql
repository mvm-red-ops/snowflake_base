-- //roku and firetv
select sum(tot_revenue), department_id,year_month_day from monthly_revenue
where department_id in (2, 5)
group by year_month_day,department_id

-- //mobile/web
select sum(tot_revenue),0,  year_month_day from monthly_revenue
where department_id not in (2, 5)
group by year_month_day





--   //roku and firetv update
update powr_viewership  p
set p.rev_share = q.rev_share
from(
    select p.id as id, ref_id, WATCH_TIME_SECONDS, platform, p.year_month_Day,p.SHARE * r.revenue as rev_share, p.content_provider  from powr_viewership p
    join nosey_staging.public.devices d on (d.id = p.device_id)
    join nosey_staging.public.departments nd on (nd.id = d.department_id)
    join rev_pool r on (p.year_month_day = r.year_month_day and d.department_id = r.department_id) 
    where r.department_id != 0
    order by ref_id asc
) q 
where p.id = q.id 


-- //mobile/web update
update powr_viewership  p
set p.rev_share = q.rev_share
from(
    select p.id as id, ref_id, WATCH_TIME_SECONDS, platform, p.year_month_Day,p.SHARE * r.revenue as rev_share, p.content_provider  from powr_viewership p
    join nosey_staging.public.devices d on (d.id = p.device_id)
    join nosey_staging.public.departments nd on (nd.id = d.department_id)
    join rev_pool r on (p.year_month_day = r.year_month_day) 
    where r.department_id = 0 and d.department_id not in (2,5)
    order by ref_id asc
) q 
where p.id = q.id 



select * from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
join rev_pool r on (p.year_month_day = r.year_month_day) 
where r.department_id = 0 and d.department_id not in (2,5)
order by ref_id asc


select ref_id, content_provider, sum(rev_share) from powr_viewership
group by content_provider, ref_id


with mobile_web ,

    firetv, 
    roku





//roku and firetv
select sum(tot_revenue), department_id,year_month_day from monthly_revenue
where department_id in (2, 5)
group by year_month_day,department_id

//mobile/web
select sum(tot_revenue),0,  year_month_day from monthly_revenue
where department_id not in (2, 5)
group by year_month_day


select * from rev_pool


  //roku and firetv update
update powr_viewership  p
set p.rev_share = q.rev_share
from(
    select p.id as id, ref_id, WATCH_TIME_SECONDS, platform, p.year_month_Day,p.SHARE * r.revenue as rev_share, p.content_provider  from powr_viewership p
    join nosey_staging.public.devices d on (d.id = p.device_id)
    join nosey_staging.public.departments nd on (nd.id = d.department_id)
    join rev_pool r on (p.year_month_day = r.year_month_day and d.department_id = r.department_id) 
    where r.department_id != 0
    order by ref_id asc
) q 
where p.id = q.id 


//mobile/web update
update powr_viewership  p
set p.rev_share = q.rev_share
from(
    select p.id as id, ref_id, WATCH_TIME_SECONDS, platform, p.year_month_Day,p.SHARE * r.revenue as rev_share, p.content_provider  from powr_viewership p
    join nosey_staging.public.devices d on (d.id = p.device_id)
    join nosey_staging.public.departments nd on (nd.id = d.department_id)
    join rev_pool r on (p.year_month_day = r.year_month_day) 
    where r.department_id = 0 and d.department_id not in (2,5)
    order by ref_id asc
) q 
where p.id = q.id 



select * from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
join rev_pool r on (p.year_month_day = r.year_month_day) 
where r.department_id = 0 and d.department_id not in (2,5)
order by ref_id asc


select ref_id, content_provider, sum(rev_share) from powr_viewership
group by content_provider, ref_id





