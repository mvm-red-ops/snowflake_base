//DEALS

    //id: 29

    //platform
    //Direct Delivery + Ingest

    //deal type
    //VOD + Linear

    //territories
    // [ "1", "3", "5" ]
    // United States, Latin America, United Kingdom

    //channels
    // [ "8", "10", "11", "13" ]
    //Nosey, Judge Nosey, Nosey Casos, Nosey Escándalos


//load hard values
//u.s.
//deal_parent : 29
//channel_id





const get_title = (s) => {

    const content = s.split(":");
    const title = content[1];
    if(content.length > 2) return null;

    const p_idx = title.indexOf("(");
    let t_final = title.slice(0, p_idx -1);
    console.log(t_final)
    return t_final

 }


const get_series = (s) => {
    s = s.toLowerCase();
    const content = s.split(":");
    const series = content[0];
    if(s.includes("jerry")) {
        return "The Jerry Springer Show";
        }
    if(s.includes("sally")) {
        return "Sally"
        }
    if(s.includes("trisha")) {
        return "Trisha";
        }
    if(s.includes("maury")) {
        return "Maury"
        }
    if(s.includes("divorce")) {
        return "Divorce Court"
        }
    if(s.includes("eye")) {
        return "Eye for an Eye"
        }
    if(s.includes("karen")) {
        return "Judge Karen"
    }
    if(s.includes("blind")) {
        return "Blind Date"
    }
    if(s.includes("wilkos")) {
        return "Steve Wilkos"
    }

    if(s.includes("emergency")) {
        return "Emergency"
    }   
     if(s.includes("mantracker")) {
        return "Mantracker"
    }


    else return null
}


get_series(`The Steve Wilkos Show BR: I Left You But You Are The Father (S17E111)`)