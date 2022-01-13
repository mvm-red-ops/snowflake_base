

-- wind back ref id for all wurl_viewership
update wurl_viewership w from
(
  SELECT id, ref_id as past_ref_id FROM WURL_VIEWERSHIP  at(offset => -60*10)
) a
set ref_id = a.past_ref_id
where w.id = a.id  and w.ref_id != a.past_ref_id




with past as (SELECT id, tot_hov as past_hov FROM WURL_VIEWERSHIP  at(offset => -60*25) WHERE month IN( '20210401' ,  '20210501',  '20210601'  )),
present as  (SELECT id, tot_hov as pres_hov FROM WURL_VIEWERSHIP  WHERE month IN( '20210401' ,  '20210501',  '20210601'  ))
select past.id, past_hov, pres_hov  from past JOIN present ON (past.id = present.id)
where (past_hov != pres_hov )

