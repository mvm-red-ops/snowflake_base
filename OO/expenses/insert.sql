insert into expenses (amount, month_year, type, partner, year, quarter)
(select REPLACE(REPLACE($1, ','), '$', ''), $2, $3, $4, $5, $6),
from values
('$1,619.60', 	'Nov-21',	'Streaming',	'powr', 2021, 'q4'),
('$1,674.51', 	'Oct-21',	'Platform',	'powr', 2021, 'q4'),
('$7,500.00', 	'Oct-21',	'Platform',	'powr', 2021, 'q4'),
('$1,737.69',   'Dec-21',	'Streaming', 'powr', 2021, 'q4'),
('$7,500.00', 	'Nov-21',	'Platform',	'powr', 2021, 'q4'),
('$7,500.00', 	'Dec-21',	'Platform',	'powr', 2021, 'q4'),
('$1,229.53', 	'Oct-21', '','aws', 2021, 'q4'),
('$1,369.34' ,	'Nov-21', '','aws', 2021, 'q4'),
('$1,444.17' ,	'Dec-21', '','aws', 2021, 'q4'),
('$1,000.00', 	'Oct-21', 'adserving','OAO', 2021, 'q4'),
('$1,000.00' ,	'Nov-21', 'adserving','OAO', 2021, 'q4'),
('$1,142.93' ,	'Dec-21', 'adserving','OAO', 2021, 'q4')  