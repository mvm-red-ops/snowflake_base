//vizio vod upload template

copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, revenue, deal_parent,territory_id, year, quarter, filename) 
from (select t.$1, t.$2, to_number(REPLACE(t.$3, ','), 15, 10), to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ','), 15, 6),  to_number(REPLACE(t.$6, ','), 10, 5), to_number(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_number(REPLACE(t.$13, '%'), 10, 4), to_number(REPLACE(REPLACE(t.$14, '$'), ','), 9, 3), 20, 1,2021, 'q2', 'vizio_q2_2021_updated'
from @wurl_viewership t) pattern='.*vizio_q2_2021_updated.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUe;

select calc_revenue, revenue from wurl_viewership where deal_parent = 20 and quarter = 'q2'



-- calculate share 
SELECT w.deal_parent, w.ref_id, w.month, share,  w.tot_hov / m.tot_hov as calced_share, mr.revenue as monthly_revenue, w.revenue, calced_share * mr.revenue as calc_rev
FROM WURL_VIEWERSHIP w
JOIN monthly_viewership m ON (m.month_string = w.month AND m.deal_parent = w.deal_parent)
JOIN monthly_revenue mr ON (mr.deal_parent = w.deal_parent AND mr.YEAR_MONTH_DAY = w.month)
where w.quarter = 'q2' and w.deal_parent in ( 20)

select sum(revenue) from revenue where deal_parent = 20 group by month

select * from monthly_viewership where deal_parent = 20

-- update viewership share
UPDATE WURL_VIEWERSHIP wv
SET SHARE_CALCULATED = t.calced_share 
FROM (
  SELECT w.deal_parent, w.ref_id, w.month,w.year, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (m.month_string = w.month 
    AND m.deal_parent = w.deal_parent)
) t
WHERE wv.quarter = 'q2' AND wv.deal_parent  = 20 and wv.year = t.year
and wv.ref_id = t.ref_id and wv.month = t.month 
and wv.deal_parent = t.deal_parent and wv.tot_hov = t.tot_hov   

