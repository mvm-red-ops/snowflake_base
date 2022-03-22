

//GAM SHARE
select nd.name, month_year, sum(ad_exchange_revenue) from gam_data g
join dictionary.public.devices d  on (d.entry = g.AD_UNIT)
join nosey_staging.public.departments nd on (d.department_id = nd.id)
group by nd.name, month_year


select * from gam_data g
join nosey_staging.public.departments nd on (nd.name like concat('%',lower(g.device_name),'%'))
where advertiser = 'AdX'


//update department id
update gam_data g
set g.department_id = q.did
from (
  select g.id as gid, d.department_id as did from gam_data g
  join dictionary.public.devices d on (d.entry = g.device_name)
  where advertiser = 'AdX'
) q
where g.id = q.gid




select sum(AD_EXCHANGE_REVENUE), month_year, advertiser, nd.name from gam_data g
join nosey_staging.public.departments nd on (nd.id = g.department_id )
where advertiser = 'AdX'
group by advertiser, month_year, nd.name
order by nd.name, month_year desc



//gam - total impressions by month
select month_year, sum(TOTAL_IMPRESSIONS)  from gam_data g
join dictionary.public.devices d on (d.entry = g.DEVICE_NAME)
group by month_year

//AdX - total impressions by month/ device
select month_year,  term, sum(TOTAL_IMPRESSIONS)  from gam_data g
join dictionary.public.devices d on (d.entry = g.DEVICE_NAME)
where advertiser = 'AdX' 
group by month_year, term

//roku reps (reliant on gam impressions)
//1.get total impressions where roku is advertsier
//2.calculate monhtly share 
//3.break out total by monthly share  
//total - $10,446.00


//APS - total impressions by month/ device
select month_year, sum(ad_exchange_revenue), d.entry from gam_data g
join dictionary.public.devices d on (d.entry = g.DEVICE_NAME)
where advertiser like 'AdX%'
group by month_year,d.entry

select * from revenue 
where advertiser like 'Amazon Publisher%'
//$4,951.91
//$9,124.46
//$13,099.90


-- //adx is summed on record level
select sum(AD_EXCHANGE_REVENUE),YEAR_MONTH_DAY, department_id from gam_data 
where advertiser = 'AdX'
group by YEAR_MONTH_DAY,department_id