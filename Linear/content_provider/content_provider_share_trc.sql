


//calculate content partner monthly share 
-- insert into content_provider_share
select sum(w.tot_hov) / mv.tot_hov, w.month, a.content_provider, w.channel, p.name, 'q3', 2021 from wurl_viewership w
join assets a on (a.ref_id = w.ref_id)
join deals d on (d.id = w.deal_parent)
join partners p on (p.id = d.partnerid)
join monthly_viewership mv on (mv.month_string = w.month and mv.channel = w.channel and w.deal_parent = mv.deal_parent)
where w.quarter = 'q3' and w.year = 2021 and w.deal_parent =16
group by a.content_provider, w.month, w.channel, mv.tot_hov, p.name
order by p.name, month, channel, content_provider


//calculate the expenses based on share
select p.name, cps.month, content_provider, cps.channel, e.quarter, type,title, share as partner_percentage, cps.share * e.amount as partner_expense_calculated, amount as expense_item_amount from content_provider_share cps
join expenses e on (e.invoice_month = cps.month and e.channel = cps.channel and e.deal_parent = cps.deal_parent)
join deals d on (d.id = e.deal_parent)
join partners p on (p.id = d.partnerid)
where e.deal_parent = 21
order by p.name, month, channel, content_provider






//individual expense itms
select amount,channel, deal_parent, month from expenses e 
where deal_parent =16 and quarter = 'q3' and year = 2021 
group by deal_parent, channel, month

select * from expenses e 
where deal_parent =16 and quarter = 'q3' and year = 2021 



//topline expenses 
select sum(amount), month, year, quarter,channel,deal_parent  from expenses 
where deal_parent =16 and quarter = 'q3' and year = 2021   
group by  month, year, quarter,deal_parent, channel

//insert into monthly table
insert into monthly_expenses(amount, month, year, quarter, deal_parent, channel)
select sum(amount), month, year, quarter,deal_parent, channel  from expenses 
where deal_parent =16  and quarter = 'q3' and year = 2021
group by channel, month, year, quarter,deal_parent, channel



//query check
select * from monthly_expenses
where deal_parent =16  and quarter = 'q3' and year = 2021 

select sum(tot_hov), deal_parent, month, channel from wurl_viewership where deal_parent =16  and quarter = 'q3' group by month,channel, deal_parent
insert into monthly_viewership(tot_hov, deal_parent, month_string, channel, year)
select sum(tot_hov), deal_parent, month, channel, 2021 from wurl_viewership where deal_parent =16  and quarter = 'q3' group by month,channel, deal_parent

select * from monthly_viewership
where deal_parent =16 and year = 2021

//update monthly_expenses 
//set month_string = '20210401' 
//where month = 4 and year = 2021
//
//update monthly_expenses 
//set month_string = '20210501' 
//where month = 5 and year = 2021
//
//update monthly_expenses 
//set month_string = '20210601' 
//where month = 6 and year = 2021





