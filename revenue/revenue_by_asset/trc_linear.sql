
//update monthly totals   
select sum(tot_hov), channel from  WURL_VIEWERSHIP
  where deal_parent = 16 and quarter = 'q2'
  group by channel
  

//recalculate share (make sure channel Real Nosey = RealNosey)
SELECT ref_id, v.month,v.channel, v.tot_hov, mv.tot_hov as monthly_hov, v.share, (v.tot_hov / monthly_hov) as calc_share, r.revenue,(calc_share * r.revenue)rev_by_record
FROM WURL_VIEWERSHIP v 
JOIN monthly_viewership mv ON (mv.month_string = v.month AND mv.deal_parent = v.deal_parent and mv.channel = v.channel)
JOIN monthly_revenue r ON (r.YEAR_MONTH_DAY = v.month and r.deal_parent = v.deal_parent and r.channel = v.channel) 
WHERE v.deal_parent = 16 AND v.quarter = 'q2' 


//update record with calced values
update wurl_viewership wv
set wv.share_calculated = w.calc_share, wv.calc_revenue = w.rev_by_record
from (
      SELECT ref_id, v.month, v.tot_hov,v.channel, mv.tot_hov as monthly_hov, v.share, (v.tot_hov / monthly_hov) as calc_share, r.revenue,(calc_share * r.revenue)rev_by_record
      FROM WURL_VIEWERSHIP v 
      JOIN monthly_viewership mv ON (mv.month_string = v.month AND mv.deal_parent = v.deal_parent)
      JOIN monthly_revenue r ON (r.YEAR_MONTH_DAY = v.month and r.deal_parent = v.deal_parent) 
      WHERE v.deal_parent = 16 AND v.quarter = 'q2'  
      ) w
where wv.ref_id = w.ref_id and wv.channel = w.channel and wv.month = w.month and wv.tot_hov = w.tot_hov



//check values are set properly
SELECT ref_id, v.month, v.deal_parent,v.channel, share_calculated, calc_revenue
FROM WURL_VIEWERSHIP v 
JOIN monthly_viewership mv ON (mv.month_string = v.month and mv.channel = v.channel and mv.deal_parent = v.deal_parent)
JOIN monthly_revenue r ON (r.year_month_day = v.month and r.deal_parent = v.deal_parent and r.channel = v.channel) 
WHERE v.deal_parent = 16 AND v.quarter = 'q2'  

      



      







  