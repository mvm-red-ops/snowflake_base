-- pubmatic - share
    -- in order to calculate pubmatic share, we need   
        --  m =  monthly impressions 
        --  divide record level impressions by monthly impressions (m)
        --  then we can sum share by department_id
        
        -- (Prerequisite: Make sure that the year_month_day column is filled out. To update it, please use the update statement below. Set the year_month_day in YYYYMMDD format. Make sure month year is relevant. Do this for each month in the quarter.)
        -- Update Statement YEAR_MONTH_DAY:
            UPDATE gam_data
            SET year_month_day = 20211001 <--- REPLACE in YYYYMMDD Format
            WHERE month_year = 'Oct-21' <---- REPLACE
         
      -- monthly_impressions
      select sum(impressions), year_month_day from spotx s
      where DEAL_NAME like '%Pubmatic%'
      group by year_month_day
      
      -- insert into  monthly_impressions table
      insert into monthly_impressions(tot_impressions, year_month_day, partner)
      select sum(impressions), year_month_day, 'pubmatic' from spotx s
      where DEAL_NAME like '%Pubmatic%'
      group by year_month_day

       
      -- calculate the pubmatic share 
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


    -- Update pubmatic rev share
    update spotx s
    set s.pub_revenue = q.pub_rev
    from ( 
      select s.id as qid, pub_share, s.impressions, pub_share * r.revenue as pub_rev,  s.year_month_day, s.channel_name from spotx s
      join revenue r on (r.year_month_day = s.year_month_day)
      where DEAL_NAME like '%Pubmatic%'
      and r.pay_partner = 'pubmatic'
    ) q
    where q.qid = s.id
