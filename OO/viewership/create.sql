create or replace table powr_viewership (
    id  integer default id_seq.nextval,
    uid varchar(155),
    title varchar(255),
    type varchar(55),
    channel varchar(155),
    views  number(12, 2),
    watch_time_seconds number(12, 2),
    average_watch_time_seconds  number(12, 2),
    platform varchar(55),
    geo varchar(55)
);
							

