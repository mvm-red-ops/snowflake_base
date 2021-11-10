//STEP 1: CHECK topline revenue
  //make sure payments are loaded 

    //step 2 
    //sum the revenue and group by month
    SELECT month, quarter, year, year_month_day, sum(revenue) FROM REVENUE WHERE deal_parent = 20 AND quarter = 'q2'group by year_month_day,month, quarter, year

    //calculate insert monthly rev
      insert into monthly_revenue (deal_parent,month,year,quarter,revenue, year_month_Day)
        with r as
          (SELECT month, quarter, year, year_month_day, sum(revenue) as rev FROM REVENUE WHERE deal_parent = 20 AND quarter = 'q2'group by year_month_day,month, quarter, year )
        select 20, r.month, r.year, r.quarter,r.rev,r.year_month_day
        from r;   

      SELECT * FROM monthly_revenue WHERE deal_parent = 20 and quarter = 'q2'



//STEP 2: CHECK topline viewership
SELECT sum(tot_hov) FROM WURL_VIEWERSHIP WHERE month IN('20210401', '20210501','20210601') AND deal_parent = 20 group by month

        //calculate insert monthly viewerhsip
      insert into monthly_viewership_wurl (deal_parent,month,year,quarter,tot_hov, month_string)
        with r as
          (SELECT month, quarter, sum(tot_hov)as hov FROM WURL_VIEWERSHIP WHERE deal_parent = 20 AND quarter = 'q2'AND month ='20210601'group by month, quarter )
        select 20, 6, 2021, r.quarter,r.hov,r.month
        from r;   

      SELECT * FROM monthly_viewership_wurl WHERE deal_parent = 20 and quarter = 'q2'
   
   DELETe FROM wurl_viewership WHERE deal_parent = 20 and month IN ('20210401', '20210501','20210601')
   UPDATE wurl_viewership SET quarter = 'q2' WHERE deal_parent = 20 and month IN ('20210401', '20210501','20210601')
   

 

  

//share by asset 
SELECT ref_id, v.month, v.tot_hov, mv.tot_hov as monthly_hov, v.share, (v.tot_hov / monthly_hov) as calc_share, r.revenue,(calc_share * r.revenue)rev_by_record
FROM WURL_VIEWERSHIP v 
JOIN monthly_viewership_wurl mv ON (mv.month_string = v.month AND mv.deal_parent = v.deal_parent)
JOIN monthly_revenue r ON (r.YEAR_MONTH_DAY = v.month and r.deal_parent = v.deal_parent) 
WHERE v.deal_parent = 20 AND v.quarter = 'q2' 


SELECT month, deal_parent FROM WURL_VIEWERSHIP v 

WHERE  v.deal_parent = 20 AND v.quarter = 'q2' 
