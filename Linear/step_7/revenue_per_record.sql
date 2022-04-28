-- wurl 
    SELECT w.deal_parent, w.ref_id, w.month, share, w.tot_hov, w.tot_hov / m.tot_hov as calced_share, 
            mr.revenue as monthly_revenue, w.revenue, calced_share * mr.revenue as calc_rev
    FROM WURL_VIEWERSHIP w
    JOIN monthly_viewership m ON (m.month_string = w.month 
        AND m.deal_parent = w.deal_parent)
    JOIN monthly_revenue mr ON ( mr.deal_parent = w.deal_parent 
        AND mr.YEAR_MONTH_DAY = w.month)
    where w.quarter = 'q2' and w.deal_parent in ( 18, 20, 21) 


    UPDATE WURL_VIEWERSHIP wv
    SET CALC_REVENUE = t.calc_rev
    FROM (
    


    ) t
    WHERE wv.quarter = 'q2' AND wv.deal_parent in ( 18, 20, 21) 
    and wv.ref_id = t.ref_id and wv.month = t.month 
    and wv.deal_parent = t.deal_parent and wv.tot_hov = t.tot_hov   

    -- TRC
    update wurl_viewership w
    set w.calc_revenue = q.rev_share
    from    (
        select w.id as id, share, q.revenue, share * q.revenue as rev_share from wurl_viewership w
        join quarterly_revenue q on ( q.channel_id = w.channel_id and q.deal_parent = w.deal_parent and q.year = w.year and  q.quarter = w.quarter)
        where w.deal_parent = 16 and w.year = 2021 and w.quarter = 'q4' 
        )  q
    where w.id = q.id



-- amagi




-- pluto