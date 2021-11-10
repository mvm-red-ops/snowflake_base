-- quarterly viewership sum 
with pluto as (SELECT sum(total_viewing_minutes) as tot FROM PLUTO_VIEWERSHIP
                WHERE quarter = 'q2' and year = 2021  
                group by quarter, year),
     amagi as (SELECT  sum(TOTAL_VIEWERSHIP_MINUTES)as tot FROM AMAGI_VIEWERSHIP
                WHERE quarter = 'q2' and year = 2021   
                group by  quarter, year),
     wurl as (SELECT  sum(tot_hov) * 60 as tot FROM WURL_VIEWERSHIP
              WHERE quarter = 'q2' and year = 2021  
              group by  quarter, year)
select sum(pluto.tot + amagi.tot + wurl.tot) - 293561.7463
from pluto, amagi, wurl



-- Sum of all partners (as of q2) quarterly viewership
with
xumo as (SELECT sum(tot_hov) * 60 as tot  FROM WURL_VIEWERSHIP WHERE deal_parent = 17 AND quarter = 'q2' and year = 2021 ),
samsung as (SELECT sum(tot_hov) * 60 as tot FROM WURL_VIEWERSHIP WHERE deal_parent = 18 AND quarter = 'q2' and year = 2021 ),
plex as (SELECT sum(tot_hov)* 60 as tot FROM WURL_VIEWERSHIP WHERE deal_parent = 21 AND quarter = 'q2' and year = 2021  ),
trc as (SELECT sum(tot_hov) * 60 as tot FROM WURL_VIEWERSHIP WHERE deal_parent = 16 AND quarter = 'q2' and year = 2021),
vizio as  (SELECT sum(tot_hov) * 60 as tot FROM WURL_VIEWERSHIP WHERE deal_parent = 20 AND quarter = 'q2' and year = 2021),
pluto as  (SELECT sum(total_viewing_minutes) as tot FROM PLUTO_VIEWERSHIP WHERE deal_parent = 29  AND quarter = 'q2' and year = 2021 and territory_id = 1),
samsung_au as (SELECT sum(TOTAL_VIEWERSHIP_MINUTES) as tot FROM AMAGI_VIEWERSHIP WHERE deal_parent = 23)
select (xumo.tot + samsung.tot + plex.tot + trc.tot + vizio.tot + pluto.tot +samsung_au.tot )as quarterly_total,
xumo.tot, samsung.tot,plex.tot, trc.tot, vizio.tot, pluto.tot,samsung_au.tot
from xumo, samsung, plex, trc, vizio, pluto, samsung_au


//Xumo Minutes	28815614.07
SELECT sum(tot_hov) * 60  FROM WURL_VIEWERSHIP WHERE deal_parent = 17 AND quarter = 'q2' and year = 2021 



//Samsung Minutes	144,873,615
SELECT sum(tot_hov) * 60 FROM WURL_VIEWERSHIP WHERE deal_parent = 18 AND quarter = 'q2' and year = 2021



//Plex Minutes Watched	24481096
SELECT sum(tot_hov)* 60 FROM WURL_VIEWERSHIP WHERE deal_parent = 21 AND quarter = 'q2' and year = 2021  


//TRC Linear Mins Watched	289,965,241
SELECT sum(tot_hov) * 60  FROM WURL_VIEWERSHIP WHERE deal_parent = 16 AND quarter = 'q2' and year = 2021



//Vizio Minutes Watched	10503726
SELECT sum(tot_hov) * 60 FROM WURL_VIEWERSHIP WHERE deal_parent = 20 AND quarter = 'q2' and year = 2021


//PlutoTV Minutes Watched	683155680
SELECT sum(total_viewing_minutes)  FROM PLUTO_VIEWERSHIP WHERE deal_parent = 29  AND quarter = 'q2' and year = 2021 and territory_id = 1




//Samsung Australia Minutes	1,167,448
SELECT sum(TOTAL_VIEWERSHIP_MINUTES) FROM AMAGI_VIEWERSHIP










//check revenue totals


//get total viewership by partner 