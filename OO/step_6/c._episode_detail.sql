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



-- full episode detail query
with 
    mobile_web as (
        select ref_id, sum(views) as mviews, sum(watch_time_seconds) / 60 as watched, sum(rev_share) as rev from powr_viewership p
        join nosey_staging.public.departments d on (d.id = p.department_id)
        where p.department_id not in (2,5)
        group by ref_id
    ),
    firetv as (
        select ref_id, sum(views) as mviews, sum(watch_time_seconds) / 60 as watched, sum(rev_share) as rev from powr_viewership p
        join nosey_staging.public.departments d on (d.id = p.department_id)
        where p.department_id = 2
        group by ref_id
      ),
      roku as (
        select ref_id, sum(views) as mviews, sum(watch_time_seconds) / 60 as watched, sum(rev_share) as rev from powr_viewership p
        join nosey_staging.public.departments d on (d.id = p.department_id)
        where p.department_id = 5
        group by ref_id
    )
    select mobile_web.ref_id, mobile_web.mviews as mobile_web_views, roku.mviews as roku_views, 
    mobile_web.watched as mobile_web_min_watched,firetv.watched as firetv_min_watched, roku.watched as roku_min_watched,
    mobile_web.rev as mobile_web_rev, firetv.rev as firetv_rev, roku.rev as roku_rev, 
    mobile_web_views + roku_views as total_views, mobile_web_min_watched +  firetv_min_watched + roku_min_watched as total_min_watched,  mobile_web_rev + firetv_rev + roku_rev as total_rev
    from mobile_web
    join firetv on (mobile_web.ref_id = firetv.ref_id)
    join roku on (roku.ref_id = mobile_web.ref_id)
    order by ref_id asc
