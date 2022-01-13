-- create monthly sum and insert
insert into monthly_revenue (deal_parent, year,quarter,revenue, year_month_Day, channel)
  with r as
    (
      select  sum(revenue) as rev, year_month_day, channel
      from revenue
      where deal_parent = 21 and quarter = 'q3' and year = 2021
      group by year_month_day, channel 
    ) 
  select 21, 2021, 'q3', r.rev, r.year_month_day, r.channel
  from r;
  