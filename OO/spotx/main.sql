copy into revenue (timestamp, channel_name, deal_demand_source, deal_name	placements, gross_revenue, impressions, quarter, year, filename)
from (select t.$1, t.$2, t.$3, t.$4, to_number(REPLACE(t.$5, ','), 10, 0), to_number(REPLACE(t.$6, ','), 10,5), to_number(REPLACE(t.$7, ','), 12, 0),  'q4', 2021,  'spotx_revenue_q4_2021.csv'
from @onwed_and_operated_aws t) pattern='.*spotx_revenue_q4_2021.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE; 