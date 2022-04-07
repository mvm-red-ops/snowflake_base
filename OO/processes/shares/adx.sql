select * from gam_data where advertiser = 'AdX'

    //AdX Revenue
    select sum(ad_exchange_revenue), year_month_day, department_id from gam_data where advertiser = 'AdX'
    group by year_month_day, department_id
    
    //insert AdX revenue into monthly_revenue
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select sum(AD_EXCHANGE_REVENUE),YEAR_MONTH_DAY, department_id, 'adx' from gam_data 
    where advertiser = 'AdX'
    group by YEAR_MONTH_DAY,department_id
