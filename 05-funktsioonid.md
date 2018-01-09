
# Funktsioonid on R keele verbid {#funs}

Kasutaja ütleb nii täpselt kui oskab, mida ta tahab ja R-s elab kratt, kes püüab ära arvata, mida on vaja teha. 
Vahest teeb kah. 
Vahest isegi seda, mida kasutaja tahtis. 
Mõni arvab, et R-i puudus on veateadete puudumine või krüptilised veateated. 
Sama kehtib ka R-i helpi kohta. 
Seega tasub alati kontrollida, kas R ikka tegi seda, mida sina talle enda arust ette kirjutasid.

Paljudel juhtudel ütleb (hea) funktsiooni nimi mida see teeb:

```r
# create two test vectors
x <- c(6, 3, 3, 4, 5)
y <- c(1, 3, 4, 2, 7)
```


```r
# calculate correlation
cor(x, y)
```

```
## [1] -0.1166019
```

```r
# calculate sum
sum(x)
```

```
## [1] 21
```

```r
# calculate sum of two vectors
sum(x, y)
```

```
## [1] 38
```

```r
# calculate average
mean(x)
```

```
## [1] 4.2
```

```r
# calculate median
median(x)
```

```
## [1] 4
```

```r
# calculate standard deviation
sd(x)
```

```
## [1] 1.30384
```

```r
# return quantiles
quantile(x)
```

```
##   0%  25%  50%  75% 100% 
##    3    3    4    5    6
```

```r
# return maximum value
max(x)
```

```
## [1] 6
```

```r
# return minimum value
min(x)
```

```
## [1] 3
```

R-is teevad asju programmikesed, mida kutsutakse **funktsioonideks**. 
Te võite mõelda funktsioonist nagu verbist. 
Näiteks funktsiooni `sum()` korral loe: "võta summa". 
Iga funktsiooni nime järel on sulud. 
Nende sulgude sees asuvad selle funktsiooni **argumendid**. 
Argumendid määravad ära funktsiooni käitumise.
Et näha, millised argumendid on funktsiooni käivitamiseks vajalikud ja milliseid on üldse võimalik seadistada, kasuta 'help' käsku.



```r
?sum
```

Help paneelis paremal all ilmub nüüd selle funktsiooni R dokumentatsioon. 
Vaata seal peatükki Usage: `sum(..., na.rm = FALSE)` ja edasi peatükki Arguments, mis ütleb, et `...` (ellipsis) tähistab vektoreid. 


    sum {base}	R Documentation 
    Sum of Vector Elements

    Description:

    sum returns the sum of all the values present in its arguments.

    Usage

    sum(..., na.rm = FALSE)

    Arguments

    ...	- numeric or complex or logical vectors.

    na.rm	- logical. Should missing values (including NaN) be removed?


Seega võtab funktsioon `sum()` kaks argumenti: vektori arvudest (või loogilise vektori, mis koosneb TRUE ja FALSE määrangutest), ning "na.rm" argumendi, millele saab anda väärtuseks kas, TRUE või FALSE. 
Usage ütleb ka, et vaikimisi on `na.rm = FALSE`, mis tähendab, et sellele argumendile on antud vaikeväärtus -- kui me seda ise ei muuda, siis jäävad NA-d arvutusse sisse. 
Kuna NA tähendab "tundmatu arv" siis iga tehe NA-dega annab vastuseks "tundmatu arv" ehk NA (tundmatu arv + 2 = tundmatu arv). 
Seega NA tulemus annab märku, et teie andmetes võib olla midagi valesti.


```r
## moodustame vektori
apples <- c(1, 34, 43, NA)
## arvutame summa
sum(apples, na.rm = TRUE)
```

```
## [1] 78
```
Niimoodi saab arvutada summat vektorile nimega "apples".

Sisestades R käsureale funktsiooni ilma selle sulgudeta saab masinast selle funktsiooni koodi. Näiteks:

```r
sum
```

```
## function (..., na.rm = FALSE)  .Primitive("sum")
```
Tulemus näitab, et `sum()` on `Primitive` funktsioon, mis põhimõtteliselt tähendab, et ta põhineb C koodil ja ei kasuta R koodi.

## Kirjutame R funktsiooni

Võib ju väita, et funktsiooni ainus mõte on peita teie eest korduvad vajalikud koodiread kood funktsiooni nime taha. 
Põhjus, miks R-s on funktsioonid, on korduse vähendamine, koodi loetavaks muutmine ja seega ka ruumi kokkuhoid. 
Koodi funktsioonidena kasutamine suurendab analüüside reprodutseeritavust, kuna funktsioonis olev kood pärineb ühest allikast, mitte ei ole paljude koopiatena igal pool laiali.
See muudab pikad koodilõigud hõlpsalt taaskasutatavaks sest lihtsam on kirjutada lühike funktsiooni nimi ja sisestada selle funktsiooni argumendid. 
Koodi funktsioonidesse kokku surumine vähendab võimalusi lollideks vigadeks, mida te võite teha pikkade koodijuppidega manipuleerides. 
Seega tasub teil õppida ka oma korduvaid koodiridu funktsioonidena vormistama.

Kõige pealt kirjutame natuke koodi.

```r
# two apples
apples <- 2
# three oranges
oranges <- 3 
# parentheses around expression assigning result to an object 
# ensure that result is also printed to R console
(inventory <- apples + oranges)
```

```
## [1] 5
```
 
Ja nüüd pakendame selle tehte funktsiooni `add2()`. 
Funktsiooni defineerimiseks kasutame järgmist r ekspressiooni `function( arglist ) expr`, kus "arglist" on tühi või ühe või rohkema nimega argumenti kujul `name=expression`; "expr" on R-i ekspressioon st. kood mida see funktsioon käivitab. 
Funktsiooni viimane evlueeritav koodirida on see, mis tuleb välja selle funktsiooni outputina.

All toodud näites on selleks `x + y` tehte vastus.

```r
add2 <- function(x, y) {
    x + y
}
```
Seda koodi jooksutades näeme, et meie funktsioon ilmub R-i Environmenti, kuhu tekib Functions lahter. 
Seal on näha ka selle funktsiooni kaks argumenti, apples ja oranges.

Antud funktsiooni käivitamine annab veateate, sest funktsiooni argumentidel pole väärtusi:

```r
## run function in failsafe mode
inventory <- try(add2())
## when function fails, error message is returned
class(inventory)
```

```
## [1] "try-error"
```

```r
## print error message
cat(inventory)
```

```
## Error in add2() : argument "x" is missing, with no default
```

Andes funktsiooni argumentidele väärtused, saab väljundi:

```r
## run function with proper arguments
inventory <- add2(x = apples, y = oranges)
## numeric vector is returned
class(inventory)
```

```
## [1] "numeric"
```

```r
## result
inventory
```

```
## [1] 5
```



**Nüüd midagi kasulikumat!**

Funktsioon standrardvea arvutamiseks (baas R-s sellist funktsiooni ei ole):
`sd()` funktsioon arvutab standardhälbe. 
Sellel on kaks argumenti: x and na.rm.
Me teame, et SEM=SD/sqrt(N)
kus N = length(x)

```r
calc_sem <- function(x) {
  stdev <- sd(x)
  n <- length(x)
  stdev / sqrt(n)
}
```

x hoiab lihtsalt kohta andmetele, mida me tahame sinna funktsiooni suunata.
`sd()`, `sqrt()` ja `length()` on olemasolevad baas R funktsioonid, mille me oma funktsiooni hõlmame.


```r
## create numeric vector
numbers <- c(2, 3.4, 54, NA, 3)
calc_sem(numbers)
```

```
## [1] NA
```
No jah, kui meil on andmetes tundmatu arv (`NA`) siis on ka tulemuseks tundmatu arv.

Sellisel juhul tuleb NA väärtused vektorist enne selle funktsiooni kasutamist välja visata:

```r
numbers_filtered <- na.omit(numbers)
calc_sem(numbers_filtered)
```

```
## [1] 12.80338
```

On ka võimalus funktsiooni sisse kirjutada **NA väärtuste käsitlemine**. Näiteks, üks võimalus on **anda viga** ja funktsioon katkestada, et kasutaja saaks ise ühemõtteliselt oma andmetest NA väärtused eemaldada. 
Teine võimalus on funktsioonis **NA-d vaikimisi eemaldada** ja anda selle kohta näiteks teade.

NA-de vaikimisi eemaldamiseks on hetkel mitu võimalust, kasutame kõigepealt nö. valet lahendust:

```r
calc_sem <- function(x) {
  ## kasutame sd funktsiooni argumenti na.rm
  stdev <- sd(x, na.rm = TRUE)
  n <- length(x)
  stdev / sqrt(n)
}

calc_sem(numbers)
```

```
## [1] 11.4517
```
See annab meile vale tulemuse sest `na.rm = TRUE` viskab küll NA-d välja meie vektorist aga jätab vektori pikkuse muutmata (`length(x)` rida).

Teeme uue versiooni oma funktsioonist, mis viskab vaikimisi välja puuduvad väärtused, kui need on olemas ja annab siis ka selle kohta hoiatuse.

```r
## x on numbriline vektor
calc_sem <- function(x) {
  
  ## viskame NA väärtused vektorist välja
  x <- na.omit(x)
  
  ## kui vektoris on NA väärtusi, siis hoiatame kasutajat
  if(inherits(na.action(x), "omit")) {
    warning("Removed NAs from vector.\n")
  }
  
  ## arvutame standardvea kasutades filtreeritud vektorit
  stdev <- sd(x)
  n <- length(x)
  stdev / sqrt(n)
}

calc_sem(numbers)
```

```
## Warning in calc_sem(numbers): Removed NAs from vector.
```

```
## [1] 12.80338
```

```r
length(numbers)
```

```
## [1] 5
```

Missugune funktsiooni käitumine valida, sõltub kasutaja vajadusest.
Rohkem infot NA käsitlemise funktsioonide kohta saab `?na.omit` abifailist.

Olgu see õpetuseks, et funktsioonide kirjutamine on järk-järguline protsess ja sellele, et alati saab paremini teha.
