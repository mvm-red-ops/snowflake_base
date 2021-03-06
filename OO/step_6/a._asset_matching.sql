-- weighted_composite_score 
    -- function definitons are below
select p.title, a.title, soundex(p.title) t1, soundex(a.title) t2, fuzzy_score(a.title, p.title) v3, fuzzy_score(soundex(p.title), soundex(a.title)) v4 , 
((v3*1)+(v4*2))/3 weighted_composite_score,
p.id as p_id, a.ref_id as a_ref_id
from powr_viewership p
cross join assets.public.metadata  a
where quarter = 'q4' and year = 2021  and p.ref_id is null and weighted_composite_score > 0.9
LIMIT 1000 --this limit number can be changed




-- update viewership using above, update ref_id and content_provider
update powr_viewership p 
set p.ref_id = q.a_ref_id, p.content_provider = q.cp_name
from (
    select p.title, a.title, soundex(p.title) t1, soundex(a.title) t2, fuzzy_score(a.title, p.title) v3, fuzzy_score(soundex(p.title), soundex(a.title)) v4 , 
    ((v3*1)+(v4*2))/3 weighted_composite_score,
    p.id as p_id, a.ref_id as a_ref_id, a.content_provider as cp_name
    from powr_viewership p
    cross join assets.public.metadata  a
    where quarter = 'q4' and year = 2021 and p.ref_id is null and weighted_composite_score > 0.9
    LIMIT 5000 
    ) q 
where q.p_id = p.id



--The below is for reference: 

-- standardize function
create or replace function standardize(a String)
returns string
strict immutable
COMMENT = 'Removes non-alphanumeric characters and casts the result to UPPER case'
as $$ select REGEXP_REPLACE(LOWER(a),'[^A-Z0-9 ]', '') $$;


-- fuzzy score
create or replace function fuzzy_score(a String, b String)
returns number
strict immutable
COMMENT = 'Takes two strings and returns a similarity score between 1 and 0'
as 'select 1.0-(editdistance(a, b)/greatest(length(a),length(b)))';
