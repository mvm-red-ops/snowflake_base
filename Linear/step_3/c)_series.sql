  -- series update
update wurl_viewership w
set w.series_id = q.series_id
from (
  select w.id as id,  w.series, d.term, d.series_id from wurl_viewership w
  join dictionary.public.series d on (d.entry = w.series)
  where w.series_id is null 
) q
where q.id = w.id


-- series udpate
  update amagi_viewership a
  set a.series_id = q.series_id
  from (
    select a.id as id,  a.series, d.term, d.series_id from amagi_viewership a
    join dictionary.public.series d on (d.entry = a.series)
    where a.series_id is null 
  ) q
  where q.id = a.id


  -- series update
  update amagi_viewership a
  set a.series_id = q.series_id
  from (
    select a.id as id,  a.series, d.term, d.series_id from amagi_viewership a
    join dictionary.public.series d on (d.entry = a.series)
    where a.series_id is null 
  ) q
  where q.id = a.id