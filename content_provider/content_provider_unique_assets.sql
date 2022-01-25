
with cte_sessions as (
  select  
    w.ref_id, a.content_provider, w.month, w.channel_id, w.revenue, row_number() over (partition by w.id order by  w.title desc) as row_number
  from wurl_viewership w 
  left outer join assets a on a.ref_id = w.ref_id
  where w.year = 2021 and w.quarter = 'q3' and w.deal_parent =21 

)
select  content_provider, month, channel_id, sum(revenue) from cte_sessions  
where row_number = 1
group by content_provider, month, channel_id
order by month, channel_id
