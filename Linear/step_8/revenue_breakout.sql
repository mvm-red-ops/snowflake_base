
-- step 1 insert trc vod and trc linear manually
-- step 2 join monthly_revenue to content_provider share

-- trc linear

    -- query 
    select sum(revenue), sum(share), year_month_day, content_provider,channel_id from wurl_viewership 
    where deal_parent  = 16 and year = 2021 and quarter = 'q4'
    group by  content_provider, channel_id, year_month_day

    -- insert 
    insert into register(revenue,  share, year_month_day, content_provider, deal_parent, channel_id, year, quarter, type )
    select sum(revenue), sum(share), year_month_day, content_provider, deal_parent, channel_id, year, quarter, 'revenue' from wurl_viewership 
    where deal_parent  = 16 and year = 2021 and quarter = 'q4'
    group by  content_provider, channel_id, year_month_day, year, quarter,deal_parent



-- trc vod

    -- query
    select sum(revenue)/3, content_provider,channel_id from wurl_viewership 
    where deal_parent   in (25)
    group by  content_provider, channel_id

    -- insert
    insert into register(revenue, year_month_day, content_provider, deal_parent, channel_id, year, quarter,type )
    select sum(revenue)/3, '20211201', content_provider,deal_parent, channel_id, year, quarter, 'revenue' from wurl_viewership 
    where deal_parent   in (25)
    group by  content_provider, channel_id, deal_parent,year, quarter




-- non-trc
    -- join
    select c.channel_id, c.deal_parent, c.year_month_day, c.content_provider, c.share * m.revenue as cp_rev_share from content_provider_share c 
    join monthly_revenue m on (m.channel_id = c.channel_id and  m.deal_parent = c.deal_parent and  m.year_month_day = c.year_month_day)
    where c.year = 2021 and c.quarter = 'q4' and c.deal_parent not in (16, 30, 31, 25)



-- insert (including territory)
    insert into register( 
        CONTENT_PROVIDER,
        REVENUE,
        CHANNEL_ID,
        DEAL_PARENT, 
        YEAR_MONTH_DAY,
        YEAR, 
        QUARTER,
        territory_id,
        type
    )
    select  
        c.content_provider, 
        (c.share * m.revenue), 
        c.channel_id, 
        c.deal_parent, 
        c.year_month_day, 
        c.year,c.quarter, 
        c.territory_id,
        'revenue'
    from content_provider_share c 
    join monthly_revenue m on (m.channel_id = c.channel_id and  m.deal_parent = c.deal_parent and  m.year_month_day = c.year_month_day and m.territory_id =  c.territory_id)
    where c.year = 2021 and c.quarter = 'q4'

