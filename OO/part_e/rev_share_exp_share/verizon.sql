
-- total viewership by month for verizon
select sum(WATCH_TIME_SECONDS), year_month_Day from powr_viewership
where department_id in (2,5)
group by year_month_Day
 



insert into monthly_impressions(tot_impressions, year_month_day, partner)
select sum(TOTAL_IMPRESSIONS), year_month_day, 'gam' from gam_data
group by year_month_day


update gam_data g
set g.share = q.share_c
from (
  select g.id as gid, TOTAL_IMPRESSIONS, TOTAL_IMPRESSIONS / m.tot_impressions as share_c,  AD_UNIT, month_year from gam_data g
  join monthly_impressions m on (m.year_month_day = g.year_month_day)
  where m.partner = 'gam'
) q
where q.gid = g.id




select * from gam_data g
join expenses e on (e.year_month_day = g.year_month_day)
where e.partner = 'oao' and e.type = 'adserving' and AD_EXCHANGE_REVENUE > 0