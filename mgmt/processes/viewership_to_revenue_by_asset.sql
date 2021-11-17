
-- This is the process for breaking out the revenue by asset and eventually by content partner

-- step 1. calculate the monthly viewership and revenue totals by platform / deal 

-- step 2. calculate the share by asset for each platform (TRC requires and exra step since the break out by channel)

-- step 3. is calculate the revenue per asset per platform per month 

-- Compare data 
-- SELECT w.deal_parent,year, quarter, w.channel, w.ref_id, w.month, share, share_calculated, calc_revenue, revenue
-- FROM WURL_VIEWERSHIP w
-- where w.quarter = 'q2' and w.deal_parent in (17)  

-- amagi at bottom


-- calc share 
-- how much viewership (tot_hov) / the monthly hov for a platform? 

SELECT * FROM monthly_viewership

-- calculate share 
SELECT w.deal_parent, w.ref_id, w.month, share,  w.tot_hov / m.tot_hov as calced_share, mr.revenue as monthly_revenue, w.revenue, calced_share * mr.revenue as calc_rev
FROM WURL_VIEWERSHIP w
JOIN monthly_viewership m ON (m.month_string = w.month AND m.deal_parent = w.deal_parent)
JOIN monthly_revenue mr ON (mr.deal_parent = w.deal_parent AND mr.YEAR_MONTH_DAY = w.month)
where w.quarter = 'q2' and w.deal_parent in ( 18, 20, 21)

-- update viewership share
UPDATE WURL_VIEWERSHIP wv
SET SHARE_CALCULATED = t.calced_share 
FROM (
  SELECT w.deal_parent, w.ref_id, w.month, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (m.month_string = w.month 
    AND m.deal_parent = w.deal_parent)
) t
WHERE wv.quarter = 'q2' AND wv.deal_parent  = 18
and wv.ref_id = t.ref_id and wv.month = t.month 
and wv.deal_parent = t.deal_parent and wv.tot_hov = t.tot_hov   


-- monthly revenue
SELECT *,deal_parent, p.name  FROM monthly_revenue m
JOIN DEALS d ON (d.id = m.deal_parent)
JOIN PARTNERS p ON (d.partnerid = p.id)
where quarter = 'q2' and deal_parent in ( 18, 20, 21)


UPDATE WURL_VIEWERSHIP wv
SET CALC_REVENUE = t.calc_rev
FROM (
  SELECT w.deal_parent, w.ref_id, w.month, share, w.tot_hov, w.tot_hov / m.tot_hov as calced_share, 
          mr.revenue as monthly_revenue, w.revenue, calced_share * mr.revenue as calc_rev
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (m.month_string = w.month 
    AND m.deal_parent = w.deal_parent)
  JOIN monthly_revenue mr ON ( mr.deal_parent = w.deal_parent 
    AND mr.YEAR_MONTH_DAY = w.month)
  where w.quarter = 'q2' and w.deal_parent in ( 18, 20, 21) 
) t
WHERE wv.quarter = 'q2' AND wv.deal_parent in ( 18, 20, 21) 
and wv.ref_id = t.ref_id and wv.month = t.month 
and wv.deal_parent = t.deal_parent and wv.tot_hov = t.tot_hov   


SELECT ref_id, deal_parent, month, revenue, calc_revenue,calc_revenue - revenue as c FROM WURL_VIEWERSHIP wv
WHERE wv.quarter = 'q2' AND wv.deal_parent in ( 18, 20) 


SELECT sum(calc_revenue) FROM WURL_VIEWERSHIP 
WHERE quarter = 'q2' AND year = 2021 
GROUP BY ref_id


SELECt  revenue- calc_revenue as c FROM WURL_VIEWERSHIP 
WHERE quarter = 'q2' AND deal_parent in ( 18, 20)  






-- AMAGI


UPDATE AMAGI_VIEWERSHIP a
SET SHARE_CALCULATED = t.calced_share 
FROM (
  SELECT w.deal_parent,w.TOTAL_VIEWERSHIP_MINUTES, w.channel, w.ref_id, w.month, share, TOTAL_VIEWERSHIP_MINUTES / m.tot_hov as calced_share, mr.revenue as monthly_revenue, w.revenue, calced_share * mr.revenue as calc_rev
  FROM amagi_viewership w
  JOIN monthly_viewership m ON (m.month_string = w.month AND m.deal_parent = w.deal_parent)
  JOIN monthly_revenue mr ON (mr.deal_parent = w.deal_parent AND mr.YEAR_MONTH_DAY = w.month)
  where w.quarter = 'q2' and w.deal_parent in (23) 
) t
WHERE a.quarter = 'q2' AND a.deal_parent in (23) and a.ref_id = t.ref_id and a.month = t.month and a.deal_parent = t.deal_parent and a.TOTAL_VIEWERSHIP_MINUTES = t.TOTAL_VIEWERSHIP_MINUTES   


SELECT ref_id, deal_parent, month, revenue, calc_revenue,calc_revenue - revenue as c FROM AMAGI_VIEWERSHIP wv
WHERE quarter = 'q2' AND deal_parent in (23)






-- PLUTO 

-- First update the total_revenue column   
UPDATE PLUTO_VIEWERSHIP p
SET  p.total_revenue = t.REVENUE_BY_TITLE
FROM (SELECT * FROM PLUTO_VIEWERSHIP t
  WHERE t.REVENUE_BY_TITLE is not null and  t.total_revenue is null
 ) t
WHERE t.REVENUE_BY_TITLE = p.REVENUE_BY_TITLE  and t.REVENUE_BY_TITLE = p.REVENUE_BY_TITLE