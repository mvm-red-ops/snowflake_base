
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





