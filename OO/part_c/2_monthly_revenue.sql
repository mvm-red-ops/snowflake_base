-- The first big goal to hit with revenue data is to break it out monthly and by department
-- Some of the revenue is already broken out this way coincidentally, for example: 
    -- 47 Samurai is only in the Roku department, and is broken out monthly, so there is no further breakout needed 
-- Other revenue payments are not broken out this way and need to be broken out by running queries, for ex:
    -- Roku Reps is paid in a quarterly sum, but is also only on Roku, so no need to break out by department
    -- the monthly revenue is calculated by the gam_impression share  


-- AdX records
select * from gam_data where advertiser = 'AdX'

    -- AdX Revenue
    select sum(ad_exchange_revenue), year_month_day, department_id from gam_data where advertiser = 'AdX'
    group by year_month_day, department_id
    
    -- insert AdX revenue into monthly_revenue
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select sum(AD_EXCHANGE_REVENUE),YEAR_MONTH_DAY, department_id, 'adx' from gam_data 
    where advertiser = 'AdX'
    group by YEAR_MONTH_DAY,department_id




-- Roku Reps
-- use impressions of deals with roku reps to get share to break out revenue into months
insert into monthly_revenue(tot_revenue, year_month_day, partner)
select (sum(g.impressions) / 157651) * r.revenue as rokureps_rev, g.year_month_day, 'rokureps' from spotx g
join revenue r
where DEAL_NAME like '%Reps%' and r.pay_partner = 'roku reps'
group by g.year_month_day , r.revenue



-- insert the monthly rev into table
select (sum(g.impressions) / 157651) * r.revenue as rokureps_rev, g.year_month_day, 'rokureps' from spotx g
join revenue r
where DEAL_NAME like '%Reps%' and r.pay_partner = 'roku reps'
group by g.year_month_day , r.revenue





-- spotx revenue 
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select sum(spotx_revenue) as revenue, year_month_Day, department_id, 'spotx' from spotx
where department_id is not null and channel_name not like '%Tegna%'
group by year_month_Day, department_id


-- pubmatic revenue 
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select sum(pub_revenue), YEAR_MONTH_DAY,s.department_id, 'pubmatic' from spotx s
join nosey_staging.public.departments nd on (nd.id = s.department_id)
where pub_share is not null
group by YEAR_MONTH_DAY, s.department_id


--adx is summed on record level
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select sum(AD_EXCHANGE_REVENUE),YEAR_MONTH_DAY, department_id, 'adx' from gam_data 
where advertiser = 'AdX'
group by YEAR_MONTH_DAY,department_id


-- amazon publisher services
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select revenue, year_month_day, 2, 'amazon publisher services' from revenue 
where PAY_PARTNER like 'amazon%'


-- 47 samurai
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select revenue, year_month_day, 5, '47 samurai' from revenue 
where filename like '%47%' and year_month_day in ('20211001', '20211101', '20211201')


-- glewedTv
insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
select revenue, year_month_day, 5, 'glewedtv' from revenue
where pay_partner = 'glewedTv'


-- video bridge
    -- roku
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select revenue, year_month_day, 5, 'videobridge'  from revenue
    where pay_partner like '%videobridge - roku%'

    -- firetv
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select revenue, year_month_day, 2, 'videobridge'  from revenue
    where pay_partner like '%videobridge - firetv%'
