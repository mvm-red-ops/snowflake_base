-- update series_id

-- wurl 
  -- title format
  update wurl_viewership
  set formatted_title = standardize(title)
  where formatted_title is null
  

  -- series update
  update wurl_viewership w
  set w.series_id = q.series_id
  from (
    select w.id as id,  w.series, d.term, d.series_id from wurl_viewership w
    join dictionary.public.series d on (d.entry = w.series)
    where w.series_id is null 
  ) q
  where q.id = w.id


-- amagi 

  -- title format
  update amagi_viewership
  set formatted_title = standardize(content_name)
  where formatted_title is null

-- series udpate
  update amagi_viewership a
  set a.series_id = q.series_id
  from (
    select a.id as id,  a.series, d.term, d.series_id from amagi_viewership a
    join dictionary.public.series d on (d.entry = a.series)
    where a.series_id is null 
  ) q
  where q.id = a.id


-- pluto 

  -- title format
  update pluto_viewership
  set formatted_title = standardize(title)
    where formatted_title is null

  -- series update
  update amagi_viewership a
  set a.series_id = q.series_id
  from (
    select a.id as id,  a.series, d.term, d.series_id from amagi_viewership a
    join dictionary.public.series d on (d.entry = a.series)
    where a.series_id is null 
  ) q
  where q.id = a.id