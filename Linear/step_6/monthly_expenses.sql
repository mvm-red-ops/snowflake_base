select sum(amount), deal_parent, year_month_day, year, quarter, channel, channel_id from expenses where year = 2021 and quarter = 'q4'
group by deal_parent, year_month_day, year, quarter, channel, channel_id



-- insert into monthly_expenses
insert into monthly_expenses(amount, deal_parent, year_month_day, year, quarter, channel_id )
select sum(amount), deal_parent, year_month_day, year, quarter, channel_id 
from expenses where year = 2021 and quarter = 'q4'
group by deal_parent, year_month_day, year, quarter, channel_id


