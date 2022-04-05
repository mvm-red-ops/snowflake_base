
-- Pluto
SELECT sum(total_revenue), p.month, a.content_provider, p.deal_parent, 'pluto' FROM PLUTO_VIEWERSHIP p 
JOIN ASSETS a ON (a.ref_id = p.ref_id)
WHERE quarter = 'q2' and year = 2021 and deal_parent = 29
group by p.month, a.content_provider, p.deal_parent









-- Pluto 
-- //Pluto monthly content provider revenue 
SELECT sum(am.total_revenue),am.month, a.content_provider, am.deal_parent,'Pluto' as partner, t.name as territory  FROM pluto_viewership am
JOIN ASSETS a ON (a.ref_id = am.ref_id)
JOIN Territories  t ON (t.id = am.territory_id)
WHERE am.quarter = 'q2' and am.year = 2021 and  t.name = 'United Kingdom'
group by am.month, a.content_provider, am.deal_parent, t.name

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