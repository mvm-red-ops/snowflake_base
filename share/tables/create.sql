create temporary table monthly_hov (sum_hov, month, deal_parent) AS
SELECT SUM(tot_hov), month, deal_parent FROM WURL_VIEWERSHIP WHERE deal_parent != 17 group by month, deal_parent 
