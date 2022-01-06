
INSERT INTO topline_expenses(year, quarter, amount, deal_parent) 
  with ex as
    (  
      SELECT sum(amount) as amount, year, quarter, deal_parent FROM monthly_expenses WHERE deal_parent = 18 group by year, quarter, deal_parent
    )
  select ex.year, ex.quarter, ex.amount, ex.deal_parent
  from ex;
