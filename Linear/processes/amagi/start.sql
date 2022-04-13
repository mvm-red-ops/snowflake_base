  select a.id as id, a.total_viewership_minutes, mv.tot_hov, (a.total_viewership_minutes / mv.tot_hov) as v_share, a.month, t.name from amagi_viewership a
  join territories t on (t.id = territory_id)
  join monthly_viewership mv on (mv.year_month_day = a.month and a.territory_id = mv.territoryid)
  where a.deal_parent = 23 and a.quarter = 'q3'
  order by t.name, a.month
  


-- NON TRC
UPDATE amagi_viewership av
SET av.calc_share = t.v_share 
FROM (
  select a.id as id, a.total_viewership_minutes, (a.total_viewership_minutes / mv.tot_hov) as v_share, a.month, t.name from amagi_viewership a
  join territories t on (t.id = territory_id)
  join monthly_viewership mv on (mv.year_month_day = a.month and a.territory_id = mv.territoryid)
  where a.deal_parent = 23 
  order by t.name, a.month
) t
WHERE av.id = t.id
    


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


