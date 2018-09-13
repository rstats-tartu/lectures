

# Sissejuhatus {#intro}

See õpik on kirjutatud inimestele, kes kasutavad, mitte ei uuri, statistikat. 
Õpiku kasutaja peaks olema võimeline töötama R keskkonnas. 
Meie lähenemised statistika õpetamisele on arvutuslikud, mis tähendab, et me eelistame meetodi matemaatilise aluse asemel õpetada selle kasutamist ja tulemuste tõlgendamist. 
See õpik on bayesiaanlik ja ei õpeta sageduslikku statistikat. 
Me usume, et nii on lihtsam ja tulusam statistikat õppida ja et Bayesi statistikat kasutades saab rahuldada 99% teie tegelikest statistilistest vajadustest paremini, kui see on võimalik klassikaliste sageduslike meetoditega. 
Me usume ka, et kuigi praegused kiired arengud bayesi statistikas on tänaseks juba viinud selle suurel määral tavakasutajale kättesaadavasse vormi, toovad lähiaastad selles vallas veel suuri muutusi. 
Nende muutustega koos peab arenema ka bayesi õpetamine. 

Me kasutame järgmisi R-i pakette, mis on kõik loodud bayesi mudelite rakendamise lihtsustamiseks: "rethinking" [@rethinking], "brms" [@brms], "rstanarm" [@rstanarm], "BayesianFirstAid" [@bayesianfirstaid] ja "bayesplot" [@bayesplot]. 
Lisaks veel "bayesboot" bootstrapimiseks [@bayesboot]. 
Bayesi arvutusteks kasutavad need paketid Stan ja JAGS mcmc sämplereid (viimast küll ainult `BayesianFirstAid pakett). 
Selle õpiku valmimisel on kasutatud McElreathi [@mcelreath2015], Kruschke [@kruschke2014] ja Gelmani [@gelman2014] õpikuid.

# R keel

R on andmeanalüüsile spetsialiseeritud vabavaraline programmeerimiskeel. See on nn kõrge tasemega keel, mis tähendab, et selle selle keele "kõnelemine" ei ole liiga erinev inglise keele kõnelemisest. Erinevus on selles, et kui inglise keeles saab rääkida peaaegu kõigest, ja näiteks Pythoni programmeerimiskeeles sobib kõneleda kõigest, mida saab programmeerida, siis R-s on otstarbekas ja efektiivne teha andmeanalüüsi ja statistikat. R-i kasutusala on kitsam. Teine erinevus inglise keelest on, et R keele sõnad e funktsioonid, on pea alati tegusõnad. Näit sum() tähendab "take the sum", filter() tähendab "filter data" jne. Seega saab R koodi tõlkida kui "tee seda, siis tee toda", ja nii edasi.   

R-i põhiline eelis näiteks Pythoni ees (tema suurim konkurent andmeanalüüsil) on, et R-s on olemas suurem valik abifunktsioone, mis võimaldavad sujuvamaid, paremini inimloetavaid ja lihtsamini õpitavaid andmeanalüüsi töövooge, eriti mis puudutab jooniste tegemist. Valdav enamik professionaalseid statistikuid kasutab R-i, samas kui inseneride ja keemikute seas on pigem populaarne Python ja näiteks pildianalüüsil ruulib Matlab. Kõike, mida saab teha R-is, saab teha ka Pythonis ja Matlabis (ja enamasti ka vastupidi). 

R-i arendavad selle keele igapäevased kasutajad, kelle hulgas on juhtivad statistikud/ andmeanalüütikuid. Seega (1) jõuavad uued meetodid sageli enne R-i kui kuhugi mujale, (2) sa tead täpselt, kes tegi selle meetodi, mida sa täna kasutasid (ja kus on selle viide kirjanduses), (3) sa võid kirjutada meetodi autorile ja abi küsida. Kuigi R-i abifailid võivad olla rudimentaarsed, keerulised või lihtsalt kasutud, annab guugeldamine vastuse enamustele küsimustele.

# Andmeanalüüs

Andmeanalüüs on see osa teadusprojektist, mis enamasti algab siis, kui katse/vaatlus lõpeb. Andmeanalüüsi motiveerivad teaduslikud küsimused, kuid selle formaalsed väljundid on hoopistükis kujul (1) summaarsed statistikud, (2) joonised ja (3) statistilised mudelid. Need andmeanalüüsi tulemused konverteeritakse omakorda mitteformaalsel moel teaduslikeks hüpoteesideks, tulemusteks ja järeldusteks. Seega on andmeanalüüsi vahetuks sisendiks enamasti tabelid, mis sisaldavad arve (ja muud), ning vahetuks väljundiks joonised ja tabelid. Aga sellest hoolimata ei tegele andmeanalüüs primaarselt arvudega vaid teaduslike hüpoteesidega. Seega ei ole andmeanalüüs mitte matemaatika osa, vaid osa teaduslikust protsessist (mis kasutab matemaatikat tööriistana). 

Me nimetame seda, mida me teeme andmeanalüüsiks, mitte statistikaks, selle pärast, et juhtida tähelepanu asjaolule, et valdav osa andmeanalüüsi töömahust ei kulu praktikas mitte statistilisete mudelitega töötamisele, ega isegi mitte jooniste tegemisele, vaid andmete puhastamisele, transformeerimisele ning analüüsiks sobivale kujule viimisele.  

Andmeanalüüsi etapiks on katseskeem juba lõplikult valmis - me teame, mis on kontroll- ja mis on katsetingimused, mitu korda ja millisel tasemel on katset korratud jne - katsed lõpetatud ja tulemused üles tähendatud. Kui läbi viidud katse või selle dokumenteerimine ei ole analüüsiks optimaalne, on enamasti juba hilja (loe: kulukas) midagi muuta. Seega oleks hea, kui andmeanalüüsi plaan valmiks paralleelselt katse plaaniga ja me teaksime juba enne katse alustamist, kuidas selle tulemusi analüüsima hakkame. Ideaalis mängime me juba enne katse alustamist analüüsi läbi simuleeritud andmetel, mis võimaldab meil näiteks otsustada, mitu korda on mõtekas päris katset korrata. 

Kahjuks on eelnevad soovid enamasti vaid utoopia: inimesed, kes katset planeerivad ei mõtle sageli üldse sellele, kuidas hiljem tulemusi analüüsida. Mida keerukam katseskeem või suurem andmehulk, seda suurema tõenäosusega antakse andmed analüüsida inimesele, kes ei osalenud katse planeerimisel ja kes sageli ei ole ka spetsialist teaduses, millest antud katseskeem võrsus. 

## Mida andmeanalüütik peaks küsima, enne kui ta alustab.

1. Teaduslik taust - millistele teaduslikele küsimustele tahetakse vastust leida, ja millistel küsimustel on juba vastus olemas (neile andmete põhjal vastuse otsimine oleks ajaraiskamine). 

2. Katse taust - miks on tehtud just selline katse/vaatlus ja mitte teistsugune. Kas katse on väga kallis/ajakulukas või saab seda vajadusel modifitseerida ja üle teha?

3. Katse skeem - mis on kontroll- ja mis on katsetingimused. Kas me soovime võrrelda erinevaid katsetingimusi omavahel või piirdume katse-kontroll võrdlustega? Mitu korda on katset korratud. Kas tegu on tehniliste ja/või teaduslike korduskatsetega? [Milline on selle katse üldistusjõud?] Kas katseskeem on hierarhilise struktuuriga või mitte? [Kas sama mõõtmisobjekti on mõõdetud mitu korda? Kas katses on võimalikke batch-i-efekte, mida saab tuvastada?] 

4. Mida on mõõdetud ja mida me teame mõõtmisaparatuuri, mõõtmistäpsuse ja -hajuvuse kohta.

5. Varieeruvus - Kas mõõtmisviga on suur või väike võrreldes mõõtmisobjektide loomuliku ja teaduslikult huvitava varieeruvusega. Kas andmete üldine varieeruvus on ootuspärane või üllatavalt väike/suur? Kas meil on põhjust arvata, et katse ja kontrolltingimustel võiksid olla tulemused erineva varieeruvuse määraga (ja/või erineva jaotusega)? 

5. Kas me mõõdame teaduslikus mõttes õiget asja või tuleb mõõtmistulemusi kuidagi transformeerida, et need muutuks teaduslikult huvitavaks (näiteks kaal ja pikkus transformeerida kehamassiindeksiks).

6. Millisel kujul on meie poolt analüüsitav mõõtmistulemus (pidev suurus, diskreetne suurus, kahe arvu suhe, faktor, suunaline faktor jms) ja milline võiks olla selle jaotus (Poisson, binoom, normaal, lognormaal jms). 

7. Mis on analüüsi vahetu eesmärk. Kas me soovime saada sissevaadet bioloogilisse mehhanismi, mis meie andmed genereeris, või soovime hoopis ennustada mingi muutuja väärtusi, teiste muutujate väätruste põhjal? Kas rõhuasetus on formaalsetel mudelitel, mis testivad olemasolevaid hüpoteese, või eksploratoorsel graafilisel analüüsil, eesmärgiga genereerida uusi hüpoteese? Kas tegemist on pigem eelkatsega?

8. Milline on andmete struktuur ja kvaliteet? Kas meil on muutujaid, mida tasuks välja visata või ühendada (seesama kehamassiindeksi näide)? Kas me peame erinevaid andmetabeleid ühendama või vastupidi lahku ajama? Kui palju on meil puuduvaid andmeid, kuidas on need kodeeritud ja miks nad puuduvad? Kas me peaksime proovima puuduvaid andmeid imputeerida? Kas andmetes on selgeid vigu (absurdseid väärtusi)? Kui kõrge või madal on andmestiku üldine kvaliteet? 

9. Kas me saame aru, millised andmed on igas veerus - mida tähendab kodeering "sugu: 3" või "vanus: 99"?

10. Kes on andmete omanik (inimene, kes teeb teie analüüsi põhjal teaduslikke järeldusi)? Kas talle on võimalik selgitada, millised on analüüsi tulemused ja kas ta suudab neid kasutada teaduslike järelduste formuleerimisel? Teie analüüsi tarbija ei ole mitte niivõrd teadusartikli lugeja vaid inimene, kes selle artikli kirjutab. Ja kui ta ei suuda teie tööd kasutada, ei ole teil põhjust sellele oma aega raisata. Paljud teadlased usuvad pikale elukogemusele toetudes, et statistika on retooriline vahend, mis toodab p väärtusi, mis avavad ajakirjade uksed. Nende jaoks on sisuline andmeanalüüs nagu jõuluvana, maagiline tegelane, kellest küll räägime lastele, aga kellele täiskasvanud meeleldi oma aega ei kuluta. 

Kokkuvõtteks: andmeanalüüs ei ole lihtne ega automaatne protsess, millel oleks üks õige viis, kuidas seda teha. Vähegi keerulisema ülesande korral võite olla üsna kindel, et leidub sama palju mõistlikke andmeanalüüsi töövooge, kui palju on leida mõistlikke andmeanalüütikuid.  

Andmeanalüüsis on lihtne teha ausaid vigu koodikirjutamise näpukatest sobimatute mudelite rakendamiseni. Selle pärast on tähtis kontrollida, et iga koodirida ikka teeks seda, mida te arvasite seda tegevat. Teine oluline punkt on, et teie kood peaks olema raprodutseeritav, mis tähendab, et iga soovija peaks suutma algse andmetabeli olemaolul teie koodi jooksutada algusest lõpuni ilma veateateid saamata ja saama teiega identsed (või väga sarnased) tulemused. Siis on suurem võimalus, et vead avastatakse ja parandatakse. Pane tähele, et on olemas BioArxiv, kuhu saab oma käsikirja ja koodi talletada ammu enne avaldamist mõnes eelretsenseeritavas ajakirjas. See võimaldab fikseerida oma avastuste prioriteet, aga ka anda teadusüldsusele võimalus leida ja parandada vead, enne kui need suurt piinlikust valmistama hakkavad.

    Analüüsi reprodutseeritavuseks on vaja kolme asja. Algne andmetabel 
    näit .csv laiendiga, R-i kood .Rmd või .R laiendiga ja ReadMe dokument, 
    kus on kirjas mis on mis andmetabelis, pluss katseskeemi kirjeldus.
    






