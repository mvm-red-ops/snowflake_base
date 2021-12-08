
update wurl_viewership w from
(
  SELECT id, ref_id, tot_hov, title, occurances  FROM WURL_VIEWERSHIP  at(offset => -60*25) 
) a
set ref_id = a.ref_id
where w.id = a.id  and w.ref_id != a.ref_id



update WURL_VIEWERSHIP  w set w.tot_hov = past.tot_hov
  from (SELECT id, tot_hov FROM WURL_VIEWERSHIP  at(offset => -60*25) WHERE month IN( '20210401' ,  '20210501',  '20210601'  )) past
  where w.id = past.id and past.tot_hov != w.tot_hov;



with past as (SELECT id, tot_hov as past_hov FROM WURL_VIEWERSHIP  at(offset => -60*25) WHERE month IN( '20210401' ,  '20210501',  '20210601'  )),
present as  (SELECT id, tot_hov as pres_hov FROM WURL_VIEWERSHIP  WHERE month IN( '20210401' ,  '20210501',  '20210601'  ))
select past.id, past_hov, pres_hov  from past JOIN present ON (past.id = present.id)
where (past_hov != pres_hov )

