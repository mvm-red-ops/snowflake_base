-- powr viewership
    -- powr viewership by dept and month
    select sum(watch_time_seconds), d.id, d.name, year_month_day, 'powr viewership share' as usage from powr_viewership p
    join nosey_staging.public.departments d on (d.id = p.department_id)
    where quarter = 'qX' and year = 202X
    group by d.name, p.year_month_day, d.id


    -- insert viewership by dept and month
    insert into  monthly_viewership(tot_viewership, department_id, department_name, year_month_day, usage, quarter)
    select sum(watch_time_seconds), d.id, d.name, year_month_day, 'powr viewership share' as usage, 'qX' from powr_viewership p
    join nosey_staging.public.departments d on (d.id = p.department_id)
    where quarter = 'qX' and year = 202X
    group by d.name, p.year_month_day, d.id


    -- update share on records
    update powr_viewership p
    set p.share = q.powr_share
    from
    (
    select p.id as id, ref_id, WATCH_TIME_SECONDS / mv.TOT_VIEWERSHIP as powr_share, p.year_month_day, d.name from powr_viewership p
    join monthly_viewership mv on (mv.year_month_day = p.year_month_day and mv.department_id  = p.department_id)
    join nosey_staging.public.departments d on (d.id = p.department_id)
    where mv.usage = 'powr viewership share' and p.year = 202X and quarter = 'qX'
    ) q
    where p.id = q.id
