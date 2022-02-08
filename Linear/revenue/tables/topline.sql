CREATE TABLE topline_revenue
(deal_parent number(6,0),
month number(2),
year number(4),
quarter varchar(2),
revenue number(12, 2)
)





Invoice Month	Department	Title	Label	Type	Sum/Count	 Amount
			 Revenue - Nosey	Revenue	TRC Linear   $
	20210501		 Revenue - Nosey	Revenue	TRC Linear   $
	20210601		 Revenue - Nosey	Revenue	TRC Linear   $
	20210501		 Revenue - RealNosey	Revenue	TRC Linear   $
	20210601		 Revenue - RealNosey	Revenue	TRC Linear   $



INSERT INTO REVENUE(month, year, quarter, deal_parent, revenue, year_month_day, channel, partner)
values (4, 2021, 'q2', 16, 86860.85, 20210401, 'Nosey', 'TRC Linear'),
(4, 2021, 'q2', 16, 80445.12, 20210401, 'Real Nosey', 'TRC Linear'),
(5, 2021, 'q2', 16, 98835.15, 20210501, 'Nosey', 'TRC Linear'),
(5, 2021, 'q2', 16, 84941.40, 20210501, 'Real Nosey', 'TRC Linear'),
(6, 2021, 'q2', 16, 92902.33, 20210601, 'Nosey', 'TRC Linear'),
(6, 2021, 'q2', 16, 76796.64, 20210601, 'Real Nosey', 'TRC Linear')



	20210401		 Revenue - 	Revenue	TRC Linear   $

    ID	NUMBER(38,0)
MONTH	NUMBER(2,0)  
YEAR	NUMBER(4,0)
QUARTER	VARCHAR(5)
REVENUE	NUMBER(12,2)
DEAL_PARENT	NUMBER(38,0)
YEAR_MONTH_DAY	VARCHAR(10)
PROVIDER	VARCHAR(55)
PARTNER	VARCHAR(75)
CHANNEL	VARCHAR(55)






