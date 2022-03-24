with 
    mobile_web as (
        select ref_id, sum(views) as mviews, sum(watch_time_seconds) / 60 as watched, sum(rev_share) as rev from powr_viewership p
        join nosey_staging.public.devices d on (d.id = p.device_id)
        join nosey_staging.public.departments nd on (nd.id = d.department_id)
        where d.department_id not in (2,5)
        group by ref_id
    ),
    firetv as (
        select ref_id, sum(views) as mviews, sum(watch_time_seconds) / 60 as watched, sum(rev_share) as rev from powr_viewership p
        join nosey_staging.public.devices d on (d.id = p.device_id)
        join nosey_staging.public.departments nd on (nd.id = d.department_id)
        where d.department_id = 2
        group by ref_id
      ),
      roku as (
        select ref_id, sum(views) as mviews, sum(watch_time_seconds) / 60 as watched, sum(rev_share) as rev from powr_viewership p
        join nosey_staging.public.devices d on (d.id = p.device_id)
        join nosey_staging.public.departments nd on (nd.id = d.department_id)
        where d.department_id = 5
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
