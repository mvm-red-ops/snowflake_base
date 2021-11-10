//STEP 1: CHECK topline revenue
  //make sure payments are loaded 
//  INSERT INTO REVENUE(month, year, quarter, deal_parent, revenue, year_month_day, channel, partner)
//values (4, 2021, 'q2', 16, 86860.85, 20210401, 'Nosey', 'TRC Linear'),
//(4, 2021, 'q2', 16, 80445.12, 20210401, 'Real Nosey', 'TRC Linear'),
//(5, 2021, 'q2', 16, 98835.15, 20210501, 'Nosey', 'TRC Linear'),
//(5, 2021, 'q2', 16, 84941.40, 20210501, 'Real Nosey', 'TRC Linear'),
//(6, 2021, 'q2', 16, 92902.33, 20210601, 'Nosey', 'TRC Linear'),
//(6, 2021, 'q2', 16, 76796.64, 20210601, 'Real Nosey', 'TRC Linear')
UPDATE monthly_revenue 
SET deal_parent = 21 WHERE deal_parent IS null

SELECT * FROM monthly_revenue
SELECT * FROM topline_revenue
    //step 2 
    //sum the revenue and group by month
    SELECT month, quarter, year,channel, year_month_day, sum(revenue) as rev FROM REVENUE WHERE deal_parent = 16 AND quarter = 'q2'group by year_month_day,month, quarter, year, channel

    //calculate insert monthly rev
//      insert into monthly_revenue (deal_parent,month,year,quarter,revenue, year_month_day, channel)
//        with r as
//          (SELECT month, quarter, year,channel, year_month_day, sum(revenue) as rev FROM REVENUE WHERE deal_parent = 16 AND quarter = 'q2'group by year_month_day,month, quarter, year, channel )
//        select 16, r.month, r.year, r.quarter,r.rev,r.year_month_day, r.channel
//        from r;   
//
      SELECT * FROM monthly_revenue WHERE deal_parent = 16 and quarter = 'q2'



//STEP 2: CHECK topline viewership
SELECT sum(tot_hov),quarter FROM WURL_VIEWERSHIP WHERE month IN('20210401', '20210501','20210601') AND deal_parent = 16 group by month, quarter

        //calculate insert monthly viewerhsip
//      insert into monthly_viewership_wurl (deal_parent,month,year,quarter,tot_hov, month_string)
//        with r as
//          (SELECT month, quarter, sum(tot_hov)as hov FROM WURL_VIEWERSHIP WHERE deal_parent = 16 AND quarter = 'q2'AND month ='20210401'group by month, quarter )
//        select 16, 4, 2021, r.quarter,r.hov,r.month
//        from r;   

      SELECT * FROM monthly_viewership_wurl WHERE deal_parent = 16 and quarter = 'q2'
   
   DELETe FROM wurl_viewership WHERE deal_parent = 20 and month IN ('20210401', '20210501','20210601')
   UPDATE wurl_viewership SET quarter = 'q2' WHERE deal_parent = 20 and month IN ('20210401', '20210501','20210601')
   

 

  

//share by asset 
SELECT ref_id, v.month, v.tot_hov, mv.tot_hov as monthly_hov, v.share, (v.tot_hov / monthly_hov) as calc_share, r.revenue,(calc_share * r.revenue)rev_by_record
FROM WURL_VIEWERSHIP v 
JOIN monthly_viewership_wurl mv ON (mv.month_string = v.month AND mv.deal_parent = v.deal_parent)
JOIN monthly_revenue r ON (r.YEAR_MONTH_DAY = v.month and r.deal_parent = v.deal_parent) 
WHERE v.deal_parent = 20 AND v.quarter = 'q2' 



