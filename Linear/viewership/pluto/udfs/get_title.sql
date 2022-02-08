CREATE OR REPLACE FUNCTION get_title_pluto(s STRING)
      RETURNS VARCHAR
      LANGUAGE JAVASCRIPT
      AS '
        const content = s.split(":");
        const title = content[1];
        if(content.length > 2) return null;

        if(title == null || title == undefined) return null
        const p_idx = title.indexOf("(");
        let t_final = title.slice(0, p_idx -1);

        return t_final
    ';


update pluto_viewership pv
set pv.ref_id = iv.ref_id_b, pv.series = iv.title_b
from(
   select  get_title_pluto(content_id) as title_b, * from pluto_viewership where year = 2021 and quarter = 'q3'
) iv
where pv.id = iv.id