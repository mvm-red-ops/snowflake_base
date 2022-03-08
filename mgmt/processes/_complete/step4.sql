-- calculate record level share
SELECT w.deal_parent, w.ref_id, w.month, share,  w.tot_hov / m.tot_hov as calced_share
FROM WURL_VIEWERSHIP w
JOIN monthly_viewership m ON (m.year_month_day = w.month AND m.deal_parent = w.deal_parent and w.channel = m.channel)
where w.quarter = 'q3'and w.year = 2021 and w.deal_parent in ( 16, 18, 20, 21)



-- update records with calulcated share  (one at at time, for each partner)

-- NON TRC
UPDATE WURL_VIEWERSHIP wv
SET wv.share = t.calced_share 
FROM (
  SELECT  w.id, w.deal_parent, w.ref_id, w.month, share,  w.tot_hov / m.tot_hov as calced_share
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (
    m.year_month_day = w.month 
    and m.deal_parent = w.deal_parent
  )
  WHERE w.quarter = 'q3'  and w.year = 2021 and w.deal_parent = 17 
) t
WHERE wv.id = t.id
    
    
-- TRC        
UPDATE WURL_VIEWERSHIP wv
SET share = t.calced_share 
FROM (
  SELECT w.deal_parent, w.quarter, w.ref_id, w.month,w.year, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
  FROM WURL_VIEWERSHIP w
  JOIN quarterly_viewership m ON (
    m.deal_parent = w.deal_parent
    and m.channel = w.channel
  )
  WHERE w.quarter = 'q3'  and w.year = 2021 and w.deal_parent = 16
) t
WHERE wv.id = t.id
    


-- check the total share by channel, month, and deal_parent (should equal 1)
//viewership share check
//plex
    select sum(share), month , channel from wurl_viewership where deal_parent = 21 and quarter = 'q3' and year = 2021 group by month, channel 
    
//vizio
    select sum(share), month , channel from wurl_viewership where deal_parent = 20 and quarter = 'q3' and year = 2021 group by month, channel 

//samsung
    select sum(share), month , channel from wurl_viewership where deal_parent = 18 and quarter = 'q3' and year = 2021 group by month, channel 

//trc linear
    select sum(share), channel from wurl_viewership where deal_parent = 16 and quarter = 'q3' and year = 2021 group by channel 

    