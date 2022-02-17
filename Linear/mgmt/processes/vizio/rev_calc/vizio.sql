


-- monthly revenue
SELECT *,deal_parent, p.name  FROM monthly_revenue m
JOIN DEALS d ON (d.id = m.deal_parent)
JOIN PARTNERS p ON (d.partnerid = p.id)
where quarter = 'q2' and deal_parent in ( 20) and year = 2021


--update calc revenue
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
  where w.quarter = 'q2' and w.deal_parent in ( 20) and w.year = 2021
) t
WHERE wv.quarter = 'q2' AND wv.deal_parent in ( 20) and year = 2021
and wv.ref_id = t.ref_id and wv.month = t.month 
and wv.deal_parent = t.deal_parent and wv.tot_hov = t.tot_hov


