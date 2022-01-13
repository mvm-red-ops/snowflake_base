-- find viewership records that don't have ref_id match in assets table
select * from wurl_viewership 
where ref_id NOT IN (select ref_id from assets) 
and deal_parent = 21 and quarter = 'q3' and year = 2021 and channel_id = 9 ;
