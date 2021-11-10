//STEP 1: CHECK topline revenue
  //make sure payments are loaded 
  SELECT * FROM REVENUE WHERE deal_parent = 18 AND quarter = 'q2'
  
    //step 2 
    //sum the revenue and group by month

//STEP 2: CHECK topline viewership
SELECT * FROM WURL_VIEWERSHIP WHERE month IN('20210401', '20210501','20210601') AND deal_parent = 18



SELECT * FROM monthly_viewership_wurl WHERE deal_parent = 18


//share by asset 
SELECT ref_id, v.month, v.tot_hov, mv.tot_hov as monthly_hov, v.share, (v.tot_hov / monthly_hov) as calc_share, r.revenue,(calc_share * r.revenue)rev_by_record
FROM WURL_VIEWERSHIP v 
JOIN monthly_viewership_wurl mv ON (mv.month_string = v.month AND mv.deal_parent = v.deal_parent)
JOIN REVENUE r ON (r.YEAR_MONTH_DAY = v.month and r.deal_parent = v.deal_parent) 
WHERE v.deal_parent = 18 AND v.quarter = 'q2' 