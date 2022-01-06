copy into WURL_VIEWERSHIP(channel, title, series_text,ref_id, tot_airtime_min, occurances ,  tot_hov, tot_sessions , avg_session_hov, tot_completions  ,vs, month,deal_parent,territory_id, year, quarter, filename) 
from (select  
      t.$2, 
      t.$3, 
      REPLACE(t.$4, '"'), 
      t.$5, 
      to_number(REPLACE(t.$6, ','), 10), 
      to_number(REPLACE(t.$7, ','), 5, 2),  
      to_number(REPLACE(t.$8, ','), 20, 5), 
      to_number(REPLACE(t.$9, ','),9, 2), 
      to_number(REPLACE(t.$10, ','),9,2), 
      to_number(REPLACE(t.$11, ','), 10, 2), 
      t.$12,
      t.$13, 
      16, 1, 2021, 'q3','trc_linear_2021_q3'
from @wurl_viewership t) pattern='.*trc_linear_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;


//check upload total
SELECT channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021 and  (wv.ref_id = 'externalId' or wv.ref_id is null)

//exact title match
select wv.id, channel, wv.title as wurl_title, a.title as asset_title,wv.ref_id,  a.ref_id as asset_ref_id, wv.series_text, a.series, EDITDISTANCE( wv.title , a.title ) as title_discrep, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
 from wurl_viewership wv
join assets  a on (a.title = wv.title)
where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and series_discrep < 10
order by title_discrep desc


//update using exact matches
update wurl_viewership w from
(
//exact title match
  select wv.id, channel, wv.title as wurl_title, a.title as asset_title,wv.ref_id,  a.ref_id as asset_ref_id, wv.series_text, a.series, EDITDISTANCE( wv.title , a.title ) as title_discrep, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
   from wurl_viewership wv
  join assets  a on (a.title = wv.title)
  where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and series_discrep < 10
  order by title_discrep desc
) a
set ref_id = a.asset_ref_id
where w.id = a.id 

//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)


//update using exact matches with series 
select channel, wv.title, a.title, tot_hov, month, a.ref_id, wv.series_text, a.series,  EDITDISTANCE( wv.series_text, a.series ) as title_discrep FROM wurl_viewership wv
join assets  a on (a.title = wv.title)
where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep < 7
 

//exact title, broader series match
update wurl_viewership w from
(
  select wv.id, channel, wv.title, a.title, tot_hov, month, a.ref_id as asset_ref_id, wv.series_text, a.series,  EDITDISTANCE( wv.series_text, a.series ) as title_discrep FROM wurl_viewership wv
  join assets  a on (a.title = wv.title)
  where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep < 7
 ) a
set ref_id = a.asset_ref_id
where w.id = a.id 



//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)


//non-perfect title, series (assets)
select channel, wv.title, a.title,a.ref_id as asset_ref_id,wv.ref_id as wurl_ref_id,  EDITDISTANCE( wv.title , a.title ) as title_descrep,  wv.series_text, a.series,  EDITDISTANCE( wv.series_text, a.series ) as series_discrep FROM wurl_viewership wv
cross join assets  a 
where quarter = 'q3' and deal_parent = 16 and year = 2021 and title_descrep < 6 and (wv.ref_id = 'externalId' or wv.ref_id is null) and series_discrep < 8 and wurl_ref_id != asset_ref_id
 

//update using alt titles
update wurl_viewership w from
(

  //non-perfect title, series (assets)
  select wv.id, channel, wv.title, a.title,a.ref_id as asset_ref_id,wv.ref_id as wurl_ref_id,  EDITDISTANCE( wv.title , a.title ) as title_descrep,  wv.series_text, a.series,  EDITDISTANCE( wv.series_text, a.series ) as series_discrep FROM wurl_viewership wv
  cross join assets  a 
  where quarter = 'q3' and deal_parent = 16 and year = 2021 and title_descrep < 6 and (wv.ref_id = 'externalId' or wv.ref_id is null) and series_discrep < 8 and wurl_ref_id != asset_ref_id
 
 ) a
set ref_id = a.asset_ref_id
where w.id = a.id 


//check partial matches
select wv.id, channel, wv.title, a.title,  a.ref_id as asset_ref_id,  EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.ref_id, a.ref_id, EDITDISTANCE( wv.series_text, a.series ) as series_discrep,  wv.series_text, a.series
from wurl_viewership wv
cross join alternative_titles  a
where quarter = 'q3' and deal_parent = 16 and year = 2021  and title_discrep <= 3  and (wv.ref_id = 'externalId' or wv.ref_id is null) and series_discrep < 11


//update based on close matches 
update wurl_viewership w from
 (
//check partial matches
  select wv.id, channel, wv.title, a.title, a.ref_id as asset_ref_id, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.ref_id, a.ref_id, EDITDISTANCE( wv.series_text, a.series ) as series_discrep,  wv.series_text, a.series
  from wurl_viewership wv
  cross join alternative_titles  a
  where quarter = 'q3' and deal_parent = 16 and year = 2021  and title_discrep <= 3  and (wv.ref_id = 'externalId' or wv.ref_id is null) and series_discrep < 11
) a
set ref_id = a.asset_ref_id
where w.id = a.id 




//check partial matches
select wv.id, channel, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
from wurl_viewership wv
cross join assets  a
where quarter = 'q3' and deal_parent = 16 and year = 2021  and title_discrep <= 6 and series_discrep < 10  and (wv.ref_id = 'externalId' or wv.ref_id is null)


//update based on close matches 
update wurl_viewership w from
(
  select wv.id, channel, wv.title,a.ref_id as asset_ref_id, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles  a
  where quarter = 'q3' and deal_parent = 16 and year = 2021  and title_discrep <= 2 and series_discrep < 10  and (wv.ref_id = 'externalId' or wv.ref_id is null)

) a
set ref_id = a.asset_ref_id
where w.id = a.id 







//check broad asset matches
select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
from wurl_viewership wv
cross join alternative_titles  a
where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 5 and series_discrep <= 6 



//update from broad asset match
update wurl_viewership w from
(
  select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles  a
  where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 5 and series_discrep <= 6 
) a
set ref_id = a.asset_ref_id
where w.id = a.id 




//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)


//broaden partial matches
select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
from wurl_viewership wv
cross join alternative_titles_utility  a
where  quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 5 and series_discrep <= 6 



//update based on broad matches 
update wurl_viewership w from
(
  select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles_utility  a
  where  quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 5 and series_discrep <= 6 
) a
set ref_id = a.asset_ref_id
where w.id = a.id 




//check how many non-matches
  select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles_utility  a
  where  quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 5 and series_discrep < 10



update wurl_viewership w from
(
  select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles_utility  a
  where  quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 5 and series_discrep < 10
) a
set ref_id = a.asset_ref_id
where w.id = a.id 


insert into alternative_titles(title, ref_id, series, content_provider)
values ('Im Begging You to Find a New Job!', 'TR-1756', 'Trisha', 'NBC')

//broaden partial matches
select * 
 from wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021  and wv.title like '%Youre Cheating%' 

select * from wurl_viewership where title like '%Begging%'
and quarter = 'q3' and deal_parent = 16 and year = 2021 and (ref_id = 'externalId' or wv.ref_id is null) 




//update based on broad alt titles matches 
update wurl_viewership w from
(
//broaden partial matches
select wv.id, channel, wv.title as wurl_title, a.title as asset_title, wv.ref_id, a.ref_id as asset_ref_id,EDITDISTANCE( wv.title , a.title ) as title_discrep, a.series, wv.series_text,EDITDISTANCE( wv.series_text, a.series ) as series_discrep
 from wurl_viewership wv
cross join alternative_titles a
where quarter = 'q3' and deal_parent = 16 and year = 2021  and wv.title like '%Begging%' and a.title like '%Begging%'
and title_discrep < 14 
) a
set ref_id = a.asset_ref_id
where w.id = a.id 






//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021and (wv.ref_id = 'externalId' or wv.ref_id is null) 



  select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles_utility  a
  where  quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 8 


//individual updates
update wurl_viewership w from
(
  select  wv.id, channel, a.ref_id as asset_ref_id, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as title_discrep, wv.series_text, a.series, EDITDISTANCE( wv.series_text, a.series ) as series_discrep
  from wurl_viewership wv
  cross join alternative_titles_utility  a
  where  quarter = 'q3' and deal_parent = 16 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and title_discrep <= 8 
) a
set ref_id = a.asset_ref_id
where w.id = a.id 


//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q3' and deal_parent = 16 and year = 2021and (wv.ref_id = 'externalId' or wv.ref_id is null) 



