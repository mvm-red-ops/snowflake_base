select channel, pv.title, a.title, month, a.ref_id FROM pluto_viewership pv
join assets a on (a.title = pv.title)
where quarter = 'q3' and deal_parent = 29 and year = 2021 and (pv.ref_id = 'externalId' or pv.ref_id is null)



//update based on close matches 
update pluto_viewership w from
(
  select pv.id, pv.series, a.series, pv.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( pv.clip_name , a.title ) as discrep, EDITDISTANCE( pv.series, a.series ) as series_discrep
  from pluto_viewership pv
  cross join assets  a
  where quarter = 'q3' and deal_parent = 29 and year = 2021 and discrep <= 3 and len(pv.title) > 7 and pv.series is not null and series_discrep < 8 and len(clip_name) > 1
  order by discrep desc, series_discrep desc
) a
set w.ref_id = a.asset_ref_id
where w.id = a.id 




  
update pluto_viewership w from
(
select pv.id, pv.series, a.series, pv.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( pv.title , a.title ) as discrep, EDITDISTANCE( pv.series, a.series ) as series_discrep
  from pluto_viewership pv
  cross join assets  a
  where quarter = 'q3' and deal_parent = 29 and year = 2021 and pv.ref_id is null and discrep <= 3 and len(pv.title) > 5
  order by discrep desc, series_discrep desc
) a
set w.ref_id = a.asset_ref_id
where w.id = a.id 



update pluto_viewership w from
(
  select pv.id, pv.series, a.series, pv.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( pv.title , a.title )  as discrep, EDITDISTANCE( pv.series, a.series ) as series_discrep
  from pluto_viewership pv
  cross join assets  a
  where quarter = 'q3' and deal_parent = 29 and year = 2021 and pv.ref_id is null  and len(a.title) > 12 and discrep < 5
   order by discrep desc, series_discrep desc
) a
set w.ref_id = a.asset_ref_id
where w.id = a.id 