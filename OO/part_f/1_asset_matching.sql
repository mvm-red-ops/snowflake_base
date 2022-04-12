-- JUST COPY AND PASTED FROM FUZZY MATCHING SQL, CHECK TO MAKE SURE THIS WORKS


-- weighted_composite_score
select p.title, a.title, soundex(p.title) t1, soundex(a.title) t2, fuzzy_score(a.title, p.title) v3, fuzzy_score(soundex(p.title), soundex(a.title)) v4 , 
((v3*1)+(v4*2))/3 weighted_composite_score,
p.id as p_id, a.ref_id as a_ref_id
from powr_viewership p
cross join assets.public.assets  a
where quarter = 'q4' and year = 2021  and p.ref_id is null and weighted_composite_score > 0.5




-- create or replace function standardize(a String)
returns string
strict immutable
COMMENT = 'Removes non-alphanumeric characters and casts the result to UPPER case'
as $$ select REGEXP_REPLACE(LOWER(a),'[^A-Z0-9 ]', '') $$;


-- update series name using dictionary
update VIEWERSHIP v set title_std = d.name from (
select
a.cust_key,
coalesce(b.term, a.fname) name
from VIEWERSHIP a
left join dictionary b
on a.fname = b.token and context = 'NAME') d
where s.cust_key = d.cust_key;

-- 
create or replace function fuzzy_score(a String, b String)
returns number
strict immutable
COMMENT = 'Takes two strings and returns a similarity score between 1 and 0'
as 'select 1.0-(editdistance(a, b)/greatest(length(a),length(b)))';


-- count total pairs 
select
sum(pairs) pairs from (
select
series, 
count(*) recs,
(count(*)*(count(*)-1)/2)::number(12,0) pairs
from assets.public.assets
group by 1);



-- update viewership using above, update ref_id and content_provider
update powr_viewership p 
set p.ref_id = q.ref_id_update, p.content_provider = q.cp_name
from (
    select *, a.ref_id as ref_id_update, p.id as v_id, a.content_provider as cp_name from powr_viewership p
    join nosey_staging.public.assets a on (a.title = p.title)
    ) q 
where q.v_id = p.id
