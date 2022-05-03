select year, substr(year_month_day, 5, 2) as month,  content_provider, c.name as channel, p.name as partner, t.name as territory, revenue, type  from register r
join deals d on (d.id = r.deal_parent)
join partners p on (d.partner_id = p.id)
join territories t on (r.territory_id = t.id)
join channels c on (c.id = r.channel_id)
where year = 2021 and quarter = 'q4'
order by type, month, partner, channel