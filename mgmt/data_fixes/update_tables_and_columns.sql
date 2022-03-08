create table expensees_temp clone expenses

delete from expensees_temp


alter table expensees_temp add column 
ID NUMBER(38,0) autoincrement



select * from expensees_temp


insert into expensees_temp(
  STATUS,
  INVOICE_MONTH,
  QUARTER,
  DEPARTMENT,
  TITLE,
  LABEL,
  TYPE,
  AMOUNT,
  REMAINING_ALLOCATION,
  MONTH,
  YEAR,
  DEAL_PARENT,
  CHANNEL
) select
STATUS,
INVOICE_MONTH,
QUARTER,
DEPARTMENT,
TITLE,
LABEL,
TYPE,
AMOUNT,
REMAINING_ALLOCATION,
MONTH,
YEAR,
DEAL_PARENT,
CHANNEL
  FROM expenses
  
  
  
  alter table expensees_temp rename to expenses



drop table expenses
  
alter table expensees_temp rename to expenses

