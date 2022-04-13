-- update wurl_viewership null tot_hov
update wurl_viewership
set tot_hov = 0
where tot_hov is null




-- amagi
--Update channel_id
UPDATE AMAGI_VIEWERSHIP t1
    SET channel_id = t2.id
    FROM channels t2
    WHERE t1.channel = t2.name;

--Update territory_id
UPDATE AMAGI_VIEWERSHIP t1
    SET territory_id = t2.id
    FROM territories t2
    WHERE t1.country = t2.name and t1.year = 2021 and t1.quarter = 'q3' and t1.deal_parent = 12;

--update device_id
UPDATE AMAGI_VIEWERSHIP t1
    SET device_id = t2.id
    FROM devices t2
    WHERE t1.device = t2.name and t1.year = 2021 and t1.quarter = 'q3' and t1.deal_parent = 12;