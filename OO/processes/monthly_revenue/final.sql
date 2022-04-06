

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


-- //adx is summed on record level
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
