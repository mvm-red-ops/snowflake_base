
-- Step 1. Pull data from dash (instructions: https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0)

-- Step 2. get gross_rev by month
select sum(gross_revenue),year_month_day from spotx g
where  channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory') 
and DEAL_DEMAND_SOURCE != 'House Ad'
group by year_month_day

--Step 3. insert into monthly_impressions
insert into monthly_revenue(tot_revenue, year_month_day, partner)
select sum(gross_revenue), year_month_day, 'spotx' from spotx g
       where  channel_name not in ('MVMS: Gravitas',
        'CarShield Test',
        'Nosey Roku Test Channel',
        'MVMS: World Poker Tour',
        'MVMS: Shout Factory') 
        group by year_month_day



-- Step 4.  get share of each device per month using sum(impressions) / monthly_impressions
select (gross_revenue / tot_revenue) as share , g.year_month_day from spotx g
join monthly_revenue m on (m.year_month_day = g.year_month_day)
where  channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory') 
and DEAL_DEMAND_SOURCE != 'House Ad'

-- Step 5. Update share column in spotx table
update spotx s
set s.share = q.qshare
from (
  select g.id as gid, (gross_revenue / tot_revenue) as qshare , g.year_month_day from spotx g
  join monthly_revenue m on (m.year_month_day = g.year_month_day)
  where  channel_name not in ('MVMS: Gravitas',
  'CarShield Test',
  'Nosey Roku Test Channel',
  'MVMS: World Poker Tour',
  'MVMS: Shout Factory') 
  and DEAL_DEMAND_SOURCE != 'House Ad'
)  q
where s.id = q.gid


-- CHECK sum share by month to make sure total = 1
select sum(share) , year_month_day from spotx g
group by year_month_day


-- step 6. insert revenue from spotx payment supports 


-- step 7 calculate the rev_share per record 
select share, r.revenue, share * r.revenue as rev_share,  s.year_month_day, s.channel_name from spotx s
join revenue r on (r.year_month_day = s.year_month_day and r.deal_parent = s.deal_parent)
where s.channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory')
and s.DEAL_DEMAND_SOURCE != 'House Ad'


-- step 8. update records
update spotx s
set s.revenue = q.rev_share
from ( select s.id as qid, share, r.revenue, share * r.revenue as rev_share,  s.year_month_day, s.channel_name from spotx s
join revenue r on (r.year_month_day = s.year_month_day and r.deal_parent = s.deal_parent)
where s.channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory')
and s.DEAL_DEMAND_SOURCE != 'House Ad') q
where q.qid = s.id




