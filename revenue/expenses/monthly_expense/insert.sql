//topline 
INSERT INTO monthly_expenses(month, year, quarter, amount, deal_parent) 
  with ex as
    (  
      SELECT deal_parent, month, sum(amount) as amount, year, quarter FROM expenses GROUP BY month, year, quarter, deal_parent
    )
  select ex.month, ex.year, ex.quarter, ex.amount, ex.deal_parent
  from ex;


