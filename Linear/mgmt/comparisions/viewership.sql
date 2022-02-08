//viewership total by quarter
SELECT deal_parent, sum(tot_hov) FROM WURL_VIEWERSHIP WHERE month in ('20210401','20210501','20210601')  AND tot_hov IS NOT NULL GROUP BY deal_parent


//viewership total by quarter and asset 
SELECT deal_parent, ref_id, sum(tot_hov), sum(revenue) FROM WURL_VIEWERSHIP WHERE month in ('20210401','20210501','20210601')  AND tot_hov IS NOT NULL GROUP BY deal_parent, ref_id

