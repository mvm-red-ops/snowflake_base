-- revenue calculation

-- get all revenue payments in 
    -- 47 samurai
    -- various invoices
    


-- sum revenue and insert into monthly_revenue (repeat for each partner one at a time)
insert into monthly_revenue(year_month_day, revenue, deal_parent, year, quarter)
select year_month_day, sum(revenue), deal_parent, year, quarter from revenue where deal_parent = 17 and year = 2021 and quarter = 'q3' 
group by year_month_day, deal_parent, year, quarter