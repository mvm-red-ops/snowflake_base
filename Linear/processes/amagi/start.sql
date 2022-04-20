

select sum(revenue), year_month_day, territory_id from revenue where quarter = 'q3' and deal_parent = 23 group by year_month_day, territory_id


insert into monthly_revenue(revenue, year_month_day, year, quarter,territory_id ,deal_parent)
select sum(revenue), year_month_day, 2021, 'q3', territory_id, 23 from revenue where quarter = 'q3' and deal_parent = 23 group by year_month_day, territory_id




  select calc_revenue, calc_share * q.revenue as calced_revenue
  FROM amagi_viewership w
  join monthly_revenue q on (q.year_month_day = w.month  and q.deal_parent = w.deal_parent and q.territory_id = w.territory_id)
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 23
  
  
  

-- NON TRC
UPDATE amagi_viewership wv
SET wv.calc_revenue = t.calced_revenue 
FROM (
  -- calculated share 
  select w.id as id, calc_share * q.revenue as calced_revenue
  FROM amagi_viewership w
  join monthly_revenue q on (q.year_month_day = w.month  and q.deal_parent = w.deal_parent and q.territory_id = w.territory_id)
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 23
) t
WHERE  wv.id = t.id 


