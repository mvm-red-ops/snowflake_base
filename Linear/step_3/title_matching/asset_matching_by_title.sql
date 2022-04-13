-- check how many non-matches
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4'  and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)




-- weighted_composite_score
select p.title, a.title, soundex(wv.title) t1, soundex(a.title) t2, fuzzy_score(a.title, wv.title) v3, fuzzy_score(soundex(wv.title), soundex(a.title)) v4 , 
((v3*1)+(v4*2))/3 weighted_composite_score,
wv.id as p_id, a.ref_id as a_ref_id
from wurl_viewership wv
cross join assets.public.assets  a
where quarter = 'q4' and year = 2021  and (wv.ref_id = 'externalId' or wv.ref_id is null) and weighted_composite_score > 0.9
-- Can narrow down results if query taking too long, by specifying deal_parent, or adding LIMIT to query 


-- wurl 
update wurl_viewership wv
set wv.ref_id = q.refid 
from (
    select wv.id as qid, p.title, a.title, soundex(wv.title) t1, soundex(a.title) t2, fuzzy_score(a.title, wv.title) v3, fuzzy_score(soundex(wv.title), soundex(a.title)) v4 , 
    ((v3*1)+(v4*2))/3 weighted_composite_score,
    wv.id as p_id, a.ref_id as refid
    from wurl_viewership wv
    cross join assets.public.assets  a
    where quarter = 'q4' and year = 2021  and (wv.ref_id = 'externalId' or wv.ref_id is null) and weighted_composite_score > 0.9
) q 
where wv.id = q.qid


-- pluto 
update pluto_viewership pv
set pv.ref_id = q.refid 
from (
    select pv.id as qid, p.title, a.title, soundex(pv.title) t1, soundex(a.title) t2, fuzzy_score(a.title, pv.title) v3, fuzzy_score(soundex(pv.title), soundex(a.title)) v4 , 
    ((v3*1)+(v4*2))/3 weighted_composite_score,
    pv.id as p_id, a.ref_id as refid
    from wurl_viewership pv
    cross join assets.public.assets  a
    where quarter = 'q4' and year = 2021  and (pv.ref_id = 'externalId' or pv.ref_id is null) and weighted_composite_score > 0.9
) q 
where pv.id = q.qid




-- check if anything is msising ref_id
select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
where quarter = 'q4'  and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)



-- standardize function
create or replace function standardize(a String)
returns string
strict immutable
COMMENT = 'Removes non-alphanumeric characters and casts the result to UPPER case'
as $$ select REGEXP_REPLACE(LOWER(a),'[^A-Z0-9 ]', '') $$;


-- fuzzy_score function
create or replace function fuzzy_score(a String, b String)
returns number
strict immutable
COMMENT = 'Takes two strings and returns a similarity score between 1 and 0'
as 'select 1.0-(editdistance(a, b)/greatest(length(a),length(b)))';


