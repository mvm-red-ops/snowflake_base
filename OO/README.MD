//step 1 powr viewership
    //upload from viewership sheets 

//step 2 google ad manager (gam data) and spotx 
               //adx                        //pubmatic 
            
               
               
//step 3 
    //update department ids for gam and spotx
    
    


//step 4 upload revenue into revenue table
    // go to data source map and filter for Revenue https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0
    // ignore Adx, as that is in the gam_data
    // 47 Samurai
    // Amazon Publisher Services
    // GlewedTV
    // LimpidTV
    // Pubmatic
    // Roku Reps
    // SpotX
    // Verizon Media
    // VideoBridge
    


//step 5 calculate spotx and pubmatic share

    //spotx share 
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




//pubmatic - share
    //in order to calculate pubmatic share, we need   
        // m =  monthly impressions 
        // divide record level impressions by m.impressions
        // then we can sum share by department_id
         
      //monthly_impressions
      select sum(impressions), year_month_day from spotx s
      where DEAL_NAME like '%Pubmatic%'
      group by year_month_day
      
      //insert into  monthly_impressions table
      insert into monthly_impressions(tot_impressions, year_month_day, partner)
      select sum(impressions), year_month_day, 'pubmatic' from spotx s
      where DEAL_NAME like '%Pubmatic%'
      group by year_month_day

       
      //calculate the pubmatic share 
      select (impressions / tot_impressions) as pub_share , g.year_month_day from spotx g
      join monthly_impressions m on (m.year_month_day = g.year_month_day)
      where DEAL_NAME like '%Pubmatic%'
      and m.partner = 'pubmatic'
      
      --update pub_share column in spotx table
      update spotx s
      set s.pub_share = q.pubshare
      from (
        select g.id as gid, (impressions / tot_impressions) as pubshare , g.year_month_day from spotx g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where  DEAL_NAME like '%Pubmatic%'
        and m.partner = 'pubmatic'
      )  q
      where s.id = q.gid



  //PUBMATIC REV HAS TO BE IN BEFORE THIS STEP
    //Update pubmatic rev share
    update spotx s
    set s.pub_revenue = q.pub_rev
    from ( 
      select s.id as qid, pub_share, s.impressions, pub_share * r.revenue as pub_rev,  s.year_month_day, s.channel_name from spotx s
      join revenue r on (r.year_month_day = s.year_month_day)
      where DEAL_NAME like '%Pubmatic%'
      and r.pay_partner = 'pubmatic'
    ) q
    where q.qid = s.id

    
    //group revenue by department and month
    select sum(pub_revenue), year_month_day,  d.name from spotx s
    join nosey_staging.public.departments d on (d.id = s.department_id)
    where pub_share is not null
    group by year_month_day, d.name

    //insert revenue by dept and month into monthly_revenue table
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select sum(pub_revenue), year_month_day,  d.id, 'pubmatic' from spotx s
    join nosey_staging.public.departments d on (d.id = s.department_id)
    where pub_share is not null
    group by year_month_day, d.id





//AdX
select * from gam_data where advertiser = 'AdX'

    //AdX Revenue
    select sum(ad_exchange_revenue), year_month_day, department_id from gam_data where advertiser = 'AdX'
    group by year_month_day, department_id
    
    //insert AdX revenue into monthly_revenue
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select sum(AD_EXCHANGE_REVENUE),YEAR_MONTH_DAY, department_id, 'adx' from gam_data 
    where advertiser = 'AdX'
    group by YEAR_MONTH_DAY,department_id







