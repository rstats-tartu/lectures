


```r
library(tidyverse)
library(VIM)
library(readxl)
library(skimr)
```


# R-i tööpõhimõte

Iga kord, kui avate R studio, alustate R-i sessiooni, mis seisneb funktsioonide (väikeste programmijuppide) rakendamises andmetele eesmärgiga muuta tabelite struktuuri, transformeerida andmeid, genereerida jooniseid ja/või arvutada statistikuid. Kõik see toimub R-i töökeskkonnas. Tulemusi saab töökeskkonnast eksportida arvuti kõvakettale näiteks .pdf (joonised) või .csv (tabelid) formaadis. Teie sessiooni põhiline tulemus ei ole siiski eksporditavad asjad, vaid R-i kood (script), mida jooksutades on võimalik korrataval viisil algset andmetabelit manipuleerida. Kõik, mida te töökeskonnas teete, kajastub koodis ja on korratav.

R-i sessioon näeb üldjoontes välja niimoodi:


 (1) Andmed ja funktsioonid (raamatukogude kujul) loetakse R-i töökeskkonda, (2) andmeid töödeldakse funktsioonide abil ja (3) tööproduktid eksporditakse/salvestatakse teistele programmidele kättesaadavasse vormi.  

* töökeskkond (workspace) - sisaldab üles laetud objekte

* keskkond (environment) - sisaldab nimega seotud objekte

* pakett e raamatukogu - sisaldab funktsioone, andmeid ja seletavaid faile

* funktsioon - R-i alamprogramm

* argument - funktsiooni tööd reguleeriv parameeter 

* objekt - funktsioon, andmestruktuur ja mida iganes saab töökeskkonda viia

* nimi - objekt seotakse nimega <- abil, et see keskkonnas nähtavaks/taaskasutatavaks muuta

**Andmetüübid:**

* character - tähemärgid

* numeric (double) - ratsionaalarvud

* integer - täisarvud

* factor - muutuja, millel on loetud hulk nimedega "tasemeid" (levels), kus iga tase on sisemiselt kodeeritud täisarvuga alates 1st. On olemas nii järjestatud kui järjestamata tasemetega faktorid. Näit "mees"-naine on tüüpiliselt järjestamata tasemed, aga vähe-keskmiselt-palju peaks olema järjestatud.

* logical - TRUE/FALSE. TRUE on sisemiselt kodeeritud kui 1 ja FALSE kui 0. 

**relatsioonilised operaatorid**

* >, >= (on suurem või võrdne), <, <=, 

* == (võrdub), 

* != (ei võrdu), 

* %in% (sisaldub), 

* & (and),

* | (or)


```r
1 == 2
#> [1] FALSE
1 != 2
#> [1] TRUE

1 %in% 1:5
#> [1] TRUE
1&4 %in% 1:5 #1 ja 4 sisalduvad vektoris c(1, 2, 3, 4, 5) --- TRUE
#> [1] TRUE
c(1, 8) %in% 1:5
#> [1]  TRUE FALSE
1|8 %in% 1:5 #1 või 8 sisalduvad vektoris c(1, 2, 3, 4, 5) --- TRUE
#> [1] TRUE
6 %in% 1:5 #6 sisaldub vektoris c(1, 2, 3, 4, 5) --- see lause on FALSE
#> [1] FALSE
char.vector <- c("apple", "banana", "cantaloupe", "dragonfruit")
"apple" %in% char.vector
#> [1] TRUE
```


**andmeklassid:** (idee on andmed struktureerida hõlbustamaks edasisi tehteid nendega)

* vektor - 1D järjestatud sama tüüpi andmed 

* list - kokku kogutud, järjestatud ja nimetatud objektid (vektorid, andmeraamid, mudelid, teised listid jms)

* maatriks - 2D neljakandiline andmestruktuur, mis koosneb sama tüüpi andmetest 

* andmeraam (data frame, tibble) - 2D neljakandiline andmestruktuur, mis koosneb veeru kaupa kõrvuti asetatud ühepikkustest vektoritest (erinevad vektorid võivad sisaldada erinevaid tüüpi andmeid). Lähim asi nelinurksele tabelile (aga Exceli tabelis -- erinevalt R-st -- saab samasse veergu panna ka erinevat tüüpi andmeid).


Avades R Studio peaksite nägema tühja keskkonda (Enviroment tab, ülal paremas aknas). R-i tööpõhimõte on järgmine. 

(1) te laete võrgust alla ja installeerite oma kõvakettale vajalikud R-i alamprogrammid, mida kutsutakse pakettideks ehk raamatukogudeks. Paketid on funktsioonide (kuigi mitte ainult) kogud. Need funktsioonid ei ole aga veel R-s kasutamiseks kättesaadavad.  

(2) te loete R-i töökeskkonda (workspace) sisse vajalikud paketid (oma kõvakettalt) ja andmetabeli(d), mida soovite töödelda (oma kõvakettalt või otse võrgust), muutes need seega R-s kasutatavaks. Seda tuleb teha igal R-i sessioonil uuesti. Igat asja, mis on töökeskkonnas, kutsutakse objektiks. Objektid, mis on omistatud nimele, ilmuvad nähtavale Enviroment tab-i, koos oma struktuuri lühikirjeldsega.

(3) Te sisestate töökeskkonnas olevatesse funtksioonidesse andmed ja argumendid. Sageli teeb üks funktsioon ühte toimingut, mistõttu koosneb teie töövoog funktsioonide rakendamisest üksteise järel sellisel moel, et eelmise funktsiooni väljund on sisend järgmisele funktsioonile. 

(4) Te ekspordite/salvestate oma kõvakettale need objektid (tabelid, joonised), mida soovite tulevikus avada teiste programmidega. Samuti salvestate oma põhilise töötulemuse - R-i scripti (näit .Rmd või .R laiendiga failina).

Järgmise sessiooni saate alustada juba oma salvestatud koodi baasilt --- jooksutades algandmete peal olemasoleva koodi ning seejärel lisades uut koodi (andmetabeli ja raamatukogud tuleb iga sessiooni jaoks uuesti keskkonda sisse lugeda).


## Funktsioon

* Hea funktsioon teeb ühte asja. Näiteks funktsioon `t()` ( _t_ tähendab _transpose_) transponeerib maatriksi nii, et ridadest saavad veerud ja vastupidi, aga funktsioon `c()` ( _c_ tähendab _combine_ v _concatenate_ ) moodustab sisestatud objektidest vektori. 

* Funktsiooni nime taha käivad sulud. Ilma sulgudeta funktsiooni nime jooksutamine annab väljundina selle funktsiooni koodi.

* Enamustel funktsioonidel on argumendid, mis käivad sulgude sisse ja on üksteisest komadega eraldatud. Kasutaja saab argumentidele anda väärtused, mis määravad andmed, millel funktsioon töötab, ja selle, mida funktsioon nende andmetega täpselt teeb. Funktsiooni iga argument täpsustab funktsiooni jaoks, mida teha.

* Osadel argumentidel on vaikeväärtused, mida saab käsitsi muuta. Vaikeväärtused, nagu ka funktsiooni argumentide nimekirja ja kirjelduse, leiab `?funktsiooni_nimi` (ilma sulgudeta) abil. NB! Ära kasuta funktsioone, mille argumente sa ei tunne.

* Argumendid võivad olla kas kohustuslikud (ilma argumendi väärtust sisestamata funktsioon ei tööta), või mitte.  Näiteks funktsioon `plot(x, y, ...)` argumendid on objekt nimega x, mis annab x teljele plotitud andmete koordinaadid, objekt nimega y, mis annab sama y teljele, ning lisaargumendid, mis võivad sõltuda x-i ja või y-i vormist. x on kohustuslik argument, aga y ei ole tingimata vajalik (kas y on vajalik või mitte, sõltub sisestatud x-i struktuurist).

* Kui argumendi väärtus sisestatakse teksti kujul, siis enamasti jutumärkides. Jutumärgid muudavad R-i jaoks teksti tähemärkide jadaks e stringiks, mille sees R numbreid ei tõlgenda arvudena. 

* Argumendid on järjestatud ja neil on nimed. Nimi trumpab järjekorra üle selles mõttes, et me võime argumentide nimed funktsiooni kirjutada suvalises järjekorras ilma, et funktsiooni töö sellest muutuks. Samas, kui me sisestame funktsiooni argumendid ilma nimedeta, siis on argumentide järjekord tähtis, sest need seostatakse vaikimisi nimedega vastavalt oma järjekorranumbrile. Oletame, et meil on vektorid `kaal <- c(2.3, 4.3, 3)` ja `pikkus <- c(7, 5, 9)`. Me võime need funktsiooni sisestada nii: `plot(x = kaal, y = pikkus)`, `plot(y = pikkus, x = kaal)` ja `plot(kaal, pikkus)` teevad kõik identse scatterploti (aga `plot(pikkus, kaal)` ei tee).  

* Funktsiooni esimese argumendi saab enamasti sisestada ka alternatiivsel viisil, %>% pipe operaatori abil. Niimoodi jooksevad `fun(arg1, arg2)` ja `arg1 %>% fun(arg2)` koodid enamasti identselt. Kumba koodi eelistada on seega "vaid" koodi loetavuse küsimus. `arg1 %>% fun(arg2)` on sama, mis `arg1 %>% fun(., arg2)`, kus punkt "." näitab vaikimisi, mitmenda argumendi kohale me oma arg1 sisse torutame. Seda teades on võimalik ka vorm `arg2 %>% fun(arg1,.)`, kus toru kaudu anname sisse 2. või ükskõik millise muu argumendi. Siin ei ole muud saladust kui, et peame punkti asukoha funktsioonis eksplitsiitselt ära näitama. 

**Ülesanne:** uuri välja, mida määravad järgneva funktsiooni argumendid. 

`plot(table(rpois(100, 5)), type = "h", col = "red", lwd = 10, main = "rpois(100, lambda = 5)")`

Pane tähele, et funktsiooni "plot" argumendid "table" ja "rpois" on ka ise funktsioonid, millel on kummagil oma argumendid. 

## Sama koodi saab kirjutada neljal erineval viisil

Idee on sooritada järjest operatsioone nii, et eelmise operatsiooni väljund (R-i objekt)  oleks sisendiks järgmisele operatsioonile (funktsioonile). See on lihtne  hargnemisteta analüüsiskeem.

Kui me muudame olemasolevat objekti, siis me kas jätame muudetud objektile vana objekti nime või me anname talle uue nime. 
Esimesel juhul läheb eelmine muutmata objekt töökeskkonnast kaduma, aga nimesid ei tule juurde ja säilib töövoo sujuvus. 
Teisel juhul jäävad analüüsi vaheobjektid meile alles ja nende juurde saab alati tagasi tulla. Aga samas tekib palju sarnaste nimedega objekte.

### Esimene võimalus - anname järjest tekkinud objektid samale nimele.

```r
a <- c(2, 3)
a <- sum(a)
a <- sqrt(a)
a <- round(a, 2)
a
#> [1] 2.24
```

### Teine võimalus - uued nimed.
Nii saab tekkinud objekte hiljem kasutada.

```r
a <- c(2, 3)
a1 <- sum(a)
a2 <- sqrt(a1)
a3 <- round(a2, 2)
a3
#> [1] 2.24
```

### Kolmas võimalus on lühem variant esimesest. 
Me nimelt ühendame etapid toru `%>%` kaudu. Toru operaator ei ole siiski baas R-is kohe kättesaadav, vaid tuleb laadida kas **magrittr** või **dplyr** paketist (viimatinimetatu laadib selle funktsiooni ka vaikimisi esimesena nimetatud raamatukogust).
Siin me võtame objekti "a" (nö. andmed), suuname selle funktsiooni `sum()`, võtame selle funktsiooni väljundi ja suuname selle omakorda funktsiooni `sqrt()`. 
Seejärel võtame selle funktsiooni outputi ja määrame selle nimele "result" (aga võime selle ka mõne teise nimega siduda). 
Kui mõni funktsioon võtab ainult ühe parameetri, mille me talle toru kaudu sisse sõõdame, siis pole selle funktsiooni taga isegi sulge vaja (R hea stiili juhised soovitavad siiski alati kasutada funktsiooni koos sulgudega). 

See on hea lühike ja inimloetav viis koodi kirjutada, mis on masina jaoks identne esimese koodiga.

```r
library(dplyr)
a <- c(2, 3)
result <- a %>% sum() %>% sqrt() %>% round(2)
result
#> [1] 2.24
```

### Neljas võimalus, klassikaline baas R lahendus:

```r
a <- c(2, 3)
result <- round(sqrt(sum(a)), 2)
result
#> [1] 2.24
```
Sellist koodi loetakse keskelt väljappoole ja kirjutatakse alates viimasest operatsioonist, mida soovitakse, et kood teeks. 
Masina jaoks pole vahet. 
Inimese jaoks on küll: 4. variant nõuab hästi pestud ajusid.

Koodi lühidus 4 --> 3 --> 1 --> 2 (pikem)
Lollikindlus  2 --> 1 --> 3 --> 4 (vähem lollikindel)
Loetavus 3 --> 2 --> 1 --> 4 (halvemini loetav)

See on teie otsustada, millist koodivormi te millal kasutate, aga te peaksite oskama lugeda neid kõiki.


## objekt {#obj}

R-i töökeskkonnas "workspace" asuvad **objektid**, millega me töötame. Igal objektil on nimi, mille abil saab selle objektiga opereerida (teda argumendina funktsioonidesse sisestada). 
Tüüpilised objektid on:

- Vektorid, maatriksid, listid ja andmeraamid.
- Statistiliste analüüside väljundid (mudeliobjektid, S3, S4 klass).
- Funktsioonid.

Funktsioon `ls()` annab objektide nimed teie workspace-s.

`rm(a)` eemaldab objekti nimega a töökeskkonnast.

Selleks, et salvestada töökeskkond faili, kasuta "Save" nuppu "Environment" akna servast või menüüst "Session" -> "Save Workspace As".

Projekti sulgemisel salvestab RStudio vaikimisi töökeskkonna. 
**Parema reprodutseeritavuse huvides pole siiski soovitav töökeskkonda peale töö lõppu projekti sulgemisel salvestada!**. 
Lülitame automaatse salvestamise välja:

- Selleks mine "Tools" > "Global Options" > kõige ülemine, "R General" menüüs vali "Save workspace to .RData on exit" > "Never" ever!
- Võta ära linnuke "Restore .RData to workspace at startup" eest.

Kui on mingid kaua aega võtvad kalkulatsioonid või allalaadimised, salvesta need eraldi .rds faili ja laadi koodis vastavalt vajadusele: `write_rds()`, `read_rds()`.



### Objekt ja nimi

Kui teil sünnib laps, annate talle nime.
R-s on vastupidi: nimele antakse objekt

```r
babe <- "beebi"
babe
#> [1] "beebi"
```

Siin on kõigepealt nimi (babe), siis assigneerimise sümbol `<-` ja lõpuks objekt, mis on nimele antud (string "beebi"). 

NB! Stringid on jutumärkides, nimed mitte.
Nimi üksi evalueeritakse kui käsk: "print object". Antud juhul trükitakse konsooli string "beebi"

Nüüd muudame objekti nime taga:

```r
babe <- c("saatan", "inglike")
babe
#> [1] "saatan"  "inglike"
```

Tulemuseks on sama nimi, mis tähistab nüüd midagi muud (vektorit, mis koosneb 2st stringist). Objekt "beebi" kaotas oma nime ja on nüüd workspacest kadunud. 
`class()` annab meile objekti klassi.

```r
class(babe)
#> [1] "character"
```
 Antud juhul character. 

> Ainult need objektid, mis on assigneeritud nimele, lähevad workspace ja on sellistena kasutatvad edasises analüüsis.


```r
apples <- 2
bananas <- 3
apples + bananas
#> [1] 5
```
Selle ekspressiooni tulemus trükitakse ainult R konsooli. Kuna teda ei määrata nimele, siis ei ilmu see ka workspace.



```r
a <- 2
b <- 3
a <- a + b
# objekti nimega 'a' struktuur
str(a)
#>  num 5
```
Nüüd on nimega a seostatud uus objekt, mis sisaldab numbrit 5 (olles ühe elemendiga vektor). Ja nimega a eelnevalt seostatud objekt, mis koosnes numbrist 2, on workspacest lahkunud. 

#### Nimede vorm

+ Nimed algavad ingliskeelse tähemärgiga, mitte numbriga ega $€%&/?~ˇöõüä
+ Nimed ei sisalda tühikuid
+ Tühiku asemel kasuta alakriipsu: näiteks eriti_pikk_nimi
+ SUURED ja väiksed tähed on nimes erinevad
+ Nimed peaksid kirjeldama objekti, mis on sellele nimele assigneeritud ja nad võivad olla pikad sest TAB klahv annab auto-complete.
+ alt + - on otsetee `<-` jaoks 

## Andmete tüübid

+ numeric / integer 
+ logical -- 2 väärtust TRUE/FALSE
+ character
+ factor (ordered and unordered) - 2+ diskreetset väärtust, mis võivad olla järjestatud suuremast väiksemani (aga ei asu üksteisest võrdsel kaugusel). Faktoreid käsitleme põhjalikumalt hiljem.

Faktoritel on tasemed (level) ja sisemiselt on iga faktori tase tähistatud täisarvulise numbriga.  

Andmete tüüpe saab üksteiseks konverteerida `as.numeric()`, `as.character()`, `as.factor()`.


```r
a <- 5:10 
#vektor, mis koosneb 6st täisarvust 5st 10-ni
class(a)
#> [1] "integer"

a_char <- c("5", "6", "7") 
#jutumärgid tähistavad tähemärki, mitte arvu.
class(a_char)
#> [1] "character"

a1 <- as.factor(a)
a1
#> [1] 5  6  7  8  9  10
#> Levels: 5 6 7 8 9 10
a2 <- as.numeric(a1) 
#see ei tööta, sest faktori tasemed 
#rekodeeritakse sisemiselt numbritena alates 1st. 
a2
#> [1] 1 2 3 4 5 6
a3 <- as.numeric(as.character(a1)) 
#see töötab, taastab numbrid 5st 10-ni
#kõigepealt konverteerime faktori tasemed tähemärkideks 
#(ignoreerides sisemisi rekodeeringuid).
#Seejärel konverteerime tähemärgid numbriteks.
a3
#> [1]  5  6  7  8  9 10
```

## Objektide klassid
### Vektor

Vektor on rida kindlas järjekorras arve, tähemärkide stringe või TRUE/FALSE loogilisi väärtusi. 
Iga vektor ja maatriks (mis on 2D vektor) sisaldab ainult ühte tüüpi andmeid. 
Vektor on elementaarüksus, millega me teeme tehteid. 
Andmetabelis ripuvad kõrvuti ühepikad vektorid (üks vektor = üks tulp) ja R-le meeldib arvutada vektori kaupa vasakult paremale (mis tabelis on ülevalt alla sest vektori algus on üleval tabeli peas). 
Pikema kui üheelemendise vektori loomiseks kasuta funktsiooni `c()` -- combine

Loome numbrilise vektori ja vaatame ta struktuuri:

```r
minu_vektor <- c(1, 3, 4)
str(minu_vektor)
#>  num [1:3] 1 3 4
```

Loome vektori puuduva väärtusega, vaatame vektori klassi:

```r
minu_vektor <- c(1, NA, 4)
minu_vektor
#> [1]  1 NA  4
class(minu_vektor)
#> [1] "numeric"
```
Klass jääb _numeric_-uks.

Kui vektoris on segamini numbrid ja stringid, siis muudetakse numbrid ka stringideks:

```r
minu_vektor <- c(1, "2", 2, 4, "joe")
minu_vektor
#> [1] "1"   "2"   "2"   "4"   "joe"
class(minu_vektor)
#> [1] "character"
```
Piisab ühest "tõrvatilgast meepotis", et teie vektor ei sisaldaks enam numbreid.

Eelnevast segavektorist on võimalik numbrid päästa kasutades käsku `as.numeric()`:

```r
as.numeric(minu_vektor)
#> Warning: NAs introduced by coercion
#> [1]  1  2  2  4 NA
```
Väärtus "joe" muudeti NA-ks, kuna seda ei olnud võimalik numbriks muuta.
Samuti peab olema tähelepanelik faktorite muutmisel numbriteks:

```r
minu_vektor <- factor(c(9, "12", 12, 1.4, "joe"))
minu_vektor
#> [1] 9   12  12  1.4 joe
#> Levels: 1.4 12 9 joe
class(minu_vektor)
#> [1] "factor"
## Kui muudame faktori otse numbriks, saame faktori taseme numbri
as.numeric(minu_vektor)
#> [1] 3 2 2 1 4
```

Faktorite muutmisel numbriteks tuleb need kõigepealt stringideks muuta:

```r
as.numeric(as.character(minu_vektor))
#> Warning: NAs introduced by coercion
#> [1]  9.0 12.0 12.0  1.4   NA
```


Järgneva trikiga saab stringidest kätte numbrid: 

```r
minu_vektor <- c(1, "A2", "$2", "joe")
## parse_number() is imported from tidyverse 'readr' 
minu_vektor <- parse_number(minu_vektor) %>% as.vector()
#> Warning: 1 parsing failure.
#> row col expected actual
#>   4  -- a number    joe
str(minu_vektor)
#>  num [1:4] 1 2 2 NA
```

R säilitab vektori algse järjekorra. 
Sageli on aga vaja tulemusi näiteks vaatamiseks ja presenteerimiseks sorteerida suuruse või tähestiku järjekorras:

```r
## sorts vector in ascending order
sort(x, decreasing = FALSE, ...)
```

Vektori unikaalsed väärtused saab kätte käsuga `unique()`:

```r
## returns a vector or data frame, but with duplicate elements/rows removed
unique(c(1,1,1,2,2,2,2,2,3,3,4,5,5))
#> [1] 1 2 3 4 5
```


Uus vektor automaatselt: `seq()` ja `rep()`

seq annab kasvava või kahaneva rea. rep kordab väärtusi.


```r
seq(2, 3, by = 0.5)
#> [1] 2.0 2.5 3.0
seq(2, 3, length.out = 5)
#> [1] 2.00 2.25 2.50 2.75 3.00
rep(1:2, times = 3)
#> [1] 1 2 1 2 1 2
rep(1:2, each = 3)
#> [1] 1 1 1 2 2 2
rep(c("a", "b"), each = 3, times = 2)
#>  [1] "a" "a" "a" "b" "b" "b" "a" "a" "a" "b" "b" "b"
```

#### Tehted arvuliste vektoritega

Vektoreid saab liita, lahutada, korrutada ja jagada.

```r
a <- c(1, 2, 3)
b <- 4
a + b
#> [1] 5 6 7
```
Kõik vektor a liikmed liideti arvuga 3 (kuna vektor b koosnes ühest liikmest, läks see kordusesse)


```r
a <- c(1, 2, 3)
b <- c(4, 5) 
a + b
#> Warning in a + b: longer object length is not a
#> multiple of shorter object length
#> [1] 5 7 7
```
Aga see töötab veateatega, sest vektorite pikkused ei ole üksteise kordajad
1 + 4; 2 + 5, 3 + 4


```r
a <- c(1, 2, 3, 4)
b <- c(5, 6) 
a + b
#> [1]  6  8  8 10
```
See töötab: 1 + 5; 2 + 6; 3 + 5; 4 + 6 


```r
a <- c(1, 2, 3, 4)
b <- c(5, 6, 7, 8) 
a + b
#> [1]  6  8 10 12
```
Samuti see (ühepikkused vektorid --- igat liiget kasutatakse üks kord)


```r
a <- c(TRUE, FALSE, TRUE)
sum(a)
#> [1] 2
mean(a)
#> [1] 0.667
```
Mis siin juhtus? R kodeerib sisemiselt TRUE kui 1 ja FALSE kui 0-i. summa 1 + 0 + 1 = 2. Mean seevastu võtab ühtede summa (TRUE elementide arvu) suhte vektori elementide arvust ja annab seega TRUE väärtuste suhtarvu. Seda loogiliste väärtuste omadust õpime varsti praktikas kasutama. 

### List

List on objektitüüp, kuhu saab koondada kõiki teisi objekte, kaasa arvatud listid. R-i jaoks on list lihtsalt vektor, mille elemendid ei pean olema sama andmetüüpi (nagu tavalistel nn lihtsatel vektoritel).  
Praktikas kasutatakse listi enamasti lihtsalt erinevate R-i objektide koos hoidmiseks ühes suuremas meta-objektis. List on nagu jõuluvana kingikott, kus kommid, sokipaarid ja muud kingid segamini kolisevad. Listidega töötamist vaatame lähemalt veidi hiljem.

Näiteks list, kus on 1 vektor nimega a, 1 tibble nimega b ja 1 list nimega c, mis omakorda sisaldab vektorit nimega d ja tibblet nimega e. Seega on meil tegu rekursiivse listiga. 

```r
# numeric vector a
a <- runif(5)
# data.frame
ab <- data.frame(a, b = rnorm(5))
# linear model
model <- lm(mpg ~ hp, data = mtcars)
# your grandma on bongos
grandma <- "your grandma on bongos"
# let's creat list
happy_list <- list(a, ab, model, grandma)
happy_list
#> [[1]]
#> [1] 0.4946 0.0472 0.8471 0.0643 0.8421
#> 
#> [[2]]
#>        a      b
#> 1 0.4946 0.1194
#> 2 0.0472 1.0976
#> 3 0.8471 0.0277
#> 4 0.0643 1.7949
#> 5 0.8421 0.5724
#> 
#> [[3]]
#> 
#> Call:
#> lm(formula = mpg ~ hp, data = mtcars)
#> 
#> Coefficients:
#> (Intercept)           hp  
#>     30.0989      -0.0682  
#> 
#> 
#> [[4]]
#> [1] "your grandma on bongos"
```

Võtame listist välja elemndi "ab":

```r
happy_list$ab
#> NULL
```


### data frame ja tibble

Andmeraam on eriline list, mis koosneb ühepikkustest ja sama tüüpi vektoritest (listi iga element on vektor). Iga vektor on df-i veerg ja igas veerus on ainult ühte tüüpi andmed. Need vektorid ripuvad andmeraamis kõrvuti nagu tuulehaugid suitsuahjus, kusjuures vektori algus vastab tuulehaugi peale, mis on konksu otsas (konks vastab andmeraamis veeru nimele). Iga vektori nimi muutub sellises tabelis veeru nimeks. 

R-s on 2 andmeraami tüüpi: data frame ja tibble, mis on väga sarnased. 
Tibble on uuem, veidi kaunima väljatrükiga ja pisut mugavam kasutada.

> Erinevalt data frame-st saab tibblesse lisada ka list tulpasid, mis võimaldab sisuliselt suvalisi R objekte tibblesse paigutada. Põhimõtteliselt piisab ainult ühest andmestruktuurist -- tibble, et R-is töötada. Kõik, mis juhtub tibbles, jääb tibblesse. 

"Tidyverse" töötab tibblega veidi paremini kui data frame-ga, aga see vahe ei ole suur.

Siin on meil 3 vektorit: shop, apples ja oranges, millest me paneme kokku tibble nimega fruits

```r
## loome kolm vektorit
shop <- c("maxima", "tesco", "lidl")
apples <- c(1, 4, 43)
oranges <- c(2, 32, NA)
vabakava <- list(letters, runif(10), lm(mpg ~ cyl, mtcars))
## paneme need vektorid kokku tibble-sse
fruits <- tibble(shop, apples, oranges, vabakava)
fruits
#> # A tibble: 3 x 4
#>   shop   apples oranges vabakava  
#>   <chr>   <dbl>   <dbl> <list>    
#> 1 maxima      1       2 <chr [26]>
#> 2 tesco       4      32 <dbl [10]>
#> 3 lidl       43      NA <lm>
```
Siin ta on, ilusti meie workspace-s. Pange tähele viimast tulpa "vabakava", mis sisaldab _character_ vectorit, numbrilist vektorit ja lineaarse mudeli objekti. 

Listi juba nii lihtsalt data.frame-i ei pane:

```r
dfs <- try(data.frame(shop, apples, oranges, vabakava))
#> Error in as.data.frame.default(x[[i]], optional = TRUE, stringsAsFactors = stringsAsFactors) : 
#>   cannot coerce class '"lm"' to a data.frame
dfs
#> [1] "Error in as.data.frame.default(x[[i]], optional = TRUE, stringsAsFactors = stringsAsFactors) : \n  cannot coerce class '\"lm\"' to a data.frame\n"
#> attr(,"class")
#> [1] "try-error"
#> attr(,"condition")
#> <simpleError in as.data.frame.default(x[[i]], optional = TRUE, stringsAsFactors = stringsAsFactors): cannot coerce class '"lm"' to a data.frame>
```

### Matrix

Maatriks on 2-dimensionaalne vektor, sisaldab ainult ühte tüüpi andmeid -- numbrid, stringid, faktorid.

Tip: me saame sageli andmeraami otse maatriksina kasutada kui me viskame sealt välja mitte-numbrilised tulbad. Aga saame ka andmeraame konverteerida maatriksiks, ja tagasi.

```r
fruits <- as.matrix(fruits)
class(fruits)
```

## Indekseerimine

Igale vektori, listi, andmeraami ja maatriksi elemendile vastab unikaalne postiindeks, mille abil saame just selle elemendi unikaalselt indentifitseerida, välja võtta ja töödelda.
Seega on indeksi mõte väga lühikese käsuga välja võtta R-i objektide üksikuid elemente. R-s algab indeksi numeratsioon 1-st (mitte 0-st, nagu näiteks Pythonis).

### Vektorid ja nende indeksid on ühedimensionaalsed


```r
my_vector <- 2:5 
my_vector
#> [1] 2 3 4 5
my_vector[1] #1. element ehk number 2
#> [1] 2
my_vector[c(1,3)] #1. ja 3. element 
#> [1] 2 4
my_vector[-1] #kõik elemendid, v.a. 1. element
#> [1] 3 4 5
my_vector[c(-1, -3)] #kõik elemendid, v.a. 1. ja 3. element 
#> [1] 3 5
my_vector[3:5] #elemendid 3, 4 ja 5 (element 5 on määramata, seega NA)
#> [1]  4  5 NA
my_vector[-(3:length(my_vector))] #1. ja 2. element
#> [1] 2 3
```

### Andmeraamid ja maatriksid on kahedimensionaalsed, nagu ka nende indeksid

**2D indeksi kuju on [rea_indeks, veeru_indeks]**.


```r
dat <- tibble(colA = c("a", "b", "c"), colB = c(1, 2, 3))
dat
# üks andmepunkt: 1. rida, 2. veerg
dat[1, 2]

# 1. rida, kõik veerud
dat[1, ]

# 2. veerg, kõik read
dat[, 2]

# kõik read peale 1.
dat[-1, ]

# viskab välja 2. veeru
dat[, -2]

# 2 andmepunkti: 2. rida, 1. ja 2. veerg
dat[2, 1:2]

# 2 andmepunkti: 2. rida, 3. ja 4. veerg
dat[2, c(1, 2)]

#viskab välja 1. ja 2. rea
dat[-c(1, 2), ]

#veerg nimega colB, output on erandina vektor!
dat$colB
```
Kui me indekseerimisega tibblest veeru ehk vektori välja võtame, on output class: tibble. Kui me teeme sama data frame-st, siis on output class: vector.

Nüüd veidi keerulisemad konstruktsioonid, mis võimaldavad tabeli ühe kindla veeru väärtusi välja tõmmata teise veeru väärtuste järgi filteerides. Püüdke sellest koodist aru saada, et te hiljem ära tunneksite, kui midagi sellist vastu tuleb. Õnneks ei ole teil endil vaja sellist koodi kirjutada, me õpetame teile varsti lihtsama filtri meetodi.

```r
dat <- tibble(colA = c("a", "b", "c"), colB = c(1, 2, 3))
dat$colB[dat$colA != "a" ] 
#> [1] 2 3
#jätab sisse kõik vektori colB väärtused, 
#kus samas tabeli reas olev colA väärtus ei 
#ole "a". output on vektor! 
dat$colA[dat$colB > 1] 
#> [1] "b" "c"
#jätab sisse kõik vektori colA väärtused, 
#kus samas tabeli reas olev colB väärtus >1. 
#output on vektor. 
```

### Listide indekseerimine

**Listi indekseerimisel kasutame kahte sorti nurksulge, "[ ]" ja "[[ ]]", mis töötavad erinevalt**.

Kui listi vaadata nagu objektide vanglat, siis kaksiksulgude `[[ ]]` abil on võimalik üksikuid objekte vanglast välja päästa nii, et taastub nende algne kuju ehk class.
Seevastu üksiksulud `[ ]` tekitavad uue listi, kus on säilinud osad algse listi elemendid, ehk uue vangla vähemate vangidega. 

> Kaksiksulud "[[ ]]" päästavad listist välja ühe elemendi ja taastavad selle algse class-i (data.frame, vektor, list jms). Üksiksulud "[ ]" võtavad algsest listist välja teie poolt valitud elemendid aga jätavad uue objekti ikka listi kujule.


```r
my_list <- list(a = tibble(colA = c("A", "B"), colB = c(1, 2)), b = c(1, NA, "s"))
## this list has two elements, a data frame called "a" and a character vector called "b".
str(my_list)
#> List of 2
#>  $ a:Classes 'tbl_df', 'tbl' and 'data.frame':	2 obs. of  2 variables:
#>   ..$ colA: chr [1:2] "A" "B"
#>   ..$ colB: num [1:2] 1 2
#>  $ b: chr [1:3] "1" NA "s"
```

Tõmbame listist välja tibble:

```r
my_tibble <- my_list[[1]]
my_tibble
#> # A tibble: 2 x 2
#>   colA   colB
#>   <chr> <dbl>
#> 1 A         1
#> 2 B         2
```
See ei ole enam list.

Nüüd võtame üksiksuluga listist välja 1. elemendi, mis on tibble, aga output ei ole mitte tibble, vaid ikka list. 
Seekord ühe elemendiga, mis on tibble.

```r
aa <- my_list[1]
str(aa)
#> List of 1
#>  $ a:Classes 'tbl_df', 'tbl' and 'data.frame':	2 obs. of  2 variables:
#>   ..$ colA: chr [1:2] "A" "B"
#>   ..$ colB: num [1:2] 1 2
```



```r
aa1 <- my_list$a[2,] #class is df
aa1
#> # A tibble: 1 x 2
#>   colA   colB
#>   <chr> <dbl>
#> 1 B         2
```


```r
aa3 <- my_list[[1]][1,]
aa3
#> # A tibble: 1 x 2
#>   colA   colB
#>   <chr> <dbl>
#> 1 A         1
```

Kõigepealt läksime kaksiksulgudega listi taseme võrra sisse ja võtsime välja objekti my_list 1. elemendi, tema algses tibble formaadis, (indeksi 1. dimensioon). Seejärel korjame sealt välja 1. rea, tibble formaati muutmata ja seega üksiksulgudes (indeksi 2. ja 3. dimensioon).

Pane tähele, et `[[ ]]` lubab ainult ühe elemendi korraga listist välja päästa.


# Lihtne töö Andmeraamidega

## Võrdleme andmeraame kahel viisil ja summeerime andmeraami.

1. all_equal

df1 on märklaud ja df2 on see, mida võrreldakse.
convert = TRUE ühtlustab kahe tabeli vahel sarnased andmetüübid (n. factor ja character).

```r
all_equal(df1, df2, convert = FALSE)
```

2. diffdf raamatukogu annab detailsema väljundi


```r
diffdf::diffdf(df1, df2)
```

Andmetabeli Summary saab mitmel viisil, skimr::skim() funktsioon on üks paremaid 

```r
skimr::skim(iris)
#> Skim summary statistics
#>  n obs: 150 
#>  n variables: 5 
#> 
#> -- Variable type:factor -------------------------------
#>  variable missing complete   n n_unique
#>   Species       0      150 150        3
#>                        top_counts ordered
#>  set: 50, ver: 50, vir: 50, NA: 0   FALSE
#> 
#> -- Variable type:numeric ------------------------------
#>      variable missing complete   n mean   sd  p0 p25
#>  Petal.Length       0      150 150 3.76 1.77 1   1.6
#>   Petal.Width       0      150 150 1.2  0.76 0.1 0.3
#>  Sepal.Length       0      150 150 5.84 0.83 4.3 5.1
#>   Sepal.Width       0      150 150 3.06 0.44 2   2.8
#>   p50 p75 p100
#>  4.35 5.1  6.9
#>  1.3  1.8  2.5
#>  5.8  6.4  7.9
#>  3    3.3  4.4
```

BaasR kasutab `summary(df)` vormi.


## Põhitehted andmeraamidega


```r
count(iris, Species) #loeb üles, mitu korda igat näitu veerus Species esineb
#> # A tibble: 3 x 2
#>   Species        n
#>   <fct>      <int>
#> 1 setosa        50
#> 2 versicolor    50
#> 3 virginica     50
summary(iris)
#>   Sepal.Length   Sepal.Width    Petal.Length 
#>  Min.   :4.30   Min.   :2.00   Min.   :1.00  
#>  1st Qu.:5.10   1st Qu.:2.80   1st Qu.:1.60  
#>  Median :5.80   Median :3.00   Median :4.35  
#>  Mean   :5.84   Mean   :3.06   Mean   :3.76  
#>  3rd Qu.:6.40   3rd Qu.:3.30   3rd Qu.:5.10  
#>  Max.   :7.90   Max.   :4.40   Max.   :6.90  
#>   Petal.Width        Species  
#>  Min.   :0.1   setosa    :50  
#>  1st Qu.:0.3   versicolor:50  
#>  Median :1.3   virginica :50  
#>  Mean   :1.2                  
#>  3rd Qu.:1.8                  
#>  Max.   :2.5
names(iris) #annab veerunimed
#> [1] "Sepal.Length" "Sepal.Width"  "Petal.Length"
#> [4] "Petal.Width"  "Species"
nrow(iris) #mitu rida?
#> [1] 150
ncol(iris) #mitu veergu?
#> [1] 5
arrange(iris, desc(Sepal.Length)) %>% head(3) 
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1          7.9         3.8          6.4         2.0
#> 2          7.7         3.8          6.7         2.2
#> 3          7.7         2.6          6.9         2.3
#>     Species
#> 1 virginica
#> 2 virginica
#> 3 virginica
#sorteerib tabeli veeru "Sepal.Length" väärtuste järgi 
#langevalt (default on tõusev sorteerimine). 
#Võib argumendina anda mitu veergu.
top_n(iris, 2, Sepal.Length) 
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1          7.7         3.8          6.7         2.2
#> 2          7.7         2.6          6.9         2.3
#> 3          7.7         2.8          6.7         2.0
#> 4          7.9         3.8          6.4         2.0
#> 5          7.7         3.0          6.1         2.3
#>     Species
#> 1 virginica
#> 2 virginica
#> 3 virginica
#> 4 virginica
#> 5 virginica
#saab 2 või rohkem rida, milles on kõige suuremad S.L. väärtused
top_n(iris, -2, Sepal.Length) #saab 2 rida, milles on kõige väiksemad väärtused 
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1          4.4         2.9          1.4         0.2
#> 2          4.3         3.0          1.1         0.1
#> 3          4.4         3.0          1.3         0.2
#> 4          4.4         3.2          1.3         0.2
#>   Species
#> 1  setosa
#> 2  setosa
#> 3  setosa
#> 4  setosa
```

Tibblega saab teha maatriksarvutusi, kui kasutada ainult arvudega ridu. 
`apply()` arvutab maatriksi rea (1) või veeru (2) kaupa, vastavalt funktsioonile, mille sa ette annad.

```r
colSums(fruits[ , 2:3])
#>  apples oranges 
#>      48      NA
rowSums(fruits[ , 2:3])
#> [1]  3 36 NA
rowMeans(fruits[ , 2:3])
#> [1]  1.5 18.0   NA
colMeans(fruits[ , 2:3])
#>  apples oranges 
#>      16      NA
fruits_subset <- fruits[ , 2:3]

# 1 tähendab, et arvuta sd rea kaupa
apply(fruits_subset, 1, sd)
#> [1]  0.707 19.799     NA
# 2 tähendab, et arvuta sd veeru kaupa
apply(fruits_subset, 2, sd) 
#>  apples oranges 
#>    23.4      NA
```

Lisame käsitsi tabelile rea:

```r
fruits <- add_row(fruits, 
                  shop = "konsum", 
                  apples = 132, 
                  oranges = -5, 
                  .before = 3)
fruits
#> # A tibble: 4 x 4
#>   shop   apples oranges vabakava  
#>   <chr>   <dbl>   <dbl> <list>    
#> 1 maxima      1       2 <chr [26]>
#> 2 tesco       4      32 <dbl [10]>
#> 3 konsum    132      -5 <NULL>    
#> 4 lidl       43      NA <lm>
```

Proovi ise:

```r
add_column()
```

Eelnevaid verbe ei kasuta me just sageli, sest tavaliselt loeme andmed sisse väljaspoolt R-i. Aga väga kasulikud on järgmised käsud:

## Rekodeerime andmeraami väärtusi



```r
fruits$apples[fruits$apples==43] <- 333
fruits
#> # A tibble: 4 x 4
#>   shop   apples oranges vabakava  
#>   <chr>   <dbl>   <dbl> <list>    
#> 1 maxima      1       2 <chr [26]>
#> 2 tesco       4      32 <dbl [10]>
#> 3 konsum    132      -5 <NULL>    
#> 4 lidl      333      NA <lm>
fruits$shop[fruits$shop=="tesco"] <- "TESCO"
fruits
#> # A tibble: 4 x 4
#>   shop   apples oranges vabakava  
#>   <chr>   <dbl>   <dbl> <list>    
#> 1 maxima      1       2 <chr [26]>
#> 2 TESCO       4      32 <dbl [10]>
#> 3 konsum    132      -5 <NULL>    
#> 4 lidl      333      NA <lm>
fruits$apples[fruits$apples>100] <- NA
fruits
#> # A tibble: 4 x 4
#>   shop   apples oranges vabakava  
#>   <chr>   <dbl>   <dbl> <list>    
#> 1 maxima      1       2 <chr [26]>
#> 2 TESCO       4      32 <dbl [10]>
#> 3 konsum     NA      -5 <NULL>    
#> 4 lidl       NA      NA <lm>
```

Viskame välja duplikaatread, aga ainult need kus veerg nimega col1 sisaldab identseid väärtusi (mitmest identse väärtusega reast jääb alles ainult esimene)

```r
distinct(dat, col1, .keep_all = TRUE)
# kõikide col vastu
distinct(dat) 
```

Rekodeerime `Inf` ja `NA` väärtused nulliks (mis küll tavaliselt on halb mõte):

```r
# inf to 0
x[is.infinite(x)] <- 0
# NA to 0
x[is.na(x)] <- 0
```


## Ühendame kaks andmeraami rea kaupa 

Tabeli veergude arv ei muutu, ridade arv kasvab.

```r
dfs <- tibble(colA = c("a", "b", "c"), colB = c(1, 2, 3))
dfs1 <- tibble(colA = "d", colB =  4)
#id teeb veel ühe veeru, mis näitab, kummast algtabelist iga uue tabeli rida pärit on 
bind_rows(dfs, dfs1, .id = "id")
#> # A tibble: 4 x 3
#>   id    colA   colB
#>   <chr> <chr> <dbl>
#> 1 1     a         1
#> 2 1     b         2
#> 3 1     c         3
#> 4 2     d         4
```

Vaata Environmentist need tabelid üle ja mõtle järgi, mis juhtus.

Kui `bind_rows()` miskipärast ei tööta, proovi `do.call(rbind, dfs)`, mis on väga sarnane.

NB! Alati kontrollige, et ühendatud tabel oleks selline, nagu te tahtsite!

Näiteks, võib-olla te tahtsite järgnevat tabelit saada, aga võib-olla ka mitte:

```r
df2 <- tibble(ColC = "d", ColD = 4)
## works by guessing your true intention
bind_rows(dfs1, df2)
#> # A tibble: 2 x 4
#>   colA   colB ColC   ColD
#>   <chr> <dbl> <chr> <dbl>
#> 1 d         4 <NA>     NA
#> 2 <NA>     NA d         4
```

## ühendame kaks andmeraami veeru kaupa

Meil on 2 verbi: bind_cols ja cbind, millest esimene on konservatiivsem. Proovige eelkõige bind_col-ga läbi saada, aga kui muidu ei saa, siis cbind ühendab vahest asju, mida bind_cols keeldub puutumast. NB! Alati kontrollige, et ühendatud tabel oleks selline, nagu te tahtsite!


```r
dfx <- tibble(colC = c(4, 5, 6))
bind_cols(dfs, dfx)
#> # A tibble: 3 x 3
#>   colA   colB  colC
#>   <chr> <dbl> <dbl>
#> 1 a         1     4
#> 2 b         2     5
#> 3 c         3     6
```

## andmeraamide ühendamine join()-ga

Kõigepealt 2 tabelit: df1 ja df2.


```r
df1 <- tribble(
  ~ Member,         ~ yr_of_birth,
  "John Lennon",    1940,
  "Paul McCartney", 1942
)

df1
#> # A tibble: 2 x 2
#>   Member         yr_of_birth
#>   <chr>                <dbl>
#> 1 John Lennon           1940
#> 2 Paul McCartney        1942
```


```r
df2 <- tribble(
  ~ Member,            ~ instrument,    ~ yr_of_birth,
  "John Lennon",      "guitar",         1940,
  "Ringo Starr",      "drums",          1940,
  "George Harrisson", "guitar",         1942
)
df2
#> # A tibble: 3 x 3
#>   Member           instrument yr_of_birth
#>   <chr>            <chr>            <dbl>
#> 1 John Lennon      guitar            1940
#> 2 Ringo Starr      drums             1940
#> 3 George Harrisson guitar            1942
```

Ühendan 2 tabelit nii, et mõlema tabeli kõik read ilmuvad uude tabelisse.

```r
full_join(df1, df2)
#> # A tibble: 4 x 3
#>   Member           yr_of_birth instrument
#>   <chr>                  <dbl> <chr>     
#> 1 John Lennon             1940 guitar    
#> 2 Paul McCartney          1942 <NA>      
#> 3 Ringo Starr             1940 drums     
#> 4 George Harrisson        1942 guitar
```

Ühendan esimese tabeliga df2 nii, et ainult df1 read säilivad, aga df2-lt võetakse sisse veerud, mis df1-s puuduvad. See on hea join, kui on vaja algtabelile lisada infot teistest tabelitest.

```r
left_join(df1, df2)
#> # A tibble: 2 x 3
#>   Member         yr_of_birth instrument
#>   <chr>                <dbl> <chr>     
#> 1 John Lennon           1940 guitar    
#> 2 Paul McCartney        1942 <NA>
```

Jätan alles ainult need df1 read, millele vastab mõni df2 rida.

```r
semi_join(df1, df2)
#> # A tibble: 1 x 2
#>   Member      yr_of_birth
#>   <chr>             <dbl>
#> 1 John Lennon        1940
```

Jätan alles ainult need df1 read, millele ei vasta ükski df2 rida.

```r
anti_join(df1, df2)
#> # A tibble: 1 x 2
#>   Member         yr_of_birth
#>   <chr>                <dbl>
#> 1 Paul McCartney        1942
```


## Nii saab raamist kätte vektori, millega tehteid teha. 

Tibble jääb muidugi endisel kujul alles.

```r
ubinad <- fruits$apples
ubinad <- ubinad + 2
ubinad
#> [1]  3  6 NA NA
## see on jälle vektor
str(ubinad)
#>  num [1:4] 3 6 NA NA
```


## Andmeraamide salvestamine (eksport-import)

Andmeraami saame salvestada näiteks csv-na (comma separated file) oma kõvakettale, kasutame "tidyverse" analooge paketist "readr", mille nimed on baas R funktsioonidest eristatavad alakriipsu "_" kasutamisega. "readr" laaditakse automaatselt koos "tidyverse" laadimisega. 

```r
## loome uuesti fruits data tibble
shop <- c("maxima", "tesco", "lidl")
apples <- c(1, 4, 43)
oranges <- c(2, 32, NA)
fruits <- tibble(shop, apples, oranges, vabakava)
## kirjutame fruits tabeli csv faili fruits.csv kataloogi data 
write_csv(fruits, "data/fruits.csv")
```

Kuhu see fail läks? See läks meie projekti juurkataloogi kausta "data/", juurkataloogi asukoha oma arvuti kõvakettal leiame käsuga:

```r
getwd()
#> [1] "/home/travis/build/rstats-tartu/lectures"
```

Andmete sisselugemine töökataloogist:

```r
fruits <-  read_csv("data/fruits.csv")
```

Andmeraamide sisselugemiseks on kaks paralleelset süsteemi: baas-R-i read.table() ja selle mugavusfunktsioonid (read.csv(), read.csv2() jne) ning readr paketti, mis laaditakse koos tidyversiga, funktsioon read_delim() ja selle mugavusfunktsioonid (read_csv jne). Tavaliselt soovitame eelistada alakriipsuga variante (http://r4ds.had.co.nz/data-import.html). 

read_delim()-l ja selle poegade argument `col_types = cols(col_name_1 = col_double(), col_name_2 = col_date(format = ""))` võimaldab spetsifitseerida kindlatele veergudele, mis tüübiga need sisse loetakse. Töötab ka `cols_only(a = col_integer())`, samuti standardsed lühendid andmetüüpidele: `cols(a = "i", b = "d")`. Vaikimisi otsustab programm andmetüübi iga veeru esimese 1000 elemendi põhjal. Vahest tasub kõik veerud sisse lugeda character-idena, et oleks parem probleeme tuvastada: `df1 <- read_csv("my_data_frame_name.csv"), col_types = cols(.default = col_character()))`. .default	- kõik nimega veerud, mille kohta ei ole eksplitsiitselt teisiti õeldud, lähevad sisse lugemisel selle alla. .

Seda, milline sümbol kodeerib sisseloetavas failis koma ja milline on "grouping mark", mis eraldab tuhandeid, saab sisestada `locale = locale(decimal_mark = ",", grouping_mark = ".")` abil. Või näit: `locale("et", decimal_mark = ";")`. Vt ka https://cran.r-project.org/web/packages/readr/vignettes/locales.html.

https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes annab nimekirja riikide lokaalitähistest.

Argument `skip = n` jätab esimesed n rida sisse lugemata. Argument `comment = "#"` jätab sisse lugemata read, mis algavad #-ga.

Argument `col_names = FALSE` ei loe esimest rida sisse veerunimedena (see on vaikekäitumine) ja selle asemel nimetatakse veerud X1 ... Xn. `col_names = c("x", "y", "z"))` loeb tabeli sisse uute veerunimedega x, y ja z.

`na = "."` argument ütleb, et tabeli kirjed, mis on punktid, tuleb sisse lugeda NA-dena.

Kui teil on kataloogitäis faile (näit .csv lõpuga), mida soovite kõiki korraga sisse lugeda, siis tehke nii:

```r
library(fs)
#järgnev loeb sisse iga faili eraldi kataloogist nimega data_dir
fs::dir_ls(data_dir, regexp = "\\.csv$") %>% map(read_csv)

#Kui meil on mitu faili samade tulbanimedega ja tahame
#need sisse lugeda ühte faili üksteise järel, siis
dir_ls(data_dir, regexp = "\\.csv$") %>% map_dfr(read_csv, .id = "source")
#.id on optsionaalne argument, mis lisab uude faili lisaveeru, 
#kus on unikaalsed viited igale algtabelile, et oleks näha, millisest
#tabelist iga uue tabeli rida pärit on.
```

MS exceli failist saab tabeleid importida "readxl" raamatukogu abil.

```r
library(readxl)
## kõigepealt vaatame kui palju sheete failis on
sheets <- excel_sheets("data/excelfile.xlsx")
## siis impordime näiteks esimese sheeti
dfs <- read_excel("data/excelfile.xlsx", sheet = sheets[1])
```

Excelist csv-na eksporditud failid tuleks sisse lugeda käsuga `read_csv2` või `read.csv2` (need on erinevad funktsioonid; read.csv2 loeb selle sisse data frame-na ja read_csv2 tibble-na).

R-i saab sisse lugeda palju erinevaid andmeformaate. 
Näiteks, installi RStudio addin: "Gotta read em all R", vaata eespool.
See läheb ülesse tab-i Addins. 
Sealt saab selle avada ja selle abil tabeleid oma workspace üles laadida. 

Alternatiiv: mine alla paremake Files tab-le, navigeeri sinna kuhu vaja ja kliki faili nimele, mida tahad R-i importida.

Mõlemal juhul ilmub alla konsooli (all vasakul) koodijupp, mille jooksutamine peaks asja ära tegema. Te võite tahta selle koodi kopeerida üles vasakusse aknasse kus teie ülejäänud kood tulevastele põlvedele säilub.

> Tüüpiliselt töötate R-s oma algse andmestikuga. Reprodutseeruvaks projektiks on vaja 2 asja: algandmeid ja koodi, millega neid manipuleerida. R ei muuda algandmeid, mille te näiteks csv-na sisse loete. 

Andmetabelite salvestamine töö vaheproduktidena ei ole sageli vajalik, sest te jooksutate iga kord, kui te oma projekti juurde naasete, kogu analüüsi uuesti kuni kohani, kuhu te pooleli jäite. See tagab, et teie kood töötab tervikuna. Erandiks on tabelid, mille arvutamine võtab palju aega.

Tibble konverteerimine data frame-ks ja tagasi tibbleks:

```r
class(fruits) #näitab ojekti klassi
#> [1] "tbl_df"     "tbl"        "data.frame"
fruits <- as.data.frame(fruits)
class(fruits)
#> [1] "data.frame"
fruits <- as_tibble(fruits)
class(fruits)
#> [1] "tbl_df"     "tbl"        "data.frame"
```

## NA-d

Loe üles NA-d, 0-d, inf-id ja unikaalsed väärtused.

```r
library(funModeling)
diabetes <- read_delim("data/diabetes.csv", 
    ";", escape_double = FALSE, trim_ws = TRUE)

diabetes %>% status() %>% 
  mutate_if(is.numeric, round, 2) %>% 
  kableExtra::kable()
```


\begin{tabular}{l|r|r|r|r|r|r|l|r}
\hline
variable & q\_zeros & p\_zeros & q\_na & p\_na & q\_inf & p\_inf & type & unique\\
\hline
id & 0 & 0 & 0 & 0.00 & 0 & 0 & numeric & 403\\
\hline
chol & 0 & 0 & 1 & 0.00 & 0 & 0 & numeric & 154\\
\hline
stab.glu & 0 & 0 & 0 & 0.00 & 0 & 0 & numeric & 116\\
\hline
hdl & 0 & 0 & 1 & 0.00 & 0 & 0 & numeric & 77\\
\hline
ratio & 0 & 0 & 1 & 0.00 & 0 & 0 & numeric & 69\\
\hline
glyhb & 0 & 0 & 13 & 0.03 & 0 & 0 & numeric & 239\\
\hline
location & 0 & 0 & 0 & 0.00 & 0 & 0 & character & 2\\
\hline
age & 0 & 0 & 0 & 0.00 & 0 & 0 & numeric & 68\\
\hline
gender & 0 & 0 & 0 & 0.00 & 0 & 0 & character & 2\\
\hline
height & 0 & 0 & 5 & 0.01 & 0 & 0 & numeric & 22\\
\hline
weight & 0 & 0 & 1 & 0.00 & 0 & 0 & numeric & 140\\
\hline
frame & 0 & 0 & 12 & 0.03 & 0 & 0 & character & 3\\
\hline
bp.1s & 0 & 0 & 5 & 0.01 & 0 & 0 & numeric & 71\\
\hline
bp.1d & 0 & 0 & 5 & 0.01 & 0 & 0 & numeric & 57\\
\hline
bp.2s & 0 & 0 & 262 & 0.65 & 0 & 0 & numeric & 48\\
\hline
bp.2d & 0 & 0 & 262 & 0.65 & 0 & 0 & numeric & 36\\
\hline
waist & 0 & 0 & 2 & 0.00 & 0 & 0 & numeric & 30\\
\hline
hip & 0 & 0 & 2 & 0.00 & 0 & 0 & numeric & 32\\
\hline
time.ppn & 0 & 0 & 3 & 0.01 & 0 & 0 & numeric & 60\\
\hline
\end{tabular}



```r
diabetes <- read.table(file = "data/diabetes.csv", sep = ";", dec = ",", header = TRUE)
str(diabetes)
#> 'data.frame':	403 obs. of  19 variables:
#>  $ id      : int  1000 1001 1002 1003 1005 1008 1011 1015 1016 1022 ...
#>  $ chol    : int  203 165 228 78 249 248 195 227 177 263 ...
#>  $ stab.glu: int  82 97 92 93 90 94 92 75 87 89 ...
#>  $ hdl     : int  56 24 37 12 28 69 41 44 49 40 ...
#>  $ ratio   : num  3.6 6.9 6.2 6.5 8.9 ...
#>  $ glyhb   : num  4.31 4.44 4.64 4.63 7.72 ...
#>  $ location: Factor w/ 2 levels "Buckingham","Louisa": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ age     : int  46 29 58 67 64 34 30 37 45 55 ...
#>  $ gender  : Factor w/ 2 levels "female","male": 1 1 1 2 2 2 2 2 2 1 ...
#>  $ height  : int  62 64 61 67 68 71 69 59 69 63 ...
#>  $ weight  : int  121 218 256 119 183 190 191 170 166 202 ...
#>  $ frame   : Factor w/ 4 levels "","large","medium",..: 3 2 2 2 3 2 3 3 2 4 ...
#>  $ bp.1s   : int  118 112 190 110 138 132 161 NA 160 108 ...
#>  $ bp.1d   : int  59 68 92 50 80 86 112 NA 80 72 ...
#>  $ bp.2s   : int  NA NA 185 NA NA NA 161 NA 128 NA ...
#>  $ bp.2d   : int  NA NA 92 NA NA NA 112 NA 86 NA ...
#>  $ waist   : int  29 46 49 33 44 36 46 34 34 45 ...
#>  $ hip     : int  38 48 57 38 41 42 49 39 40 50 ...
#>  $ time.ppn: int  720 360 180 480 300 195 720 1020 300 240 ...
VIM::aggr(diabetes, prop = FALSE, numbers = TRUE)
```



\begin{center}\includegraphics{03-objektid_files/figure-latex/unnamed-chunk-69-1} \end{center}
Siit on näha, et kui me viskame välja 2 tulpa ja seejärel kõik read, mis sisaldavad NA-sid, kaotame me umbes 20 rida 380-st, mis ei ole suur kaotus.

Kui palju ridu, milles on 0 NA-d? Mitu % kõikidest ridadest?

```r
nrows <- nrow(diabetes)
  ncomplete <- sum(complete.cases(diabetes))
  ncomplete #136
#> [1] 136
  ncomplete/nrows #34%
#> [1] 0.337
```

  
### Mitu NA-d on igas tulbas?


```r
diabetes %>% map_df(~sum(is.na(.))) %>% t()
#>          [,1]
#> id          0
#> chol        1
#> stab.glu    0
#> hdl         1
#> ratio       1
#> glyhb      13
#> location    0
#> age         0
#> gender      0
#> height      5
#> weight      1
#> frame       0
#> bp.1s       5
#> bp.1d       5
#> bp.2s     262
#> bp.2d     262
#> waist       2
#> hip         2
#> time.ppn    3
```

väljund on uus tabel NA-de arvuga igale algse tabeli veerule

Eelnev ekspressioon töötab nii:
map_df() loeb kokku (summeerib) diabetes tabeli igale veerule, mitu elementi selles veerus andis ekspressioonile is.na() vastuseks TRUE. is.na() on funktsioon, mis annab väljundiks TRUE v FALSE, sõltuvalt vektori elemendi NA-staatusest. 


```r
is.na(c(NA, "3", "sd", "NA"))
#> [1]  TRUE FALSE FALSE FALSE
```

Pane tähele, et string "NA" ei ole sama asi, mis loogiline konstant NA.

Ploti NAd punasega igale tabeli reale ja tulbale mida tumedam halli toon seda suurem number selle tulba kontekstis:

```r
VIM::matrixplot(diabetes) 
```



\begin{center}\includegraphics{03-objektid_files/figure-latex/unnamed-chunk-73-1} \end{center}


### Kuidas rekodeerida NA-d näiteks 0-ks:

```r
dfs[is.na(dfs)] <- 0
dfs[is.na(dfs)] <- "other"
dfs[dfs == 0] <- NA # teeb vastupidi 0-d NA-deks
```

Pane tähele, et NA tähistamine ei käi character vectorina vaid dedikeeritud `is.na()` funktsiooniga.

coalesce teeb seda peenemalt.
kõigepealt kõik 

```r
x <- c(1:5, NA, NA, NA)
coalesce(x, 0L)
#> [1] 1 2 3 4 5 0 0 0
```

Nii saab 2 vektori põhjal kolmanda nii, et NA-d asendatakse vastava väärtusega:

```r
y <- c(1, 2, NA, NA, 5)
z <- c(NA, NA, 3, 4, 5)
coalesce(y, z)
#> [1] 1 2 3 4 5
```


`filter_all(weather, any_vars(is.na(.)))` näitab ridu, mis sisaldavad NA-sid

`filter_at(weather, vars(starts_with("wind")), all_vars(is.na(.)))` read, kus veerg, mis sisaldab wind, on NA.

### Rekodeerime NA-ks


```r
na_if(x, y)
#x - vektor ehk tabeli veerg, mida modifitseerime
#y - väärtus, mida soovime NA-ga asendada

na_if(dfs, "") #teeb dfs tabelis tühjad lahtrid NA-deks
na_if(dfs, "other") #teeb lahtrid, kus on "other" NA-deks
na_if(dfs, 0) #teeb 0-d NA-deks. 
```


### drop_na() viskab tabelist välja NA-dega read

`drop_na(data, c(column1, column2))` - argument variable võimaldab visata välja read, mis on NA-d ainult kindlates veergudes (column1 ja column2 meie näites - aga ära unusta column1 asemele kirjutada oma veeru nime). Ära unusta ka kasutamast vektori vormi c(), et veerge määrata. column1:column4 vorm töötab samuti ja võtab NAd veergudest 1-4 (kui veeru nr 1 nimi on column1 jne).

### viska tabelist välja veerud, milles on liiga palju NA-sid

Meil on lai tabel sadade numbriliste veegudega. Neist paljud on NA-rikkad (andmevaesed) ja tuleks tabelist eemaldada. Aga kuidas seda teha?

Selleks (1) koostame vektori (vekt), milles on tabeli df-i iga numbrilise veeru NA-de suhtarv, (2) viskame sellest vektorist välja nende veergude nimed, milles on liiga palju NA-sid ja (3) subsetime df-i saadud vektori (vekt1) vastu. 

NB! vekt ja vekt1 on nn named vektorid, milles vektori iga element (NAde suhtarv mingis tabeli veerus) on seotud selle elemendi nimega, mis on identne selle veeru nimega tabelis df.


```r
vekt <- sapply(df, function(x) mean(is.na(x))) 
#NA-de protsent igas veerus
vekt
vekt1 <- vekt[vekt < 0.8] 
#subsettisin vektori elemendid, mis on < 0.8 (NA-sid alla 80%). 216 tk.
#vekt1 is a named vector
vekt1n <- names(vekt1) #vektor named vektori vekt1 nimedest
df_with_fewer_cols <- subset(df, select = vekt1n)
#subsetime (jätame alles) ainult need df-i veerud, 
#mille nimele vastab mõni vektori nad1n element
```


# map() - kordame sama operatsiooni igale listi liikmele

Järgnevad meetodid töötavad nii listidel, data frame-del kui vektoritel. Seda sellepärast, et formaalselt on list vektori tüüp (rekursiivne vektor), kuhu on võimalik elementidena panna mida iganes, k.a. teisi vektoreid. Enamus R-i funktsioone, mis töötavad lihtsate mitte-rekursiivsete vektoritega (ja df-dega), ei tööta listide peal. 

purrr::map() perekonna funktsioonid töötavad nii lihtsate vektorite kui listide peal. Need funktsioonid rakendavad kasutaja poolt ette antud funktsiooni järjest igale vektori elemendile. map() vajab 2 argumenti: vektor ja funktsioon, mida selle vektori elementidele rakendada. map() võtab sisse listi (vektori, data frame) ja väljastab listi (vektori, data frame). Seega saab seda hästi pipe-s rakendada.

Kui tahad, map() anda funktsiooni lisaargumentidega, siis need eraldatakse komadega `map(list1, round, digits = 2)`.

Kui sa ei taha väljundina listi, vaid lihtsat numbrilist vektorit, siis kasuta `map_dbl()`. 


```r
1:10 %>%
  map(rnorm, n = 10) %>%
  map_dbl(mean)
#>  [1]  1.27  2.08  3.43  3.97  5.22  5.69  7.06  8.12
#>  [9]  9.00 10.16
```

map()-l on kokku 8 versiooni erinevate väljunditega.

* map() - list

* map_dbl() - floating point number vektor

* map_chr() - character vektor

* map_dfc() - data frame column binded

* map_dfr() - data frame row binded (lisab iga elemendi df-i reana)

* map_int() - integer vektor

* map_lgl() - logical vektor

* walk() - nähtamatu väljund (kasutatakse funktsioonide puhul, mis ei anna *command line*-le väljundit, nagu plot() või failide salvestamine).

sisestame map-i funktsiooni asemel ekspressiooni `max(df1$col1) - min(df1$col1)`:

ekspressiooni juhatab sisse ~ (tilde) ja seal asendatakse see, millega opereeritakse, .x -ga: `~ max(.x) - min(.x)`. 

Kasutades funktsiooni `pluck()` nopime järgnevas koodis igast "params" listi alam-listist mu ja sd ning kasutame neid, et genereerida 3 portsu juhuslikke arve, millest igas on 5 juhuslikku arvu, mis on genereeritud vastavalt selles alam-listis spetsifitseeritud mu-le ja sigmale.

```r
params <- list(
  "norm1" = list("mu" = 0, "sd" = 1),
  "norm2" = list("mu" = 1, "sd" = 1),
  "norm3" = list("mu" = 2, "scale" = 1)
)
params %>% map(~rnorm(5, mean = pluck(.x, 1), sd = pluck(.x, 2)))
#> $norm1
#> [1]  0.0731 -2.4229 -0.4865  1.9211 -0.4199
#> 
#> $norm2
#> [1] 2.458 1.885 0.912 1.702 0.710
#> 
#> $norm3
#> [1] 2.549 1.718 3.815 0.892 1.520
```

`enframe()` konverteerib nimedega vektori df-ks, millel on 2 veergu (name, value). 

### map2()

Itereerib üle kahe vektori - map2(.x, .y, .f). 

.x ja .y on sama pikad vektorid (ühe-elemendine vektor kõlbab ka - seda lihtsalt retsükleeritakse nii mitu korda, kui teises vektoris on liikmeid).

.f on funktsioon või ekspressioon (valem) 

Ekspressioon `map2()`-le algab ikka tildega; esimese vektori elemendid on .x
teise vektori elemendid on .y

Näiteks `map2(x, y, ~ .x + .y)` liidab vektorid x ja y

### pmap()

itereerib üle 3+ vektori. 
Näiteks `pmap(list(x, y, z), sum)` liidab 3 vektorit (x, y ja z on ise vektorid)

Järgnevas koodis anname ette listi long_numbers kolme vektoriga (pi, exp(1) ja sqrt(2)) ning vektori digits kolme liikmega, mida kasutab funktsiooni round() argument digits. Andes sellele argumendile 3 erinevat väärtust saame me kolm erinevat ümardamist kolmele listi long_numbers liikmele. 

```r
long_numbers <- list(pi, exp(1), sqrt(2))
digits <- list(2, 3, 4)
pmap(list(x = long_numbers, digits = digits), round)
#> [[1]]
#> [1] 3.14
#> 
#> [[2]]
#> [1] 2.72
#> 
#> [[3]]
#> [1] 1.41
```

pmap() ekspressioonide sisesed elemndid on ..1, ..2, ..3 jne, mitte .x ja .y nagu map2-l. 

NB! pmap-i saab sisetada data frame, mille peal see töötab rea kaupa.


```r
parameters <- data.frame(
  n = c(1, 2, 3),
  min = c(0, 5, 10),
  max = c(1, 6, 11)
)
parameters %>% pmap(runif)
#> [[1]]
#> [1] 0.619
#> 
#> [[2]]
#> [1] 5.73 5.21
#> 
#> [[3]]
#> [1] 10.9 10.5 10.5
```

See töötab sest runif() võtab 3 argumenti ja df-l parameters on 3 veergu.

Järgmine funktsioon rakendub suvalisele df-le rea kaupa ja arvutab igale reale näit sd. Aga selleks transponeerime read veergudeks ja rakendame tavalist map()-i. 


```r
rmap <- function (.x, .f, ...) {
    if(is.null(dim(.x))) stop("dim(X) must have a positive length")
    .x <- t(.x) %>% as.data.frame(.,stringsAsFactors=F)
    purrr::map_dfr(.x=.x,.f=.f,...)
}
parameters %>% rmap(sd)
#> # A tibble: 1 x 3
#>      V1    V2    V3
#>   <dbl> <dbl> <dbl>
#> 1 0.577  2.08  4.36
```

apply teeb sama lihtsamini.

```r
apply(parameters, 1, sd)
#> [1] 0.577 2.082 4.359
```

### invoke_map() 

itereerib üle funktsioonide vektori, millele järgneb argumentide vektor. 1. funktsioon  esimese argumendiga jne.

```r
functions <- list(rnorm, rlnorm, rcauchy)
n <- list(c(5, 2, 3), 2, 3)
invoke_map(functions, n)
#> [[1]]
#> [1]  0.856  2.915 -1.559  6.140  2.703
#> 
#> [[2]]
#> [1] 0.0625 1.2218
#> 
#> [[3]]
#> [1] -0.608 -2.302 -1.759
```

anname sisse esimese argumendi (100) igasse funktsiooni

```r
functions <- list(rnorm, rlnorm, rcauchy)
n <- c(5, 2, 3)
invoke_map(functions, n, 100)
#> [[1]]
#> [1]  99.5  99.0 100.9  98.6 101.4
#> 
#> [[2]]
#> [1] 4.17e+43 7.35e+42
#> 
#> [[3]]
#> [1]  99.6 102.1  99.1
```

mitu argumenti igale funktsioonile:

```r
args <- list(norm = c(3, mean = 0, sd = 1), 
             lnorm = c(2, meanlog = 1, sdlog = 2),
             cauchy = c(1, location = 10, scale = 100))

invoke_map(functions, args)
#> [[1]]
#> [1] -0.304 -0.367 -0.245
#> 
#> [[2]]
#> [1] 2.90 8.25
#> 
#> [[3]]
#> [1] -78.5
```


#### map shortcuts

`pluck()` võtab listist välja elemendi (vektori, data frame jms) nii nagu see on (mitte listina).


```r
list1 <- list(
  numbers = 1:3,
  letters = c("a", "b", "c"),
  logicals = c(TRUE, FALSE)
)

pluck(list1, 1) # list1 %>% pluck(1)
#> [1] 1 2 3
pluck(list1, "numbers") # list1 %>% pluck("numbers")
#> [1] 1 2 3
```


Andes map()-le ette character stringi (elemendi nime), saame tagasi elemendi igast alam-listist, mille nimi vastab sellele stringile. See on shotcut pluck-ile.


```r
params <- list(
  "norm1" = list("mu" = 0, "sd" = 1),
  "norm2" = list("mu" = 1, "sd" = 1),
  "norm3" = list("mu" = 2, "scale" = 1)
)
map_dbl(params, "mu")
#> norm1 norm2 norm3 
#>     0     1     2
```

Sama teeb, kui map-le ette anda elemendi positsioon listis

```r
map_dbl(params, 1)
#> norm1 norm2 norm3 
#>     0     1     2
```

Nii saab kätte samad tulbad (vektorid) mitmest data frame-st (kui list sisaldab data frame-sid).

**veel mõned abifunktsioonid:**

lmap() works exclusively with functions that take lists
imap() applies a function to each element of a vector, and its index
map_at() and map_if() only map a function to specific elements of a list.

#### List column

Df-i veerg, mille andmetüüp on list. Näiteks mudeliobjektid, funktsioonid ja teised df-d võivad minna list columnisse!
List columnid on ise listid, mitte andmevektorid. 

      List veerud võimaldavad panna samasse tabelisse erinevaid asju - 
      andmeid, mudeleid, mudeli koefitsiente jms. 

nest() teeb uue df-i, kus on 1. veerg grupeeriva muutuja tasemetega, millele järgneb list column, mille iga element on tibble. Iga tibble sisaldab relevantset infot  grupeeriva muutuja vastava taseme kohta. 

```r
library(gapminder)
(nested_gapminder <- gapminder %>% group_by(country) %>% nest())
#> # A tibble: 142 x 2
#> # Groups:   country [142]
#>   country               data
#>   <fct>       <list<df[,5]>>
#> 1 Afghanistan       [12 x 5]
#> 2 Albania           [12 x 5]
#> 3 Algeria           [12 x 5]
#> 4 Angola            [12 x 5]
#> 5 Argentina         [12 x 5]
#> 6 Australia         [12 x 5]
#> # ... with 136 more rows
```

unnest() teeb algse df-i tagasi.

iga nested_gapminder$data element on ise df:

```r
nested_gapminder %>% 
  pluck("data") %>% 
  pluck(1) # %>% lm(lifeExp ~ year, data = .)
#> # A tibble: 12 x 5
#>   continent  year lifeExp      pop gdpPercap
#>   <fct>     <int>   <dbl>    <int>     <dbl>
#> 1 Asia       1952    28.8  8425333      779.
#> 2 Asia       1957    30.3  9240934      821.
#> 3 Asia       1962    32.0 10267083      853.
#> 4 Asia       1967    34.0 11537966      836.
#> 5 Asia       1972    36.1 13079460      740.
#> 6 Asia       1977    38.4 14880372      786.
#> # ... with 6 more rows
#fitime ühe mudeli 1. elemendile (1. riik)
```

fit a model to each tibble nested within nested_gapminder and then store those models as a list column
 
 fitime mudeli igale listi veerule (igale riigile). väljund on ilge list.

```r
model1 <- nested_gapminder %>%  
  pluck("data") %>%
  map(~ lm(lifeExp ~ year, data = .x))
```

arvutame mudelid igale riigile ja pistame väljundi (mudeliobjekti)  nested_gapminder uude list columnisse:

```r
models1 <- nested_gapminder %>% 
  mutate(models = map(data, ~ lm(lifeExp ~ year, data = .x)))
```


võtame välja mudeli koefitsiendi year ja paneme uude veergu nimega coefficient:

```r
models1 <-  models1 %>% mutate( coefficient = map_dbl(models, ~coef(.x) %>% pluck("year")) )
```

df-i veerg models on ühtlasi list, millele saame map_dbl() rakendada.


järgnevad 3 koodirida teevad sama asja - võtavad välja 1. mudeli:

```r
models1 %>% 
  pluck("models") %>% 
  pluck(1)

models1[[1, 3]]

models1$models[[1]]
```


