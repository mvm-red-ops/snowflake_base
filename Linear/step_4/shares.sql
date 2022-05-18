
      -- Wurl

      -- Non-TRC
        -- calculate record level share
        select w.id, w.deal_parent,w.channel_id, w.year_month_day, w.tot_hov, mv.tot_hov, (w.tot_hov / mv.tot_hov)as share from wurl_viewership w
        join monthly_viewership mv on (mv.deal_parent = w.deal_parent and mv.year_month_day = w.year_month_day and mv.channel_id = w.channel_id  and  mv.territory_id = w.territory_id)
        where w.quarter = 'q4' and w.year = 2021 and w.deal_parent in (18, 23) and w.tot_hov is not null



        -- update records with calulcated share 
        update  wurl_viewership w 
        set w.share = q.share
        from (
          select w.id, w.deal_parent,w.channel_id, w.year_month_day, w.tot_hov, mv.tot_hov, (w.tot_hov / mv.tot_hov)as share from wurl_viewership w
          join monthly_viewership mv on (mv.deal_parent = w.deal_parent and mv.year_month_day = w.year_month_day and mv.channel_id = w.channel_id  and  mv.territory_id = w.territory_id)
          where w.quarter = 'q4' and w.year = 2021 and w.deal_parent in (18, 23) and w.tot_hov is not null
        ) q
        where w.id = q.id


      -- TRC        
      UPDATE WURL_VIEWERSHIP w
      SET w.share = q.calced_share 
      FROM (
        SELECT w.id as id, w.deal_parent, w.year_month_day, w.tot_hov, share, w.tot_hov / m.tot_hov as calced_share 
        FROM WURL_VIEWERSHIP w
        JOIN quarterly_viewership m ON (
          m.deal_parent = w.deal_parent
          and m.channel_id = w.channel_id
          and m.year = w.year
          and m.quarter = w.quarter
        )
        WHERE w.quarter = 'q4'  and w.year = 2021 and w.deal_parent = 16
      ) q
      WHERE w.id = q.id
          

          

 
          


      -- check the total share by channel, month, and deal_parent (should equal 1)
      -- viewership share check
      -- plex
          select sum(share), year_month_day , channel_id from wurl_viewership where deal_parent = 21 and quarter = 'q4' and year = 2021 group by year_month_day, channel_id 
          
      -- vizio
          select sum(share), year_month_day , channel_id from wurl_viewership where deal_parent = 20 and quarter = 'q4' and year = 2021 group by year_month_day, channel_id 

      -- samsung
          select sum(share), year_month_day , channel_id from wurl_viewership where deal_parent = 18 and quarter = 'q4' and year = 2021 group by year_month_day, channel_id 

      -- trc linear
          select sum(share), channel_id from wurl_viewership where deal_parent = 16 and quarter = 'q4' and year = 2021 group by channel_id 
      -- xumo
          select sum(share), year_month_day , channel_id from wurl_viewership where deal_parent = 17 and quarter = 'q4' and year = 2021 group by year_month_day, channel_id 


  -- Amagi


  --     query 
    select a.id as id, a.tot_hov, (a.tot_hov / mv.tot_hov) as v_share,a.deal_parent, a.month from amagi_viewership a
    join monthly_viewership mv on (mv.year_month_day = a.year_month_day and a.channel_id = mv.channel_id and a.deal_parent = mv.deal_parent and a.territory_id = mv.territory_id)
    where a.year =2021 and a.quarter = 'q4'

    
  UPDATE amagi_viewership av
  SET av.share = q.v_share 
  FROM (
    select a.id as id, a.tot_hov, (a.tot_hov / mv.tot_hov) as v_share, a.deal_parent, a.month from amagi_viewership a
    join monthly_viewership mv on (mv.year_month_day = a.year_month_day and a.channel_id = mv.channel_id and a.deal_parent = mv.deal_parent and a.territory_id = mv.territory_id)
    where  a.year =2021 and a.quarter = 'q4'
  ) q
  WHERE av.id = q.id


  -- Amagi viewership share check (should all equal 1)
    select sum(share), year_month_day , channel_id from amagi_viewership  where quarter = 'q4' and year = 2021 group by year_month_day, channel_id ,deal_parent

    
