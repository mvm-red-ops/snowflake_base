select channel, w.title, a.title, month, a.ref_id FROM wurl_viewership w
join assets a on (a.title = w.title)
where quarter = 'q3' and deal_parent = 25 and year = 2021 and (w.ref_id = 'externalId' or w.ref_id is null)



//update based on close matches 
update wurl_viewership w from
(
  select w.id, a.series, w.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( w.clip_name , a.title ) as discrep
  from wurl_viewership w
  cross join assets  a
  where quarter = 'q3' and deal_parent = 25 and year = 2021 and discrep <= 3 and len(w.title) > 7 an is not null and series_discrep < 8 and len(clip_name) > 1
  order by discrep desc
) a
set w.ref_id = a.asset_ref_id
where w.id = a.id 




  
update wurl_viewership w from
(
select w.id, a.series, w.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( w.title , a.title ) as discrep
  from wurl_viewership w
  cross join assets  a
  where quarter = 'q3' and deal_parent = 25 and year = 2021 and w.ref_id is null and discrep <= 3 and len(w.title) > 5
  order by discrep desc
) a
set w.ref_id = a.asset_ref_id
where w.id = a.id 



update wurl_viewership w from
(
  select w.id, a.series, w.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( w.title , a.title )  as discrep
  from wurl_viewership w
  cross join assets  a
  where quarter = 'q3' and deal_parent = 25 and year = 2021 and w.ref_id is null  and len(a.title) > 12 and discrep < 5
   order by discrep desc
) a
set w.ref_id = a.asset_ref_id
where w.id = a.id 