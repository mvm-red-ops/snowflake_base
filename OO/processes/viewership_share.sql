

//spotx rev by month, platform
select sum(gross_revenue), year_month_day, d.name from spotx 
join nosey_archive.public.devices d on (d.id = device_id)
where channel_name not like '%Tegna%' 
group by year_month_day, device_id, d.name


//pubmatic share by impressions, month



select * from spotx

//powr viewership share

select * from powr_viewership p

//powr viewership by month/platform 
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





 


