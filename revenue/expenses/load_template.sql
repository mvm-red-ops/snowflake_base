copy into expenses(    
    status,
    invoice_month,
    department,
    title,
    label,
    type,
    amount,
    remaining_allocation,
    year,
    quarter,
    deal_parent)
from (select t.$1, 
       t.$2, 
       t.$3, 
       t.$4,
       t.$5,
       t.$6,
      to_number(REPLACE(REPLACE(t.$7, ','), '$'), 10, 2),  
      to_number(REPLACE(REPLACE(t.$8, ','), '$'), 10, 2),  
      '2021',
      'q2',
      16
from @expenses t) pattern='.*trc_linear_q2_2021.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;

