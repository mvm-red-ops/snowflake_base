SELECT sum(total_revenue), p.month, a.content_provider, p.deal_parent, 'pluto' FROM PLUTO_VIEWERSHIP p 
JOIN ASSETS a ON (a.ref_id = p.ref_id)
WHERE quarter = 'q2' and year = 2021 and deal_parent = 29
group by p.month, a.content_provider, p.deal_parent


//topline viewership by platform by month
SELECT * FROM monthly_viewership_wurl where year = 2021 and quarter = 'q2' and deal_parent = 18

//content partner viewership by platform by month 
SELECT month, sum(tot_hov) as content_viewership FROM WURL_VIEWERSHIP w 
JOIN Assets a ON (a.ref_id =w.ref_id ) 
WHERE deal_parent = 18 AND quarter = 'q2' and year = 2021 and a.content_provider = 'NBC'
group by a.content_provider, w.month

select * from wurl_viewership


SELECT * FROM REVENUE 
WHERE deal_parent = 18 and quarter = 'q2'

//content partner 
SELECT  a.ref_id, w.tot_hov, a.content_provider FROM WURL_VIEWERSHIP w 
JOIN Assets a ON (a.ref_id =w.ref_id ) 
WHERE deal_parent = 17 AND quarter = 'q2' and year = 2021 and a.content_provider = 'NBC'

SELECT CONTENT_PROVIDER,w.month,w.deal_parent, sum(w.tot_hov) 
FROM WURL_VIEWERSHIP w 
JOIN Assets a ON (a.ref_id =w.ref_id ) 
JOIN Revenue r ON (r.YEAR_MONTH_DAY = w.month and r.deal_parent = w.deal_parent and r.quarter = w.quarter)
WHERE w.quarter = 'q2' and w.year = 2021  and a.content_provider = 'NBC' and w.deal_parent = 18
GROUP BY CONTENT_PROVIDER, w.month,w.deal_parent
ORDER BY CONTENT_PROVIDER, w.deal_parent, w.month



SELECT CONTENT_PROVIDER, sum(w.TOTAL_VIEWERSHIP_MINUTES)  
FROM AMAGI_VIEWERSHIP w 
JOIN Assets a ON (a.ref_id =w.ref_id ) 
WHERE quarter = 'q2' and year = 2021  GROUP BY CONTENT_PROVIDER

SELECT CONTENT_PROVIDER, sum(w.total_viewing_minutes)  FROM PLUTO_VIEWERSHIP w JOIN Assets a ON (a.ref_id =w.ref_id ) WHERE quarter = 'q2' and year = 2021  GROUP BY CONTENT_PROVIDER


//Xumo Minutes	28815614.07
SELECT sum(tot_hov) * 60 FROM WURL_VIEWERSHIP WHERE deal_parent = 17 AND quarter = 'q2' and year = 2021

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


-- //AMAGI monthly content provider revenue 
SELECT sum(am.CALC_REVENUE),am.month, a.content_provider, am.deal_parent, 'amagi'  FROM amagi_viewership am
JOIN ASSETS a ON (a.ref_id = am.ref_id)
WHERE am.quarter = 'q2' and am.year = 2021 and am.deal_parent = 23
group by am.month, a.content_provider, am.deal_parent


-- //WURL monthly content provider revenue 
SELECT sum(w.CALC_REVENUE),w.month, a.content_provider, w.deal_parent  FROM wurl_viewership w
JOIN ASSETS a ON (a.ref_id = w.ref_id)
WHERE w.quarter = 'q2' and w.year = 2021 and w.deal_parent IN (18, 16, 20, 21, 17)
group by w.month, a.content_provider, w.deal_parent


SELECT * FROM content_partner_monthly_revenue

INSERT INTO content_partner_monthly_revenue(
revenue,
month, 
content_provider,
deal_parent,
platform)
SELECT sum(w.CALC_REVENUE),w.month, a.content_provider, w.deal_parent, 'wurl' FROM wurl_viewership w
JOIN ASSETS a ON (a.ref_id = w.ref_id)
WHERE w.quarter = 'q2' and w.year = 2021 and w.deal_parent IN (18, 16, 20, 21, 17)
group by w.month, a.content_provider, w.deal_parent

create table content_partner_monthly_revenue (
revenue number(15,3),
month varchar(8), 
content_provider varchar(255),
deal_parent integer,
platform varchar(155))