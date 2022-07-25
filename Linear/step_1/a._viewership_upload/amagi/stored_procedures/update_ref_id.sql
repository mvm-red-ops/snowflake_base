-- get ref id and series 
CREATE OR REPLACE FUNCTION get_ref_id_amagi(s STRING)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
AS' 
    let r1 = S.split("-");
    let content = [];

    for(const r of r1 ){
        if(r.includes("_")){
            let r2 = r.split("_");
            for(const c of r2){
                content.push(c);
            } 
        } else {
            content.push(r)
        }
    }

    const ref_id = content[0] + "-" + content[1];
    return ref_id
';



