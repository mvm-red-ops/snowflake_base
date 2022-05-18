



-- weighted_composite_score
    select wv.formatted_title, a.title, soundex(wv.formatted_title) t1, soundex(a.title) t2, fuzzy_score(a.title, wv.formatted_title) v3, fuzzy_score(soundex(wv.formatted_title), soundex(a.title)) v4 , 
    ((v3*1)+(v4*2))/3 weighted_composite_score, wv.id as p_id, a.ref_id as a_ref_id
    from wurl_viewership wv
    cross join dictionary.public.assets  a
    where a.series_id = wv.series_id and  quarter = 'q4' and year = 2021  and deal_parent = 18  and WEIGHTED_COMPOSITE_SCORE > .8 

    -- wurl 
    update wurl_viewership wv
    set wv.ref_id = q.ref_id , wv.content_provider = q.content_provider
    from (
        select wv.formatted_title, a.title, a.content_provider as content_provider, a.series, fuzzy_score(a.title, wv.formatted_title) v3, fuzzy_score(soundex(wv.formatted_title), soundex(a.title)) v4 , 
      ((v3*1)+(v4*2))/3 weighted_composite_score, wv.id as id, a.ref_id as ref_id
      from wurl_viewership wv
      cross join dictionary.public.assets  a
      where  quarter = 'q4' and year = 2021  and deal_parent = 18  and WEIGHTED_COMPOSITE_SCORE > .7 and wv.series_id = a.series_id
    ) q 
    where wv.id = q.id

    -- wurl
    select channel, wv.title, tot_hov, month, wv.ref_id FROM wurl_viewership wv
    where quarter = 'q4'  and year = 2021 and (wv.ref_id = 'externalId' or wv.ref_id is null)




    -- pluto 
    update pluto_viewership pv
    set pv.ref_id = q.refid , pv.content_provider = q.content_provider
    from (
        select pv.id as qid, pv.title, a.title, soundex(pv.title) t1, soundex(a.title) t2, fuzzy_score(a.title, pv.title) v3, fuzzy_score(soundex(pv.title), soundex(a.title)) v4 , 
        ((v3*1)+(v4*2))/3 weighted_composite_score, a.content_provider as content_provider,
        pv.id as p_id, a.ref_id as refid
        from pluto_viewership pv
        cross join assets.public.metadata  a
        where a.series_id = wv.series_id and  quarter = 'q4' and year = 2021  and (pv.ref_id = 'externalId' or pv.ref_id is null) and (weighted_composite_score > 0.7 or v3> .75 )
    ) q 
    where pv.id = q.qid
-- dictionary table 
    select pv.id as id, pv.clip_name, a.title, soundex(pv.clip_name) t1, soundex(a.title) t2, fuzzy_score(a.title, pv.clip_name) v3, fuzzy_score(soundex(pv.clip_name), soundex(a.title)) v4 , 
    ((v3*1)+(v4*2))/3 weighted_composite_score, a.content_provider as content_provider,
    pv.id as p_id, a.ref_id as refid
    from pluto_viewership pv
    cross join dictionary.public.assets  a
    where a.series_id = wv.series_id and  quarter = 'q4' and year = 2021  and (pv.ref_id = 'externalId' or pv.ref_id is null) and weighted_composite_score > .7 and v3> .4


-- pluto 
-- CLEAN UP TITLES FIRST
update pluto_viewership
set formatted_title = TRIM(REGEXP_REPLACE(  title, '\\([^()]*\\)'  , ''))
where (ref_id = 'externalId' or ref_id is null) and  quarter = 'q4' and year = 2021  and length(title)> 0
-- SPLIT PART WHERE CLIP NAME CONTAINS  ":"  (QUERY NOT HERE)

            update pluto_viewership pv
            set pv.ref_id = q.refid , pv.content_provider = q.content_provider
            from (
                select pv.id as qid, pv.clip_name, a.title, soundex(pv.clip_name) t1, soundex(a.title) t2, fuzzy_score(a.title, pv.clip_name) v3, fuzzy_score(soundex(pv.title), soundex(a.title)) v4 , 
                ((v3*1)+(v4*2))/3 weighted_composite_score, a.content_provider as content_provider,
                pv.id as p_id, a.ref_id as refid
                from pluto_viewership pv
                cross join dictionary.public.assets  a
                where a.series_id = wv.series_id and  quarter = 'q4' and year = 2021  and (pv.ref_id = 'externalId' or pv.ref_id is null) and weighted_composite_score > 0.7
            ) q 
            where pv.id = q.qid

            --  dictionary assets
            update pluto_viewership pv
            set pv.ref_id = q.refid , pv.content_provider = q.content_provider
            from (
                select pv.id as id, pv.title, a.title, soundex(pv.title) t1, soundex(a.title) t2, fuzzy_score(a.title, pv.title) v3, fuzzy_score(soundex(pv.title), soundex(a.title)) v4 , 
                ((v3*1)+(v4*2))/3 weighted_composite_score, a.content_provider as content_provider,
                pv.id as p_id, a.ref_id as refid
                from pluto_viewership pv
                cross join dictionary.public.assets  a
                where a.series_id = wv.series_id and  quarter = 'q4' and year = 2021  and (pv.ref_id = 'externalId' or pv.ref_id is null) and weighted_composite_score > 0.7
            ) q 
            where pv.id = q.id


            -- update pluto_viewership pv
                -- will be unmatched records, will have to find title and figure out solutions for each manually, usually involves reformatting title and or adding new assets to tables
                    -- set pv.ref_id = q.refid , pv.content_provider = q.content_provider
                    -- from (
                    --     select pv.id as id,pv.clip_name, formatted_title, a.title,editdistance(formatted_title, a.title),length(clip_name), length(a.title), soundex(pv.formatted_title) t1, soundex(a.title) t2, fuzzy_score(a.title, pv.formatted_title) v3, fuzzy_score(soundex(pv.formatted_title), soundex(a.title)) v4 , 
                    --     ((v3*1)+(v4*2))/3 weighted_composite_score, a.content_provider as content_provider,
                    --     pv.id as p_id, a.ref_id as refid
                    --     from pluto_viewership pv
                    --     cross join dictionary.public.assets  a
                    --     where quarter = 'q4' and year = 2021  and (pv.ref_id = 'externalId' or pv.ref_id is null) 
                    --     and formatted_title in ('After the Affair, Who’s the Father?', '%They\'re Back%', '%Boxing Blowout: Viewers vs. Guests (S1E78)%') and v3 > .7
                    -- ) q 
                    -- where pv.id = q.id


-- check if anything is msising ref_id
    select * from pluto_viewership 
    where (ref_id = 'externalId' or ref_id is null) and  quarter = 'q4' and year = 2021  




-- Amagi (SOME IF NOT ALL REF IDS SHOULD BE IN CONTENT ID COLUMN ALREADY)

    select av.formatted_title, a.title, soundex(av.formatted_title) t1, soundex(a.title) t2, fuzzy_score(a.title, av.formatted_title) v3, fuzzy_score(soundex(av.formatted_title), soundex(a.title)) v4 , 
    ((v3*1)+(v4*2))/3 weighted_composite_score, av.id as p_id, a.ref_id as a_ref_id
    from wurl_viewership av
    cross join dictionary.public.assets  a
    where a.series_id = av.series_id and  quarter = 'q4' and year = 2021  and deal_parent = 18  and WEIGHTED_COMPOSITE_SCORE > .8 and a.content_provider != average_watch_time_seconds.content_provider

    update amagi_viewership a
    set a.ref_id = q.ref_id , a.content_provider = q.cp
        from (
        select av.id as id, a.content_provider as cp, av.formatted_title, a.title, soundex(av.formatted_title) t1, soundex(a.title) t2, fuzzy_score(a.title, av.formatted_title) v3, 
            fuzzy_score(soundex(av.formatted_title), soundex(a.title)) v4 , 
            ((v3*1)+(v4*2))/3 weighted_composite_score, a.ref_id as ref_id
            from amagi_viewership av
            cross join assets.public.metadata  a
            where a.series_id = av.series_id and  quarter = 'q4' and year = 2021 and WEIGHTED_COMPOSITE_SCORE > .8
            limit 2000
        ) q 
    where a.id = q.id


-- standardize function used to populate 'formatted_title' column
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



