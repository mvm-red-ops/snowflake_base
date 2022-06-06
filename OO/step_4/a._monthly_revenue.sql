-- The first big goal to hit with revenue data is to break it out monthly and by department
-- Some of the revenue is already broken out this way coincidentally, for example: 
    -- 47 Samurai is only in the Roku department, and is broken out monthly, so there is no further breakout needed 
-- Other revenue payments are not broken out this way and need to be broken out by running queries, for ex:
    -- Roku Reps is paid in a quarterly sum, but is also only on Roku, so no need to break out by department
    -- the monthly revenue is calculated by the gam_impression share  

--REMINDER: Be sure to update the relevant year and quarter for each statement!

-- spotx revenue 
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select sum(spotx_revenue) as revenue, year_month_Day, department_id, 'spotx' from spotx
where department_id is not null and channel_name not like '%Tegna%' and year = 20XX and quarter = 'qX'
group by year_month_Day, department_id


-- pubmatic revenue 
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select sum(pub_revenue), YEAR_MONTH_DAY,s.department_id, 'pubmatic' from spotx s
join nosey_staging.public.departments nd on (nd.id = s.department_id)
where pub_share is not null and year = 20XX and quarter = 'qX'
group by YEAR_MONTH_DAY, s.department_id


--adx is summed on record level
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select sum(AD_EXCHANGE_REVENUE),YEAR_MONTH_DAY, department_id, 'adx' from gam_data 
where advertiser = 'AdX' and year = 20XX and quarter = 'qX'
group by YEAR_MONTH_DAY, department_id


-- amazon publisher services
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select amount, year_month_day, 2, 'amazon publisher services' from revenue 
where pay_partner like '%amazon%' and year = 20XX and quarter = 'qX'


-- 47 samurai
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select amount, year_month_day, 5, '47 samurai' from revenue 
where pay_partner like '%47%' and year = 20XX and quarter = 'qX'


-- glewedTv
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select amount, year_month_day, 5, 'glewedtv' from revenue
where pay_partner = 'glewedtv' and year = 20XX and quarter = 'qX'


-- video bridge
    -- roku
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select amount, year_month_day, 5, 'videobridge'  from revenue
    where pay_partner like '%videobridge - roku%' and year = 20XX and quarter = 'qX'

    -- firetv
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select amount, year_month_day, 2, 'videobridge'  from revenue
    where pay_partner like '%videobridge - firetv%' and year = 20XX and quarter = 'qX'


-- verizon
    -- roku
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select amount, year_month_day, 5, 'verizon'  from revenue
    where pay_partner like '%verizon - roku%' and year = 20XX and quarter = 'qX'

    -- firetv
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select amount, year_month_day, 2, 'verizon'  from revenue
    where pay_partner like '%verizon - firetv%' and year = 20XX and quarter = 'qX'



-- Roku Reps
-- Since roku reps pays in a quarterly sum, we need to calculate a share to breakout the monthly revenue.
-- For this we use spotx impressions
        -- get total impressions for roku reps deals in spotx
        select sum(impressions) from spotx 
        where DEAL_NAME like '%Reps%'


        -- use impressions of deals with roku reps to get share to break out revenue into months
        select (sum(s.impressions) / PUT_TOTAL_IMPRESSIONS_FROM_ABOVE_HERE), s.year_month_day from spotx s
        where DEAL_NAME like '%Reps%' 
        group by s.year_month_day 



        -- get revenue breakout by month
        with 
        monthly as
        (
                select (sum(s.impressions) / PUT_TOTAL_IMPRESSIONS_FROM_ABOVE_HERE) as share, s.year_month_day as ymd, 'rokureps' from spotx s
                where DEAL_NAME like '%Reps%' 
                group by s.year_month_day
            ) 
        select  revenue * monthly.share, monthly.ymd from revenue r, monthly where pay_partner = 'roku reps'


        -- manually update the values in the insert statement and get each months revenue into monthly_revenue table
        insert into monthly_revenue(tot_revenue, year_month_day, partner, department_id)
        VALUES (MANUALLY_PUT_REV_HERE , MANUALLY_PUT_YEAR_MONTH_DAY_HERE, 'roku reps', 5)
