-- DEALS WITH ALL INFORMATUON BY PARTNER
SELECT d.id, p.name as partner, pl.name  as platform, dt.name as deal_type, d.territoryids, d.channelIds FROM Deals d 
JOIN PARTNERS p ON p.id =d.PARTNERID 
JOIN PLATFORMS pl ON pl.id =d.PLATFORMID
JOIN TYPES dt ON dt.id =d.DEALTYPEID 



-- DEALS WITH INDIVIDUAL TERRITORY IDS
SELECT 
name as deal_name,
value
FROM DEALS,
lateral flatten(input => territoryIds);


-- DEALS WITH PARTNER NAMES
SELECT * FROM DEALS d 
JOIN  PARTNERS p ON (p.id = d.partnerid )
WHERE p.name = 'Pluto'
 

 
-- ADD TERRITORY ID TO DEAL
UPDATE deals 
SET territoryids = PARSE_JSON('[ "1", "4"]') WHERE id = 21


-- 
SELECT 
name, value as deal_name
FROM DEALS d,
lateral flatten(input => territoryIds);

