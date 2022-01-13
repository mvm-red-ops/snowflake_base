//topline 
insert into monthly_expenses(deal_parent, year,quarter,amount, year_month_Day,channel_id )
  with r as(
      select  sum(amount) as expense,  invoice_month,channel, channelid
      from expenses
      where deal_parent =  16 and quarter = 'q3' and year = 2021
      group by invoice_month ,channelid, channel
   ) 
  select 16, 2021, 'q3', r.expense, r.invoice_month,  r.channelid
  from r;
  