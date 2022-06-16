-- year mobnth day	department	dealparent	description	Title	Revenue Share	Provider	year	quarter	type	title


-- distribution
copy into register(year_month_day, department, deal_parent, description, title, amount, content_provider, year, quarter, type, territory_id, channel_id, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    REPLACE(REPLACE(t.$6, '$'), ','),
    t.$7,
    t.$8,
    t.$9,
    t.$10,
    t.$11,
    t.$12, 'historical_register.csv'
        from @distribution_partners_revenue t) pattern='.*historical_register_dist_partners.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;

        


-- Owned and Operated
copy into register(year_month_day, department, title, type, description, content_provider, rev_share, year, quarter, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    REPLACE(REPLACE(REPLACE(t.$7, '#VALUE!', 0), '$'), ','),
    2020,
    'q4',
    'historical_oo_content_provider_share.csv'
        from @oo_revenue t) pattern='.*historical_oo_content_provider_share.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;



update expenses set amount = 1111.27 where year_month_day ='20200101' and department = 'All' and title = 'AWS Storage'
update expenses set amount = 1093.28 where year_month_day = '20200201' and department = 'All' and title = 'AWS Storage'
update expenses set amount = 1131.29 where year_month_day ='20200301' and 	department = 'All' and title = 'AWS Storage'
update expenses set amount = 2362.99 where year_month_day ='20200101' and department = 'Mobile/Web' and 	title ='Brightcove Bandwidth'
update expenses set amount = 1178.60 where year_month_day = '20200201' and department = 'Mobile/Web' and 	title ='Brightcove Bandwidth'
update expenses set amount = 1203.98 where year_month_day ='20200301' and 	department = 'Mobile/Web' and 	title ='Brightcove Bandwidth'
update expenses set amount = 10083.71 where year_month_day = '20200201' and department = 'Roku' and 	title ='Brightcove Bandwidth'
update expenses set amount = 11686.43 where year_month_day ='20200101' and department = 'Roku' and 	title ='Brightcove Bandwidth'
update expenses set amount = 10597.07 where year_month_day ='20200301' and 	department = 'Roku' and 	title ='Brightcove Bandwidth'
update expenses set amount = 2416.67 where year_month_day ='20200101' and department = 'All' and title = 'Brightcove Platform'
update expenses set amount = 2416.67 where year_month_day = '20200201' and department = 'All' and title = 'Brightcove Platform'
update expenses set amount = 2416.67 where year_month_day ='20200301' and 	department = 'All' and title = 'Brightcove Platform'
update expenses set amount = 832.83 where year_month_day ='20200101' and department = 'All' and title = 'Brightcove Storage'
update expenses set amount = 703.63 where year_month_day = '20200201' and department = 'All' and title = 'Brightcove Storage'
update expenses set amount = 717.84 where year_month_day ='20200301' and 	department = 'All' and title = 'Brightcove Storage'
update expenses set amount = 312.79 where year_month_day ='20200101' and department = 'Mobile/Web' and 	title = 'OAO Ad Serving'
update expenses set amount = 1178.99 where year_month_day ='20200101' and Roku and title = 'OAO Ad Serving'
update expenses set amount = 1987.57 where year_month_day = '20200201' and department = 'Roku' and 	title = 'OAO Ad Serving'
update expenses set amount = 292.20 where year_month_day = '20200201' and department = 'Mobile/Web' and 	title = 'OAO Ad Serving'
update expenses set amount = 2265.76 where year_month_day ='20200301' and 	department = 'Roku' and 	title = 'OAO Ad Serving'
update expenses set amount = 257.22 where year_month_day ='20200301' and 	department = 'Mobile/Web' and 	title = 'OAO Ad Serving'
update expenses set amount = 5000.00 where year_month_day ='20200101' and department = 'Mobile/Web' and 	title 'Unreel Platform'
update expenses set amount = 5000.00 where year_month_day = '20200201' and department = 'Mobile/Web' and 	title 'Unreel Platform'
update expenses set amount = 5000.00 where year_month_day ='20200301' and 	department = 'Mobile/Web' and 	title 'Unreel Platform'

