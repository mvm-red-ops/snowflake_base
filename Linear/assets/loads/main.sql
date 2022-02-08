COPY INTO NOSEY.PUBLIC.ASSETS
    FROM @MANAGE_DB.external_stages.nosey_aws;    
    file_format= @NOSEY_ASSETS
    pattern='.*asset_list.*'
    ON_ERROR=CONTINUE;
    
Insert into NOSEY.PUBLIC.ASSETS  (ID, TITLE, EPISODE, EPISODE_DETAILS, DESCRIPTION, SEASON, REF_ID, SERIES, CONTENT_PROVIDER, ORIGINAL_AIR_DATE, SOURCE_URL, ASSET_NAME, CREATEDAT,  UPDATEDAT, SERIES_SGENNO, EPISODE_SGENNO, SHOW_NUMBER_BD_AND_FW_ONLY)
Select T.$1, T.$2, T.$3, T.$4, T.$5, T.$6, T.$7, T.$8, T.$9, T.$10, T.$11, T.$12,  T.$16, T.$17, T.$14, T.$15 ,T.$13
 FROM @MANAGE_DB.external_stages.nosey_aws (FILE_FORMAT => 'nosey_assets') as T;




copy into assets(ref_id, EPISODE_DETAILS, TITLE, DESCRIPTION, DURATION, ORIGINAL_AIR_DATE, CONTENT_PROVIDER, SEASON, EPISODE,SERIES, CREATEDAT)
form (select T.$1, T.$2, T.$3, T.$4, T.$5, T.$6, T.$7, T.$8, T.$9, T.$10, T.$11, T.$12,  T.$16, T.$17, T.$14, T.$15 ,T.$13 from @nosey_aws t)
pattern = '.*asset_fix.*'
file_format = 'nosey_assets'
ON_ERROR=SKIP_FILE FORCE=TRUE;