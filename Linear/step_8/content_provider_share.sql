


-- Wurl
    -- query by month, channel, territory
    select  sum(share), year_month_day, content_provider,channel_id, deal_parent, year, quarter, territory_id from wurl_viewership 
    where  year = 2021 and quarter = 'q4'
    group by  content_provider, channel_id, year_month_day, deal_parent,year, quarter, territory_id
    

    -- insert by month, channel, territory
    insert into content_provider_share(share, year_month_day, content_provider,channel_id, deal_parent, year, quarter, territory_id)
    select  sum(share), year_month_day, content_provider,channel_id, deal_parent, year, quarter, territory_id from wurl_viewership 
    where  year = 2021 and quarter = 'q4'
    group by  content_provider, channel_id, year_month_day, deal_parent,year, quarter, territory_id
    
    

-- Amagi
    -- query by month, channel, territory
    select deal_parent, sum(share), year_month_day, content_provider, channel_id, year, quarter, territory_id from amagi_viewership 
    where year = 2021 and quarter = 'q4' and deal_parent  in (18, 23)
    group by channel_id, deal_parent, year_month_day,content_provider, year, quarter, territory_id

    -- insert by month, channel, territory
    insert into content_provider_share(deal_parent, share, year_month_day, content_provider, channel_id, year, quarter, territory_id)
    select deal_parent, sum(share), year_month_day, content_provider, channel_id, year, quarter, territory_id from amagi_viewership 
    where year = 2021 and quarter = 'q4' and deal_parent  in (18, 23)
    group by channel_id, deal_parent, year_month_day,content_provider, year, quarter, territory_id




-- Pluto
    -- query
    select w.deal_parent, sum(w.tot_hov) / mv.tot_hov as cp_share, w.year_month_day, w.content_provider, w.channel,w.channel_id, p.name, w.year, w.quarter from pluto_viewership w
    join monthly_viewership mv on (mv.year_month_day = w.year_month_day and mv.channel = w.channel and w.deal_parent = mv.deal_parent)
    join deals d on (d.id = w.deal_parent)
    join partners p on (p.id = d.partner_id)
    where w.quarter = 'q4' and w.year = 2021
    group by w.content_provider, w.year_month_day, w.channel,w.channel_id, mv.tot_hov, w.deal_parent, p.name, w.year, w.quarter
    order by  w.deal_parent, year_month_day, channel, content_provider
    
    -- insert
    insert into content_provider_share(deal_parent, share, year_month_day, content_provider, channel, channel_id, partner_name, year, quarter)
    select w.deal_parent, sum(w.tot_hov) / mv.tot_hov as cp_share, w.year_month_day, w.content_provider, w.channel,w.channel_id, p.name, w.year, w.quarter from pluto_viewership w
    join monthly_viewership mv on (mv.year_month_day = w.year_month_day and mv.channel = w.channel and w.deal_parent = mv.deal_parent)
    join deals d on (d.id = w.deal_parent)
    join partners p on (p.id = d.partner_id)
    where w.quarter = 'q4' and w.year = 2021
    group by w.content_provider, w.year_month_day, w.channel,w.channel_id, mv.tot_hov, w.deal_parent, p.name, w.year, w.quarter
    order by  w.deal_parent, year_month_day, channel, content_provider




-- After inserting the content_provider_share records 
-- check monthly_revenue records vs content_provider_share records grouped by channel_id, deal_parent, year_month_day
-- there should be the same # of records
    --  if there numbers are different, identify which deal_parent's are missing from each
    --  if a deal_parent doesn't have viewership or revenue records, they should not appear in the tables and can be added to the excluded clause
    --  since TRC (both linear and VOD) are calculated from the quarterly revenue and viewership, they are excluded as well

select  c.channel_id, c.deal_parent, c.year_month_day, c.territory_id from  monthly_revenue c
where year = 2021 and quarter = 'q4'
  group by c.channel_id, c.deal_parent, c.year_month_day, c.territory_id



select c.channel_id, c.deal_parent, c.year_month_day, c.territory_id  from  content_provider_share c
where year = 2021 and quarter = 'q4' and deal_parent not in (16)
group by c.channel_id, c.deal_parent, c.year_month_day, c.territory_id



