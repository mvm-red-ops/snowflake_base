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
