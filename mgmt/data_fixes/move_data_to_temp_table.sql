CREATE TABLE amagi_viewership_temp LIKE amagi_viewership;
ALTER TABLE amagi_viewership_temp ADD COLUMN id int IDENTITY(1,1);


create or replace sequence id_seq start = 1 increment = 1;


INSERT INTO amagi_viewership_temp  
SELECT *,id_seq.NEXTVAL   FROM amagi_viewership;