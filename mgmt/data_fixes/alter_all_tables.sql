alter table "NOSEY_TESTING"."PUBLIC".expenses rename column  invoice_month to year_month_day
alter table "NOSEY_STAGING"."PUBLIC".expenses rename column  invoice_month to year_month_day
alter table "NOSEY_PROD"."PUBLIC".expenses rename column  invoice_month to year_month_day
alter table "NOSEY_ARCHIVE"."PUBLIC".expenses rename column  invoice_month to year_month_day

