

copy into expenses(    
    department,
    title,
    amount,
    year_month_day,
    year,
    quarter)
from (select t.$1, 
       t.$2, 
       to_number(REPLACE(REPLACE(t.$3, ','), '$'), 10, 2),  
       t.$4,
      '2021',
      'q3'
from @expenses t) pattern='.*amagi_expenses_q3_2021.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;

