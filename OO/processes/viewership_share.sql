

//spotx rev by month, platform
select sum(gross_revenue), year_month_day, d.name from spotx 
join nosey_archive.public.devices d on (d.id = device_id)
where channel_name not like '%Tegna%' 
group by year_month_day, device_id, d.name


//pubmatic share by impressions, month



select * from spotx

-- powr viewership share

select * from powr_viewership p

-- powr viewership by month/platform 
select sum(WATCH_TIME_SECONDS) as tot_viewership , year_month_day, d.name device_name from powr_viewership 
join  nosey_archive.public.devices d on (d.id = device_id)
group by year_month_day,  d.name
order by year_month_day


insert into monthly_viewership(
    tot_viewership, 
    year_month_day, 
    device_name
) 
select sum(WATCH_TIME_SECONDS), year_month_day, d.name from powr_viewership 
join  nosey_archive.public.devices d on (d.id = device_id)
group by year_month_day,  d.name


select * from monthly_viewership





//powr viewership by month/platform 
update powr_viewership pv
set pv.share = q.share
from (
  select p.id as pid, WATCH_TIME_SECONDS / mv.tot_viewership as share , p.year_month_day, d.name device_name from powr_viewership p
  join  nosey_archive.public.devices d on (d.id = device_id)
  join  monthly_viewership mv on (mv.year_month_day = p.year_month_day and mv.device_id = p.device_id)
) q
where q.pid = pv.id





 




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





