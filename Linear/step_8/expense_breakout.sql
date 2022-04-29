

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
        (c.share * m.amount), 
        c.channel_id, 
        c.deal_parent, 
        c.year_month_day, 
        c.year,c.quarter, 
        c.territory_id,
        'expense'
    from content_provider_share c 
    join monthly_expenses m on (m.channel_id = c.channel_id and  m.deal_parent = c.deal_parent and  m.year_month_day = c.year_month_day and m.territory_id =  c.territory_id)
    where c.year = 2021 and c.quarter = 'q4'
