CREATE OR REPLACE FUNCTION get_series_pluto(s STRING)
      RETURNS VARCHAR
      LANGUAGE JAVASCRIPT
      AS '
             s = S.toLowerCase();
            const content = s.split(":");
            const series = content[0];
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
            if(s.includes("divorce")) {
                return "Divorce Court"
                }
            if(s.includes("eye")) {
                return "Eye for an Eye"
                }
            if(s.includes("karen")) {
                return "Judge Karen"
            }
            if(s.includes("blind")) {
                return "Blind Date"
            }
            if(s.includes("wilkos")) {
                return "Steve Wilkos"
            }

            if(s.includes("emergency")) {
                return "Emergency"
            }   
            if(s.includes("mantracker")) {
                return "Mantracker"
            }


            else return null
    ';


update pluto_viewership pv
set pv.ref_id = iv.ref_id_b, pv.series = iv.series_b
from(
   select  get_series_pluto(content_id) as series_b, * from pluto_viewership where year = 2021 and quarter = 'q3'
) iv
where pv.id = iv.id