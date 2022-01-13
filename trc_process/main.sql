select * from revenue where deal_parent = 16 


select  deal_parent,year, quarter, sum(tot_hov), channel from  monthly_viewership where deal_parent = 16  and quarter = 'q3' and year = 2021 group by deal_parent,year, quarter, channel



insert into quarterly_viewership(
    DEAL_PARENT,
    YEAR,
    QUARTER,
    TOT_HOV,
    CHANNEL
   )
select  deal_parent,year, quarter, sum(tot_hov), channel from  monthly_viewership where deal_parent = 16  and quarter = 'q3' and year = 2021   and channel != 'Nosey' 
 and channel != 'Real Nosey'  group by deal_parent,year, quarter, channel




create table quarterly_revenue(
    DEAL_PARENT number, 
    YEAR varchar(4),
    QUARTER varchar(2),
    REVENUE number(18, 2),
    CHANNEL varchar(155)
 )
   
insert into quarterly_revenue(
    DEAL_PARENT, 
    YEAR,
    QUARTER,
    REVENUE,
    CHANNEL
 )
 values 
 (16, 2021, 'q3', 305042.63, 'Nosey'),
 (16, 2021, 'q3', 196551.93, 'Real Nosey'),
 (16, 2021, 'q3', 0.03, 'Nosey Escandalos')

 
 
 select * from quarterly_revenue