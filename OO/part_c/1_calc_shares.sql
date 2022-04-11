-- gam_data 
    -- 1. impression share
        insert into monthly_impressions(tot_impressions, year_month_day, partner)
        select sum(TOTAL_IMPRESSIONS), year_month_day, 'gam' from gam_data
        group by year_month_day

        select TOTAL_IMPRESSIONS, TOTAL_IMPRESSIONS / m.tot_impressions as share,   AD_UNIT, month_year from gam_data g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where m.partner = 'gam'

        update gam_data g
        set g.share = q.share_c
        from (
        select TOTAL_IMPRESSIONS, TOTAL_IMPRESSIONS / m.tot_impressions as share,   AD_UNIT, month_year from gam_data g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where m.partner = 'gam'
        ) q


    -- 2. oao_share (for oao adserving)
        -- create share by ad unit 
        update gam_data g
        set g.oao_share = q.oao
        from (
        select g.id as gid, total_impressions / m.tot_impressions as oao ,g.year_month_day, ad_unit from gam_data g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where  m.partner = 'gam' 
        ) q
        where q.gid = g.id

        -- check (should == 1)
        select sum(oao_share), g.year_month_day from gam_data g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where  m.partner = 'gam'
        group by g.year_month_day





-- powr viewership

    -- powr viewership by dept ad month
    select sum(watch_time_secods), d.id, d.name, year_month_day, 'powr viewership share' as usage  from powr_viewership p
    join nosey_staging.public.departments d on (d.id = p.department_id)
    group by d.name, p.year_month_day, d.id


    -- insert viewership by dept ad month
    insert into  monthly_viewership(tot_viewership, department_id, department_name, year_month_day, usage, quarter )
    select sum(watch_time_secods), d.id, d.name, year_month_day, 'powr viewership share' as usage, 'q4'  from powr_viewership p
    join nosey_staging.public.departments d on (d.id = p.department_id)
    group by d.name, p.year_month_day, d.id


    -- update share on records
    update powr_viewership p
    set p.share = q.powr_share
    from
    (
    select p.id as id, ref_id, WATCH_TIME_SECOdS / mv.TOT_VIEWERSHIP as powr_share, p.year_month_day, d.name   from powr_viewership p
    join monthly_viewership mv on (mv.year_month_day = p.year_month_day ad mv.department_id  = p.department_id)
    join nosey_staging.public.departments d on (d.id = p.department_id)
    where mv.usage = 'powr viewership share'
    ) q
    where p.id = q.id

