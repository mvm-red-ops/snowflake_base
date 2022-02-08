-- Month	Channel	Provider	Partner	Requests	Impressions	Gross eCPM	Revenue	Max Costs	Costs	Revenue Split	Share Revenue
-- 7, '20210701', 	Nosey/Real Nosey	epg	marathon-ventures	1,960,780	1,410,502	$13.03	$15,333.83	$15,633.81	$299.98	60%	$9,200.30


copy into revenue (date_unformatted, partner, product, channel, partner_item_id, territory, gross_revenue, gross_ecpm, costs, net_revenue, revenue, deal_parent, year, quarter, filename)
from (select t.$1,t.$2, t.$3,t.$4, t.$5, t.$6, to_decimal(REPLACE(REPLACE(t.$7, ','), '$'), 12, 2),to_decimal(REPLACE(REPLACE(t.$8, ','), '$'), 8, 2), to_decimal(REPLACE(REPLACE(t.$9, ','), '$'), 10, 2), to_decimal(REPLACE(REPLACE(t.$10, ','), '$'), 12, 2), to_decimal(REPLACE(REPLACE(t.$11, ','), '$'), 12, 2), 21, 2021, 'q3' ,'xumo_2021_q2'
from @revenue t) pattern='.*plex_revenue_21_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCe=TRUE;



