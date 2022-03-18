select * from powr_viewership

//verizon media 
select * from revenue 
where pay_partner like '%izon%'
//1. monthly topline 
//2. powr viewership monthly share for fire tv and roku

select sum(share), platform, device_id, year_month_Day from powr_viewership
where platform like 'firetv'or platform like '%roku%'
group by platform, device_id, year_month_Day


select sum(share) device_id, year_month_Day from powr_viewership
group by device_id, year_month_Day


//total viewership by month for verizon
select sum(WATCH_TIME_SECONDS), year_month_Day from powr_viewership
where platform like 'firetv'or platform like '%roku%'
group by year_month_Day
 



insert into monthly_impressions(tot_impressions, year_month_day, partner)
select sum(TOTAL_IMPRESSIONS), year_month_day, 'gam' from gam_data
group by year_month_day

select TOTAL_IMPRESSIONS, TOTAL_IMPRESSIONS / m.tot_impressions as share,   AD_UNIT, month_year from gam_data g
join monthly_impressions m on (m.year_month_day = g.year_month_day)
where m.partner = 'gam'

update gam_data g
set g.share = q.share_c
from (
  select g.id as gid, TOTAL_IMPRESSIONS, TOTAL_IMPRESSIONS / m.tot_impressions as share_c,  AD_UNIT, month_year from gam_data g
  join monthly_impressions m on (m.year_month_day = g.year_month_day)
  where m.partner = 'gam'
) q
where q.gid = g.id


select sum(total_impressions), sum(share), year_month_day, ad_unit  from gam_data
group by ad_unit, year_month_day



select * from expenses
where partner = 'oao'


select share, impressions, year_month_day, ad_unit from gam_data
join expenses e
where e.partner = 'oao' and e.type = 'adserving'


create table monthly_expenses(
    department_id,
    device_id,
    partner_id,
)


alter table expenses add column department_id integer

select * from gam_data
select * from spotx
select * from powr_viewership

select CHANNEL_NAME from spotx
group by CHANNEL_NAME

select ad_unit from gam_data
group by ad_unit





select * from monthly_impressions where partner = 'gam'
select * from expenses where partner = 'oao' and 

insert into monthly_expenses(
    amount number(12, 4), 
    year_month_day varchar(8),
    department_id integer,
    title varchar(155),
    year number(4), 
    quarter varchar(2)
)

select * from gam_data g
join expenses e on (e.year_month_day = g.year_month_day)
where e.partner = 'oao' and e.type = 'adserving' and AD_EXCHANGE_REVENUE > 0

1
ios
2
2
firetv
3
3
web
4
4
android
5
5
roku
6
6
mobile/web
7
7
mobile/web/fire
8
8
nbc

select * from nosey_staging.public.departments

firetv
$407.87
$438.59
$438.85



mobile web
$561.41
$592.13
$704.09


select * from  revenue 
