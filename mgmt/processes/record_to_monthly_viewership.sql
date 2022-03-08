 insert into monthly_viewership (deal_parent,month,year,quarter,tot_hov, month_string)
   with r as
     (SELECT month, quarter, sum(tot_hov)as hov FROM WURL_VIEWERSHIP WHERE deal_parent = 16 AND quarter = 'q2'AND month ='20210401'group by month, quarter )
   select 16, 4, 2021, r.quarter,r.hov,r.month
   from r;   