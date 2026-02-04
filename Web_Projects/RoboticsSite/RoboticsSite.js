// Set up the other pages, especially the RISD and RWJH one
var siteLinks = {1: "https://schools.risd.org/RichardsonWestJH", //RWJH 
                 0: "http://www.richardson.k12.tx.us/", //RISD
                 2:"https://focus.risd.org/focus/index.php"}; //Focus

function toSite(newSite){
    window.open(siteLinks[newSite]);
}