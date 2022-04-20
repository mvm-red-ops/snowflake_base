

//topline expenses 
select sum(amount), month, year, quarter,channel,deal_parent  from expenses 
where deal_parent in (18, 21) and quarter = 'q2' and year = 2021   
group by  month, year, quarter,deal_parent, channel

//insert into monthly table
insert into monthly_expenses(amount, month, year, quarter, deal_parent, channel)
select sum(amount), month, year, quarter,deal_parent, channel  from expenses 
where deal_parent in (18, 21)  and quarter = 'q2' and year = 2021
group by channel, month, year, quarter,deal_parent, channel








//calculate content partner monthly share 
-- insert into content_provider_share
select sum(w.tot_hov) / mv.tot_hov, w.month, a.content_provider, w.channel, p.name, 'q2', 2021 from wurl_viewership w
join assets a on (a.ref_id = w.ref_id)
join deals d on (d.id = w.deal_parent)
join partners p on (p.id = d.partnerid)
join monthly_viewership mv on (mv.month_string = w.month and mv.channel = w.channel and w.deal_parent = mv.deal_parent)
where w.quarter = 'q2' and w.year = 2021 and w.deal_parent in (18, 21)
group by a.content_provider, w.month, w.channel, mv.tot_hov, p.name
order by p.name, month, channel, content_provider


//calculate the expenses based on share
select p.name, cps.month, content_provider, cps.channel, e.quarter, type,title, share as partner_percentage, cps.share * e.amount as partner_expense_calculated, amount as expense_item_amount from content_provider_share cps
join expenses e on (e.invoice_month = cps.month and e.channel = cps.channel and e.deal_parent = cps.deal_parent)
join deals d on (d.id = e.deal_parent)
join partners p on (p.id = d.partnerid)
where e.deal_parent = 21
order by p.name, month, channel, content_provider

//example of aberrant record / register changes
//select w.tot_hov, w.ref_id, w.month, a.content_provider,p.name from wurl_viewership w
//join assets a on (a.ref_id = w.ref_id) 
//join deals d on (d.id = w.deal_parent)
//join partners p on (p.id = d.partnerid)
//where a.content_provider = 'Telegenic Entertainment' and w.quarter = 'q2' and w.year = 2021 and p.name = 'TRC' 





