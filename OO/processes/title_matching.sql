update powr_viewership p 
set p.ref_id = q.ref_id_update
from (
    select *, a.ref_id as ref_id_update, p.id as v_id from powr_viewership p
    join nosey_staging.public.assets a on (a.title = p.title)
    ) q 
where q.v_id = p.id
