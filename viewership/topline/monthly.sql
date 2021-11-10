CREATE OR REPLACE TABLE monthly_viewership_wurl
(deal_parent number(6,0),
month number(2),
year number(4),
quarter varchar(2),
tot_hov number(12, 2)
)



insert into monthly_viewership_wurl (deal_parent,month,year,quarter,tot_hov, month_string)
  with wvm as
    (  select deal_parent,sum(tot_hov)as tot_hov,month 
     from WURL_VIEWERSHIP
     where quarter = 'q2' AND deal_parent = 21 and month = '20210601'
     group by month, deal_parent
     )
  select wvm.deal_parent,6, 2021,'q2',wvm.tot_hov,wvm.month
  from wvm;

