-- gam_data 

-- (Prerequisite: Make sure that the year_month_day column is filled out. To update it, please use the update statement below. Set the year_month_day in YYYYMMDD format. Make sure month year is relevant. Do this for each month in the quarter.)
    -- Update Statement YEAR_MONTH_DAY:
    UPDATE gam_data
    SET year_month_day = (ENTER YYYYMMDD HERE)
    WHERE month_year = 'Oct-21' <---- REPLACE
    
    
    -- 1. oao impression share
        insert into monthly_impressions(tot_impressions, year_month_day, partner)
        select sum(TOTAL_IMPRESSIONS), year_month_day, 'gam' from gam_data
        group by year_month_day


        -- update oao share  
        update gam_data g
        set g.oao_share = q.oao
        from (
        select g.id as gid, total_impressions / m.tot_impressions as oao ,g.year_month_day, ad_unit from gam_data g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where  m.partner = 'gam' 
        ) q
        where q.gid = g.id

        -- check (should == 1)
        select sum(oao_share), g.year_month_day from gam_data g
        join monthly_impressions m on (m.year_month_day = g.year_month_day)
        where  m.partner = 'gam'
        group by g.year_month_day
