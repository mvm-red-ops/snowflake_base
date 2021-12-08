-- querying for value in an array
select * from territories t
where array_contains( 'US'::variant, t.abbreviations)


('Ive Been Spying On You...Youre Cheating!' , 'TR-1740', 'Trisha','NBC'),
('Is My Father Lying to Us?' , 'TR-0238', 'Trisha','NBC'),
('Ill Prove Your Moms a Liar!', 'TR-0162', 'Trisha','NBC')
