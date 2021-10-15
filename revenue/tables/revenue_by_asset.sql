create temporary table revenue_by_asset (ref_id, deal_parent, month, monthly_rev,);


SELECT v.ref_id, v.deal_parent FROM WURL_VIEWERSHIP v JOIN REVENUE r ON (v.deal_parent = r.deal_parent AND v.month = r.year_month_day)



//monthly tot_hov  

SELECT SUM(tot_hov), month, deal_parent group by month, deal_parent


create temporary table monthly_hov (sum_hov, month, deal_parent);
AS SUM(tot_hov), month, deal_parent