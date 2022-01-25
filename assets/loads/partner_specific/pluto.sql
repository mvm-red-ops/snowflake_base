

    
copy into assets( TITLE, REF_ID, SERIES, CONTENT_PROVIDER)
from (select T.$1, T.$2, T.$3, T.$4 
    from @nosey_aws t) 
    pattern='.*pluto_assets_jan_21.*'
    file_format= 'NOSEY_ASSETS'
    ON_ERROR=SKIP_FILE FORCE=TRUE;


copy into assets( TITLE, REF_ID, SERIES, CONTENT_PROVIDER)
from (select T.$1, T.$2, T.$3, T.$4 
    from @nosey_assets t) 
    pattern='.*trc_vod_assets.*'
    file_format= 'NOSEY_ASSETS'
    ON_ERROR=SKIP_FILE FORCE=TRUE;
