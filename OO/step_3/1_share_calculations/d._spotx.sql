-- spotx
    -- in order to calculate spotx share, we need to  
        --  m =  monthly gross_revenue 
        --  divide record level gross_revenue by m.revenue
        --  then we can sum share by department_id
         
        -- 1a. get monthly gross revenue
            -- update the year and quarter
        select sum(gross_revenue), year_month_day from spotx
        where year = 202X and quarter = 'qX'
        group by year_month_day
        
         -- 1b. insert into table
            -- update the year and quarter
         insert into monthly_gross_revenue(revenue, year_month_day)
         select sum(gross_revenue), year_month_day from spotx
         where year = 202X and quarter = 'qX'
         group by year_month_day            
            

        
        -- 2a. update the spotx_share by dividing gross_rev by monthly_gross_rev  
            -- update year and quarter
        update spotx s
        set s.spotx_share = q.sx_share
        from(
          select s.id as id, gross_revenue, gross_revenue / m.revenue as sx_share, s.year_month_Day from spotx s
          join monthly_gross_revenue m on (m.year_month_day = s.year_month_day )
          where year = 202X and quarter = 'qX'
        ) q
        where s.id = q.id
        
        
        -- 3a. REVENUE NEEDS TO BE IN BEFORE THIS STEP update the spotx_rev by multiplying revenue by spotx_share
            -- update the year and quarter
        update spotx s
        set s.spotx_revenue = q.sx_rev
        from(
          select s.id as id, gross_revenue, spotx_share, spotx_share * r.amount as sx_rev from spotx s
          join revenue r on (r.year_month_day = s.year_month_day)
          where pay_partner = 'spotx' and s.year = 202X and s.quarter = 'qX'
        ) q
        where s.id = q.id 

