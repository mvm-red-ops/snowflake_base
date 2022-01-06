
-- bandwith and adserving expenses april 21

( 'AdSpring Impressions Fee (CPM): Nosey inventory split on Roku' , 9743.995, 0.70, 6820.80, 2021, 'q2', 4, '20210401', 16),
( 'AdSpring Impressions Fee (CPM): RealNosey inventory split on Roku' , 7913.629, 0.70, 5539.54, 2021, 'q2', 4, '20210401', 16),
( 'Streaming (GB) Video Producer: Nosey on Roku', 1211920.782 , 0.0042, 5090.07, 2021, 'q2', 4, '20210401', 16),
( 'Streaming (GB) Video Producer: Nosey on Samsung',  778475.55, 0.0042, 3269.60, 2021, 'q2', 4, '20210401', 18),
( 'Streaming (GB) Video Producer: Nosey on Plex', 148940.2902, 0.0042, 625.55, 2021, 'q2', 4, '20210401', 21),
( 'Streaming (GB) Video Producer: RealNosey on Plex', 28197.2005, 0.0042, 118.43, 2021, 'q2', 4, '20210401', 21),
( 'Streaming (GB) Video Producer: RealNosey on Roku', 873952.2016, 0.0042, 3,670.60, 2021, 'q2', 4, '20210401', 16),
('AdSpring Impressions Fee (CPM): Nosey inventory split on Roku' , 12005.168, 0.62746, 7532.76, 2021, 'q2', 5, '20210501', 16),
('AdSpring Impressions Fee (CPM): RealNosey inventory split on Roku' , 8510.263, 0.62746, 5339.85, 2021, 'q2', 5, '20210501', 16),
('Streaming (GB) Video Producer: Nosey on Roku', 1290392.4355, 0.0042, 5419.65, 2021, 'q2', 5, '20210501', 16),
('Streaming (GB) Video Producer: Nosey on Samsung',  892448.1672, 0.0042, 3748.28, 2021, 'q2', 5, '20210501', 18),
('Streaming (GB) Video Producer: Nosey on Plex', 148940.2902, 0.0042, 625.55, 2021, 'q2', 5, '20210501', 21),
('Streaming (GB) Video Producer: RealNosey on Plex', 28197.2005, 0.0042, 118.43, 2021, 'q2', 5, '20210501', 21),
('Streaming (GB) Video Producer: RealNosey on Roku', 873952.2016, 0.0042, 3,670.60, 2021, 'q2', 5, '20210501', 16),
('AdSpring Impressions Fee (CPM): Nosey inventory split on Roku' , 15594.858, 0.58736, 9159.80, 2021, 'q2', 6, '20210601', 16),
('AdSpring Impressions Fee (CPM): RealNosey inventory split on Roku' , 10437.25, 0.58736, 6130.42, 2021, 'q2', 6, '20210601', 16),
('Streaming (GB) Video Producer: Nosey on Samsung',   977948.517, 0.0042, 4107.38, 2021, 'q2', 6, '20210601', 18),
('Streaming (GB) Video Producer: Nosey on Plex', 158417.7064, 0.0042, 665.35, 2021, 'q2', 6, '20210601', 21),
('Streaming (GB) Video Producer: Nosey on Roku', 1344591.9734, 0.0042, 5647.29, 2021, 'q2', 6, '20210601', 16),
('Streaming (GB) Video Producer: RealNosey on Roku', 819736.9041, 0.0042, 3442.90, 2021, 'q2', 6, '20210601', 16),
('Streaming (GB) Video Producer: RealNosey on Plex', 40678.5736, 0.0042, 170.85, 2021, 'q2', 6, '20210601', 21)



INSERT INTO expenses( DESCRIPTION, QUANTITY,RATE, AMOUNT, YEAR, QUARTER, MONTH, invoice_month,  DEAL_PARENT, CHANNEL, CHANNELID)
values ('Active Connector: RealNosey on Vizio, HLS Connector',	'1',	'800',	'800', 2021, 'q3', 9, '20210901', 20, 'Real Nosey', 9),
('Active Connector: Nosey on Xumo (VOD2)',	'1',	'400',	'400', 2021, 'q3', 9, '20210901', 17, 'Nosey', 8),
('Active Connector: Nosey on Roku, HLS Connector',	'1',	'750',	'750', 2021, 'q3', 9, '20210901', 16, 'Nosey', 8),
('Active Connector: Nosey on Samsung, HLS Connector',	'1',	'750',	'750', 2021, 'q3', 9, '20210901', 18, 'Nosey', 8),
('Active Connector: Nosey on Plex, HLS Connector',	'1',	'750',	'750', 2021, 'q3', 9, '20210901', 21, 'Nosey', 8),
('Active Connector: RealNosey on Plex, HLS Connector',	'1',	'750',	'750', 2021, 'q3', 9, '20210901', 21, 'Real Nosey', 9),
('Active Connector: RealNosey on Roku, HLS Connector',	'1',	'750',	'750', 2021, 'q3', 9, '20210901', 16, 'Real Nosey', 9)


INSERT INTO REVENUE(deal_parent, month, year, quarter, year_month_day, costs, type, title)
SELECT deal_parent, month, year, quarter, month_string, (0 - amount), 'connector', description FROM wurl_invoices where description like '%Active Connector%'
SELECT deal_parent, month, year, quarter, month_string, 0-amount, 'bandwidth', description FROM wurl_invoices  where description like '%AdSpring%'
SELECT deal_parent, month, year, quarter, month_string, 0-amount, 'adserving', description FROM wurl_invoices where description like '%GB%'
