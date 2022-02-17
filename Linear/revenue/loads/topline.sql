
insert into topline_revenue(deal_parent, year, quarter, revenue)
  with rev as
    (select deal_parent, year, quarter, sum(revenue) as revenue
     from revenue 
     WHERE deal_parent = 21 
     group by(deal_parent, year, quarter)
    )
  select deal_parent, year, quarter, revenue
  from rev;