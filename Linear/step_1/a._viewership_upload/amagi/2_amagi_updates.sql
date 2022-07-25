

-- update month
-- amagi data gives the view data (if pulled daiy) or date_interval if pulled monthly
-- using that we will update the 'month' and 'year_month_day' columns




   
-- update month 
call month_update_amagi_viewership('q1', 2022);


-- territory_id update
call territory_update_amagi_viewership('q1', 2022)



-- deal_parent update
call territory_update_amagi_viewership('q1', 2022)



-- ref_id update
call territory_update_amagi_viewership('q1', 2022)




-- TO DO COMBINE REF_ID, SERIES_ID UPDATES (ALSO CP UPDATE IF POSSIBLE, AND TOT_HOV?) THE MORE IN ONE THE BETTER
-- update ref_id
    update amagi_viewership av
    set av.ref_id = q.ref_id_b
    from(
    select  get_ref_id_amagi(content_id) as ref_id_b, * from amagi_viewership where year = 2022 and quarter = 'q1'
    ) q
    where av.id = q.id



--  series id update
update amagi_viewership av
set  av.series_id = q.series_id_q
from(
    select get_series_id_amagi(content_id) as series_id_q, * from amagi_viewership where year = 2022 and quarter = 'q1'
) q
where av.id = q.id


-- update content provider
update amagi_viewership a
set a.content_provider = q.cp
from (
    select a.id as id, m.content_provider as cp from amagi_viewership a
    join assets.public.metadata m on (a.ref_id = m.ref_id)
    where year = 2022 and quarter = 'q1' and m.content_provider is not null
) q
where q.id = a.id



-- update tot_hov 
update amagi_viewership 
set tot_hov = total_viewership_minutes / 60 
where tot_hov is null       