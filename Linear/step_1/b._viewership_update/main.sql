-- wurl
-- update null tot_hov
update wurl_viewership
set tot_hov = 0
where tot_hov is null

-- //update year_month_day column using month or date column (trc linear already uses year_month_day)
    -- //update wurl_viewership
    -- //set year_month_day = '20211001'
    -- //where quarter = '' and year =  and year_month_day is null and month like '%10%'
    select month from wurl_viewership where quarter = 'q4' and year = 2021 and year_month_day is null and month like '%10%'



-- amagi

-- Update deal parent if not uploaded with it 
update amagi_viewership 
set deal_parent = 23, territory_id = 4
where channel_name = 'Nosey International Samsung CA'

update amagi_viewership 
set deal_parent = 23, territory_id = 6
where channel_name = 'Nosey Intl Samsung IN'

update amagi_viewership 
set deal_parent = 23, territory_id = 10
where channel_name = 'Nosey Intl Samsung AU'

 
-- Not sure if the stored_procedures folder is helpful here.
--Update channel_id
UPDATE AMAGI_VIEWERSHIP t1
    SET channel_id = t2.id
    FROM channels t2
    WHERE t1.channel = t2.name;

--Update territory_id
UPDATE AMAGI_VIEWERSHIP t1
    SET territory_id = t2.id
    FROM territories t2
    WHERE t1.country = t2.name and t1.year = 2021 and t1.quarter = 'q3' and t1.deal_parent = 12;

--update device_id
UPDATE AMAGI_VIEWERSHIP t1
    SET device_id = t2.id
    FROM devices t2
    WHERE t1.device = t2.name and t1.year = 2021 and t1.quarter = 'q3' and t1.deal_parent = 12;

-- get ref id and series 
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


-- Can prob combine statements


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