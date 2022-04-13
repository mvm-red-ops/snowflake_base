-- revenue calculation

-- NON TRC
UPDATE wurl_viewership wv
SET wv.revenue = t.calced_revenue 
FROM (
  -- calculated share 
  select w.id as id, share * q.revenue as calced_revenue
  FROM wurl_viewership w
  join monthly_revenue q on (q.year_month_day = w.month and q.channel_id = w.channel_id and q.deal_parent = w.deal_parent)
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 20 
) t
WHERE t.id = wv.id 

-- TRC
UPDATE wurl_viewership wv
SET wv.revenue = t.calced_revenue 
FROM (
  -- calculated share 
  select w.id as id, share * q.revenue as calced_revenue
  FROM wurl_viewership w
  join quarterly_revenue q on (q.quarter = w.quarter and q.year = w.year and q.channel = w.channel)
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 16
) t
WHERE t.id = wv.id 
   

select sum(revenue), channel from wurl_viewership  w
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 16
  group by channel

