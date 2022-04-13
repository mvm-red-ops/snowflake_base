
//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)




//check partial matches
select wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as discrep,  wv.series, a.series, EDITDISTANCE( wv.series, a.series ) as series_discrep
from wurl_viewership wv
cross join assets  a
where quarter = 'q4' and deal_parent = 20 and year = 2021  and discrep <= 2 and series_discrep < 10 and (wv.ref_id = 'externalId' or wv.ref_id is null) and a.id <  wv.id 


//update based on close matches 
update wurl_viewership w 
set w.ref_id = a.asset_ref_id
from
(
  select wv.id as id, wv.title, a.title, a.ref_id as asset_ref_id, EDITDISTANCE( wv.title , a.title ) as discrep,  wv.series, a.series, EDITDISTANCE( wv.series, a.series ) as series_discrep
  from wurl_viewership wv
  cross join assets  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021  and discrep <= 2 and series_discrep < 10 and (wv.ref_id = 'externalId' or wv.ref_id is null) and a.id <  wv.id 
) a
where w.id = a.id 



//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)


//alternative title match
select channel, wv.title, a.title, tot_hov, month, a.ref_id, EDITDISTANCE( wv.series_text, a.series ) as title_discrep FROM wurl_viewership wv
join alternative_titles  a on (a.title = wv.title)
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)


//update using alt titles
update wurl_viewership w from
(
  select wv.id as id, channel, wv.title, a.title, tot_hov, month, a.ref_id as asset_ref_id, EDITDISTANCE( wv.series_text, a.series ) as title_discrep FROM wurl_viewership wv
  join alternative_titles  a on (a.title = wv.title)
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)
) a
set ref_id = a.asset_ref_id
where w.id = a.id 



//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)


//check partial matches
select channel, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
from wurl_viewership wv
cross join assets  a
where quarter = 'q4' and deal_parent = 20 and year = 2021  and discrep <= 2  and (wv.ref_id = 'externalId' or wv.ref_id is null)


//update based on close matches 
update wurl_viewership w from
(
  select wv.id, channel, wv.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
  from wurl_viewership wv
  cross join assets  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and discrep <=2
) a
set ref_id = a.asset_ref_id
where w.id = a.id 




//check partial matches
select channel, wv.title, a.title, EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
from wurl_viewership wv
cross join alternative_titles  a
where quarter = 'q4' and deal_parent = 20 and year = 2021  and discrep <= 2  and (wv.ref_id = 'externalId' or wv.ref_id is null)


//update based on close matches 
update wurl_viewership w from
(
  select wv.id, channel, wv.title, a.title,a.ref_id as asset_ref_id, EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
  from wurl_viewership wv
  cross join alternative_titles  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and discrep <=2
) a
set ref_id = a.asset_ref_id
where w.id = a.id 



//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)




//check broad asset matches
select wv.id, channel, wv.title, a.title, a.ref_id as asset_ref_id, EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
from wurl_viewership wv
cross join assets  a
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and discrep <= 8 and a.title != 'Steve Save My Daughter'




//update from broad asset match
update wurl_viewership w from
(
  select wv.id, channel, wv.title, a.title, a.ref_id as asset_ref_id, EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
  from wurl_viewership wv
  cross join assets  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null) and discrep <= 8 and a.title != 'Steve Save My Daughter'
) a
set ref_id = a.asset_ref_id
where w.id = a.id 




//broaden partial matches
select wv.id, channel, wv.title, a.title, a.ref_id as asset_ref_id,EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
from wurl_viewership wv
cross join alternative_titles  a
where quarter = 'q4' and deal_parent = 20 and year = 2021 and discrep <= 8 and (wv.ref_id = 'externalId' or wv.ref_id is null) 



//update based on broad matches 
update wurl_viewership w from
(
  select wv.id, channel, wv.title, a.title, a.ref_id as asset_ref_id,EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
  from wurl_viewership wv
  cross join alternative_titles  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and discrep <= 8 and (wv.ref_id = 'externalId' or wv.ref_id is null) 
) a
set ref_id = a.asset_ref_id
where w.id = a.id 

//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4' and deal_parent = 20 and year = 2021and (wv.ref_id = 'externalId' or wv.ref_id is null) 


//broaden partial matches
select id, channel, wv.title as wurl_title, a.title as asset_title, a.ref_id as asset_ref_id,EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
 from wurl_viewership wv
cross join alternative_titles_utility  a
where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)  and discrep < 10 and length(a.title) > 15


//update based on broad alt titles matches 
update wurl_viewership w from
(
  select id, channel, wv.title as wurl_title, a.title as asset_title, a.ref_id as asset_ref_id,EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
   from wurl_viewership wv
  cross join alternative_titles_utility  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)  and discrep < 10 and length(a.title) > 15
) a
set ref_id = a.asset_ref_id
where w.id = a.id 





//check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4' and deal_parent = 20 and year = 2021and (wv.ref_id = 'externalId' or wv.ref_id is null) 



//individual updates
update wurl_viewership w from
(
  select id, channel, wv.title, a.title, a.ref_id as asset_ref_id,EDITDISTANCE( wv.title , a.title ) as discrep, EDITDISTANCE( wv.series_text, a.series ) as title_discrep
  from wurl_viewership wv
  cross join alternative_titles_utility  a
  where quarter = 'q4' and deal_parent = 20 and year = 2021 and wv.ref_id is null and discrep <= 8
) a
set ref_id = a.asset_ref_id
where w.id = a.id 