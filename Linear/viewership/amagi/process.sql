-- data source sheet says to grab channels individually and by month, 
-- but we can grab all channels for all months (whole quarter as date range)
-- 

select channel_name  from amagi_viewership where year = 2021 and quarter = 'q4'  and channel_name like '%Samsung%' group by channel_name

update amagi_viewership 

update amagi_viewership 
set deal_parent = 23, territory_id = 4
where channel_name = 'Nosey International Samsung CA'

update amagi_viewership 
set deal_parent = 23, territory_id = 6
where channel_name = 'Nosey Intl Samsung IN'

update amagi_viewership 
set deal_parent = 23, territory_id = 10
where channel_name = 'Nosey Intl Samsung AU'