

-- Step 1. Pull data from dash (instructions: https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0)
select channel_name, sum(impressions), year_month_day from spotx g
where  channel_name not in (
'MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory') 
and DEAL_NAME like '%ubmatic%'
and DEAL_DEMAND_SOURCE != 'House Ad'
group by channel_name, year_month_day

-- Step 2. get gross_rev by month
select sum(impressions),year_month_day from spotx g
where  channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory') 
and DEAL_NAME like '%ubmatic%'
and DEAL_DEMAND_SOURCE != 'House Ad'
group by year_month_day




--Step 3. insert into monthly_revenue
insert into monthly_impressions(monthly_impressions, year_month_day, partner)
select sum(impressions), year_month_day, 'pubmatic' from spotx g
       where  channel_name not in ('MVMS: Gravitas',
        'CarShield Test',
        'Nosey Roku Test Channel',
        'MVMS: World Poker Tour',
        'MVMS: Shout Factory') 
        and DEAL_NAME like '%ubmatic%'
        and DEAL_DEMAND_SOURCE != 'House Ad'
        group by year_month_day



-- Step 4.  get share of each device per month using sum(impressions) / monthly_revenue
select (impressions / tot_impressions) as share , g.year_month_day from spotx g
join monthly_impressions m on (m.year_month_day = g.year_month_day)
where  channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory') 
and DEAL_NAME like '%ubmatic%'
and m.partner = 'pubmatic'
and DEAL_DEMAND_SOURCE != 'House Ad'

-- Step 5. Update share column in spotx table
update spotx s
set s.pub_share = q.qshare
from (
  select g.id as gid, (impressions / tot_impressions) as qshare , g.year_month_day from spotx g
  join monthly_impressions m on (m.year_month_day = g.year_month_day)
  where  channel_name not in ('MVMS: Gravitas',
  'CarShield Test',
  'Nosey Roku Test Channel',
  'MVMS: World Poker Tour',
  'MVMS: Shout Factory') 
  and DEAL_NAME like '%ubmatic%'
  and m.partner = 'pubmatic'
  and DEAL_DEMAND_SOURCE != 'House Ad'
)  q
where s.id = q.gid



select sum(share) , year_month_day from spotx g
 where  channel_name not in ('MVMS: Gravitas',
  'CarShield Test',
  'Nosey Roku Test Channel',
  'MVMS: World Poker Tour',
  'MVMS: Shout Factory') 
and DEAL_DEMAND_SOURCE != 'House Ad'
and DEAL_NAME like '%ubmatic%'
group by year_month_day



select s.id as qid, pub_share, impressions, pub_share * mr.tot_revenue as rev_share,  s.year_month_day, s.channel_name from spotx s
join monthly_revenue mr on (mr.year_month_day = s.year_month_day)
where s.channel_name not in ('MVMS: Gravitas',
'CarShield Test',
'Nosey Roku Test Channel',
'MVMS: World Poker Tour',
'MVMS: Shout Factory')
and s.DEAL_DEMAND_SOURCE != 'House Ad'
and DEAL_NAME like '%ubmatic%'


update spotx s
set s.pub_revenue = q.rev_share
from ( 
  select s.id as qid, pub_share, impressions, pub_share * mr.tot_revenue as rev_share,  s.year_month_day, s.channel_name from spotx s
  join monthly_revenue mr on (mr.year_month_day = s.year_month_day)
  where s.channel_name not in ('MVMS: Gravitas',
  'CarShield Test',
  'Nosey Roku Test Channel',
  'MVMS: World Poker Tour',
  'MVMS: Shout Factory')
  and s.DEAL_DEMAND_SOURCE != 'House Ad'
  and DEAL_NAME like '%ubmatic%'
  and mr.partner = 'pubmatic'
) q
where q.qid = s.id




select sum(impressions), year_month_day from spotx
where PUB_REVENUE is not null and channel_name like '%Roku%'
group by year_month_day,channel_name

select sum(impressions), year_month_day, channel_name from spotx
where 
deal_name in ('Pubmatic_Nosey_Roku NXB',
'Pubmatic_Nosey_Live NXB',
'Pubmatic_Nosey_Internal Roku NXB')
group by year_month_day, channel_name



select sum(impressions), year_month_day, d.name from spotx s
join nosey_staging.public.departments d on (d.id = s.department_id)
group by d.name, year_month_day



select sum(impressions), sum(pub_revenue), year_month_day, d.name  from spotx s 
join nosey_staging.public.departments d on (d.id = s.department_id)
where deal_name like '%ubmatic%'
group by  d.name, year_month_day









select sum(impressions), sum(pub_revenue), year_month_day  from spotx s 
join nosey_staging.public.departments d on (d.id = s.department_id)
where deal_name like '%ubmatic%'
group by year_month_day





