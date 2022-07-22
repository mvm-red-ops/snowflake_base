-- the payment support is an overview sent to clients describing the expenses and revenue of a quarter
-- revenue (all platforms)
    -- wurl revenue
    -- amagi revenue
    -- pluto revenue
    -- oo revenue
--expenses 
    -- all platforms
        -- fees
    -- fixed costs
        -- language
        -- adserving
        -- close captioning
        -- bandwith
        -- storage


-- revenue description
    select label, payment_support_category, sum(amount) from register 
    where quarter = 'q4' and year = 2021 and content_provider = 'NBC' and label = 'Revenue'
    group by  payment_support_category, label



-- expense description

-- fixed costs 
    -- adserving, storage and bandwidth
    select label, payment_support_category, sum(amount) from register 
    where quarter = 'q4' and year = 2021 and content_provider = 'NBC'and label = 'Expense'
    group by  payment_support_category, label


    -- foreign language
    select sum(amount) from foreign_language_fixed_costs 
    where quarter = 'q4' and year = 2021 and content_provider = 'NBC'


    -- pmi costs
    select sum(amount) from pmi_costs 
    where year = 2021 and content_provider = 'NBC'

