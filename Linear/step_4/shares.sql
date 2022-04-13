
-- calculate record level share
SELECT w.deal_parent, w.ref_id, w.year_month_day, share,  w.tot_hov / m.tot_hov as calced_share
FROM WURL_VIEWERSHIP w
JOIN monthly_viewership m ON (m.year_month_day = w.year_month_day AND m.deal_parent = w.deal_parent and w.channel_id = m.channel_id)
where w.quarter = 'q4'and w.year = 2021 and w.deal_parent in (18, 20, 21)



-- update records with calulcated share  (one at at time, for each partner)

  SELECT  w.deal_parent, w.tot_hov, m.tot_hov, w.tot_hov / m.tot_hov as share, m.year_month_day, w.channel
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (
    m.year_month_day = w.year_month_day 
    and m.deal_parent = w.deal_parent
    and m.channel_id = w.channel_id
  )
  WHERE w.quarter = 'q4'  and w.year_month_day in ('20211001') and w.deal_parent in (18, 20, 21) 
  order by channel, deal_parent
  
  
-- NON TRC and NON XUMO
UPDATE WURL_VIEWERSHIP wv
SET wv.share = t.calced_share 
FROM (
  SELECT  w.id, w.deal_parent, w.year_month_day, w.tot_hov,  m.tot_hov , w.tot_hov / m.tot_hov as calced_share
  FROM WURL_VIEWERSHIP w
  JOIN monthly_viewership m ON (
    m.year_month_day = w.year_month_day 
    and m.deal_parent = w.deal_parent
    and m.channel_id = w.channel_id
  )
  WHERE w.quarter = 'q4'  and w.year = 2021 and w.deal_parent in (18, 20, 21)
) t
WHERE wv.id = t.id
    




-- TRC        
UPDATE WURL_VIEWERSHIP wv
SET share = t.calced_share 
FROM (
  SELECT w.id as id, w.deal_parent, w.quarter, w.ref_id, w.year_month_day,w.year, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
  FROM WURL_VIEWERSHIP w
  JOIN quarterly_viewership m ON (
    m.deal_parent = w.deal_parent
    and m.channel_id = w.channel_id
  )
  WHERE w.quarter = 'q4'  and w.year = 2021 and w.deal_parent = 16
) t
WHERE wv.id = t.id
    

    

        
-- XUMO        
UPDATE WURL_VIEWERSHIP wv
SET share = t.calced_share 
FROM (
  SELECT w.id as id, w.deal_parent, w.quarter, w.ref_id, w.year_month_day,w.year, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
  FROM WURL_VIEWERSHIP w
  JOIN quarterly_viewership m ON (
    m.deal_parent = w.deal_parent
    and m.channel_id = w.channel_id
  )
  WHERE w.quarter = 'q4'  and w.year = 2021 and w.deal_parent = 17
) t
WHERE wv.id = t.id


-- check the total share by channel, month, and deal_parent (should equal 1)
//viewership share check
//plex
    select sum(share), year_month_day , channel from wurl_viewership where deal_parent = 21 and quarter = 'q4' and year = 2021 group by year_month_day, channel 
    
//vizio
    select sum(share), year_month_day , channel from wurl_viewership where deal_parent = 20 and quarter = 'q4' and year = 2021 group by year_month_day, channel 

//samsung
    select sum(share), year_month_day , channel from wurl_viewership where deal_parent = 18 and quarter = 'q4' and year = 2021 group by year_month_day, channel 

//trc linear
    select sum(share), channel from wurl_viewership where deal_parent = 16 and quarter = 'q4' and year = 2021 group by channel 


