CREATE OR REPLACE FUNCTION get_ref_id_amagi(s STRING)
      RETURNS VARCHAR
      LANGUAGE JAVASCRIPT
      AS' 
        let r1 = S.split("-");
        let content = [];

        for(const r of r1 ){
            if(r.includes("_")){
                let r2 = r.split("_");
                for(const c of r2){
                    content.push(c);
                } 
            } else {
                content.push(r)
            }
        }

        const ref_id = content[0] + "-" + content[1];
        return ref_id
    ';




update amagi_viewership av
set av.ref_id = iv.ref_id_b, av.series = iv.series_b
from(
   select  get_ref_id_amagi(content_id) as ref_id_b, * from amagi_viewership where year = 2021 and quarter = 'q3'
) iv
where av.id = iv.id