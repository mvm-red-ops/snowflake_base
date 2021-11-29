
-- //step 1 make sure the invidual expenses are in and accurate
//individual expense itmems
select sum(amount) from expenses e 
where deal_parent = 16 and quarter = 'q2' and year = 2021 and month = 6 




-- // check topline expenses 
select sum(amount), month, year, quarter,deal_parent  from expenses 
where deal_parent = 16 and quarter = 'q2' and year = 2021   
group by  month, year, quarter,deal_parent 

-- //insert into monthly expense table
insert into monthly_expenses(amount, month, year, quarter, deal_parent, channel)
select sum(amount), month, year, quarter,deal_parent, channel  from expenses 
where deal_parent = 16 and quarter = 'q2' and year = 2021
group by channel, month, year, quarter,deal_parent, channel


-- //query check
select * from monthly_expenses


-- update month string field string to join on 
update monthly_expenses 
set month_string = '20210401' 
where month = 4 and year = 2021



-- //sum up content partner total hov to get monthly share 
select sum(w.tot_hov), w.month, a.content_provider,p.name from wurl_viewership w
join assets a on (a.ref_id = w.ref_id)
join deals d on (d.id = w.deal_parent)
join partners p on (p.id = d.partnerid)
where w.quarter = 'q2' and w.year = 2021 and p.name = 'TRC' 
group by w.month, a.content_provider, w.deal_parent,p.name
insert into content_provider_share

-- //group by channel for trc 
select sum(w.tot_hov) / mv.tot_hov, w.month, a.content_provider, w.channel, p.name from wurl_viewership w
join assets a on (a.ref_id = w.ref_id)
join deals d on (d.id = w.deal_parent)
join partners p on (p.id = d.partnerid)
join monthly_viewership mv on (mv.month_string = w.month and mv.channel = w.channel)
where w.quarter = 'q2' and w.year = 2021 and p.name = 'TRC' 
group by a.content_provider, w.month, w.channel, mv.tot_hov, p.name


select * from content_provider_share