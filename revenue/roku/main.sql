//trc
    //total viewership records 1489
    select * from wurl_viewership where deal_parent = 16 and quarter = 'q3' and year = 2021  


//get quarterly viewership total by channel
    select channel, sum(tot_hov)from wurl_viewership where deal_parent = 16 and quarter = 'q3' and year = 2021 group by channel
//insert into quarterly_viewership
insert into quarterly_viewership (channel, deal_parent,year, tot_hov, quarter)
    select channel, deal_parent, year, sum(tot_hov),quarter from wurl_viewership where quarter = 'q3' and year = 2021 and deal_parent = 16
    group by channel, month, deal_parent, year, quarter
    
    


-- calculate share 
SELECT w.deal_parent, w.ref_id, share,  w.tot_hov / q.tot_hov as calced_share
FROM WURL_VIEWERSHIP w
JOIN quarterly_viewership q ON (q.channel = w.channel and q.quarter = w.quarter and q.year = w.year  and q.deal_parent = w.deal_parent)
where w.quarter = 'q3'and w.year = 2021 and w.deal_parent = 16 and w.ref_id = 'MS-1132'



-- update viewership share (repeat for each partner one at a time)
UPDATE WURL_VIEWERSHIP wv
SET share = t.calced_share 
FROM (
  -- calculated share 
  SELECT w.quarter, w.year, w.month, w.tot_hov, w.deal_parent, w.ref_id, share,  w.tot_hov / q.tot_hov as calced_share
  FROM WURL_VIEWERSHIP w
  JOIN quarterly_viewership q ON (q.channel = w.channel and q.quarter = w.quarter and q.year = w.year  and q.deal_parent = w.deal_parent)
  where w.quarter = 'q3'and w.year = 2021 and w.deal_parent = 16
) t
WHERE wv.quarter = t.quarter and wv.deal_parent = t.deal_parent and t.year = wv.year and wv.ref_id = t.ref_id and wv.month = t.month  and wv.tot_hov = t.tot_hov   
    



//check sum by channel, should = 1
select sum(share_calculated), channel 
FROM WURL_VIEWERSHIP w
where w.quarter = 'q3' and year = 2021 and w.deal_parent = 16
group by channel



//insert/ check quarterly revenue
select * from quarterly_revenue 
where quarter = 'q3' and year = 2021 and deal_parent = 16





//join quarterly revenue on channel
select ref_id, month, share_calculated,q.revenue, share, share * q.revenue as revenue
FROM wurl_viewership w
join quarterly_revenue q on (q.quarter = w.quarter and q.year = w.year and q.channel = w.channel)
where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 16


-- update viewership share (repeat for each partner one at a time)
UPDATE wurl_viewership wv
SET wv.revenue = t.calced_revenue 
FROM (
  -- calculated share 
  select w.quarter,w.deal_parent, w.year, w.ref_id, w.month, w.tot_hov, share * q.revenue as calced_revenue
  FROM wurl_viewership w
  join quarterly_revenue q on (q.quarter = w.quarter and q.year = w.year and q.channel = w.channel)
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 16
) t
WHERE wv.quarter = t.quarter and wv.deal_parent = t.deal_parent and t.year = wv.year and wv.ref_id = t.ref_id and wv.month = t.month  and wv.tot_hov = t.tot_hov   
    
   

select sum(revenue), channel from wurl_viewership  w
  where w.quarter = 'q3' and w.year = 2021 and w.deal_parent = 16
  group by channel


