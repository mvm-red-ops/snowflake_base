CREATE OR REPLACE FUNCTION get_series_amagi(s STRING)
      RETURNS VARCHAR
      LANGUAGE JAVASCRIPT
      AS '
         s = S.toLowerCase();
            if(s.includes("jerry")) {
                return "The Jerry Springer Show";
                }
            if(s.includes("sally")) {
                return "Sally"
                }
            if(s.includes("trisha")) {
                return "Trisha";
                }
            if(s.includes("maury")) {
                return "Maury"
                }
            else return null
    ';



update amagi_viewership av
set av.ref_id = iv.ref_id_b, av.series = iv.series_b
from(
   select  get_series_amagi(content_id) as series_b, * from amagi_viewership where year = 2021 and quarter = 'q3'
) iv
where av.id = iv.id