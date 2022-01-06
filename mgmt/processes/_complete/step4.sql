-- calculate record level share
SELECT w.deal_parent, w.ref_id, w.month, share,  w.tot_hov / m.tot_hov as calced_share
FROM WURL_VIEWERSHIP w
JOIN monthly_viewership m ON (m.month_string = w.month AND m.deal_parent = w.deal_parent and w.channel = m.channel)
where w.quarter = 'q3'and year = 2021 and w.deal_parent in ( 16, 18, 20, 21)



-- update records with calulcated share  (one at at time, for each partner)
UPDATE WURL_VIEWERSHIP wv
SET SHARE_CALCULATED = t.calced_share 
FROM (
  SELECT w.deal_parent, w.quarter, w.ref_id, w.month,w.year, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (
    m.month_string = w.month 
    and m.deal_parent = w.deal_parent
    and m.channel = w.channel
  )
  WHERE w.quarter = 'q3'  and w.year = 2021 and w.deal_parent = 21
) t
WHERE wv.quarter = t.quarter and wv.deal_parent = t.deal_parent and t.year = wv.year and wv.ref_id = t.ref_id and wv.month = t.month  and wv.tot_hov = t.tot_hov   
    


-- check the total share by channel, month, and deal_parent (should equal 1)
select sum(share_calculated), month, channel, deal_parent 
FROM WURL_VIEWERSHIP w
where w.quarter = 'q3' and year = 2021 and w.deal_parent in ( 16, 18, 20, 21)
group by month, channel, deal_parent
