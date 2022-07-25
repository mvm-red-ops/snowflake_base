    -- Can prob combine statements
    CREATE OR REPLACE FUNCTION get_series_id_amagi(s STRING)
        RETURNS VARCHAR
        LANGUAGE JAVASCRIPT
        AS '
            s = S.toLowerCase();
                if(s.includes("jerry")) {
                    return "8";
                    }
                if(s.includes("sally")) {
                    return "32"
                    }
                if(s.includes("trisha")) {
                    return "43";
                    }
                if(s.includes("maury")) {
                    return "29"
                    }
                else return null
        ';



