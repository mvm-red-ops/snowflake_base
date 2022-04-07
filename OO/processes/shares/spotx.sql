    //in order to calculate spotx share, we need to  
        // m =  monthly gross_revenue 
        // divide record level gross_revenue by m.revenue
        // then we can sum share by department_id
         
        //1a. get monthly gross revenue
        select sum(gross_revenue), year_month_day  from spotx
        group by year_month_day
        
            //1b. insert into table
            insert into monthly_gross_revenue(revenue, year_month_day)
            select sum(gross_revenue), year_month_day  from spotx
            group by year_month_day            
            


        
        //2a. update the spotx_share by dividing gross_rev by monthly_gross_rev        
        update spotx s
        set s.spotx_share = q.sx_share
        from(
          select s.id as id, gross_revenue, gross_revenue / m.revenue as sx_share, s.year_month_Day from spotx s
          join monthly_gross_revenue m on (m.year_month_day = s.year_month_day )
        ) q
        where s.id = q.id 
        
        
        //3a. REVENUE NEEDS TO BE IN BEFORE THIS STEP update the spotx_rev by multiplying revenue by spotx_share
        update spotx s
        set s.spotx_revenue = q.sx_rev
        from(
          select s.id as id, gross_revenue, spotx_share, spotx_share * r.revenue as sx_rev from spotx s
          join revenue r on (r.year_month_day = s.year_month_day)
          where pay_partner = 'spotx' and r.year = 2021 and r.quarter = 'q4'
        ) q
        where s.id = q.id 

