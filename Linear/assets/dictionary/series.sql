create or replace sequence dict_seq start = 1 increment = 1;



create table assets.public.series(
    id  integer default dict_seq.nextval,
    name varchar(255)
)


Insert into series(entry, term)
values
('Cheaters Amazing Confrontations',	'cheatersamazingconfrontations'),
('Cristinas Court',	'cristinascourt'),
('La Las Full Court Life',	'lalasfullcourtlife'),
('Lifes Funniest Moments',	'lifesfunniestmoments'),
('Lionsgate Movies',	'lionsgatemovies'),
('Cristinas Court',	'cristinascourt'),
('Cheater\'s Amazing Confrontations',	'cheatersamazingconfrontations'),
('Cristina\'s Court',	'cristinascourt'),
('La La\'s Full Court Life',	'lalasfullcourtlife'),
('Life\'s Funniest Moments',	'lifesfunniestmoments')