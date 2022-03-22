-- gam share for OAO expenses


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


