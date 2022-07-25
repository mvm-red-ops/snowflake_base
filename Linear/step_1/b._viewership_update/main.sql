-- wurl
-- update null tot_hov (CHANGE TO DELETE? )
update wurl_viewership
set tot_hov = 0
where tot_hov is null

-- delete null total_watched_time records from Xumo
delete from wurl_viewership where deal_parent = 17 and quarter = 'q4' and year = 2021  and total_time_watched is null

-- //update year_month_day column using month or date column (trc linear already uses year_month_day)
    -- //update wurl_viewership
    -- //set year_month_day = '20211001'
    -- //where quarter = '' and year =  and year_month_day is null and month like '%10%'
    select month from wurl_viewership where quarter = 'q4' and year = 2021 and year_month_day is null and month like '%10%'



