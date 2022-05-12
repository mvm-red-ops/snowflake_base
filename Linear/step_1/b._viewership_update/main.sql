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
-- update year_month_day (repeat for each month)
    update amagi_viewership 
    set  year_month_day = '20211001'
    where year_month_day is null and view_date like '10/%/21'

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

    -- update deal parents for fetch, lg, klowd,etc REPEAT FOR ALL CHANNELS 
    update  amagi_viewership a
    set deal_parent = 30
    where deal_parent is null 
    and channel_name like '%LG%'

    update  amagi_viewership a
    set deal_parent = 28
    where deal_parent is null 
    and channel_name like '%lowd%'


    
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
    set av.ref_id = q.ref_id_b
    from(
    select  get_ref_id_amagi(content_id) as ref_id_b, * from amagi_viewership where year = 2021 and quarter = 'q3'
    ) q
    where av.id = q.id


    -- Can prob combine statements

    CREATE OR REPLACE FUNCTION get_series_id_amagi(s STRING)
        RETURNS VARCHAR
        LANGUAGE JAVASCRIPT
        AS '
            s = S.toLowerCase();
                if(s.includes("jerry")) {
                    return "8";
                    }
                if(s.includes("sally")) {
                    return "32"
                    }
                if(s.includes("trisha")) {
                    return "43";
                    }
                if(s.includes("maury")) {
                    return "29"
                    }
                else return null
        ';


    update amagi_viewership av
    set  av.series_id = iv.series_id_q
    from(
    select get_series_id_amagi(content_id) as series_id_q, * from amagi_viewership where year = 2021 and quarter = 'q3'
    ) iv
    where av.id = iv.id