

# Graafilised lahendused

R-s on kaks olulisemat graafikasüsteemi, mida võib vaadata nagu kaht eraldi dialekti, mis mõlemad elavad R keele sees. 

- **Baasgraafika** võimaldab lihtsate vahenditega teha kiireid ja suhteliselt ilusaid graafikuid. 
Seda kasutame sageli enda tarbeks kiirete plottide tegemiseks.
Baasgraafika abil saab teha ka väga keerukaid ja kompleksseid publitseerimiskavaliteedis graafikuid.
- **"ggplot2"** raamatukogu on hea ilupiltide vormistamiseks ja keskmiselt keeruliste visualiseeringute tegemiseks.


Kuigi "ggplot2" ja tema sateliit-raamatukogud on meie põhilised huviobjekid, alustame siiski baasgraafikast. 
Ehki me piirdume vaid väga lihtsate näidetega tasub teada, et baasgraafikas saab teha ka komplekseid visualiseeringuid: http://shinyapps.org/apps/RGraphCompendium/index.php

Laadime peatükis edaspidi vajalikud libraryd:

```r
library(tidyverse)
library(ggthemes)
library(ggrepel)
library(wesanderson)
library(ggridges)
library(viridis)
library(zoo)
library(graphics)
```

## Baasgraafika

Kõigepealt laadime tabeli, mida me visuaalselt analüüsima hakkame:

```r
iris <- as_tibble(iris)
iris
#> # A tibble: 150 x 5
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#>          <dbl>       <dbl>        <dbl>       <dbl>
#> 1          5.1         3.5          1.4         0.2
#> 2          4.9         3            1.4         0.2
#> 3          4.7         3.2          1.3         0.2
#> 4          4.6         3.1          1.5         0.2
#> 5          5           3.6          1.4         0.2
#> 6          5.4         3.9          1.7         0.4
#> # ... with 144 more rows, and 1 more variable:
#> #   Species <fct>
```

See sisaldab mõõtmistulemusi sentimeetrites kolme iirise perekonna liigi kohta.
Esimest korda avaldati need andmed 1936. aastal R.A. Fisheri poolt. 

Baasgraafika põhiverb on `plot()`. 
See püüab teie poolt ette antud andmete pealt ära arvata, millist graafikut te soovite. 
`plot()` põhiargumendid on x ja y, mis määravad selle, mis väärtused asetatakse x-teljele ja mis läheb y-teljele. 
Esimene argument on vaikimisi x ja teine y.


Kui te annate ette faktorandmed, on vastuseks tulpdiagramm, kus tulbad loevad üles selle faktori kõigi tasemete esinemiste arvu. 
Antud juhul on meil igast liigist mõõdetud 50 isendit.

```r
plot(iris$Species)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-3-1} \end{center}

Kui te annate ette ühe pideva muutuja:

```r
plot(iris$Sepal.Length)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-4-1} \end{center}

Nüüd on tulemuseks graafik, kus on näha mõõtmisete rea (ehk tabeli) iga järgmise liikme (tabeli rea) väärtus. 
Siin on meil kokku 150 mõõtmist muutujale `Sepal.Length`.


Alternatiiv sellele vaatele on `stripchart()`

```r
stripchart(iris$Sepal.Length)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-5-1} \end{center}

Enam lihtsamaks üks joonis ei lähe!


Mis juhtub, kui me x-teljele paneme faktortunnuse ja y-teljele pideva tunnuse?

```r
plot(iris$Species, iris$Sepal.Length)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-6-1} \end{center}

Vastuseks on boxplot. Sama graafiku saame ka nii: 

```r
boxplot(iris$Sepal.Length ~ iris$Species).
```

Siin on tegu R-i mudeli notatsiooniga: y-telje muutuja, tilde, x-telje muutuja. Tilde näitab, et y sõltub x-st stohhastiliselt, mitte deterministlikult. Deterministliku seost tähistatakse võrdusmärgiga (=).

Aga vastupidi?

```r
plot(iris$Sepal.Length, iris$Species)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-8-1} \end{center}

Pole paha, see on üsna informatiivne scatterplot.

Järgmiseks kahe pideva muutuja scatterplot, kus me veel lisaks värvime punktid liikide järgi.

```r
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-9-1} \end{center}

Ja lõpuks tõmbame läbi punktide punase regressioonijoone: 

```r
plot(iris$Sepal.Length, iris$Sepal.Width)
model <- lm(iris$Sepal.Width ~ iris$Sepal.Length)
abline(model, col = "red", lwd = 2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-10-1} \end{center}

"lwd" parameeter reguleerib joone laiust. 
`lm()` on funktsioon, mis fitib sirge vähimruutude meetodil.

Mis juhtub, kui me anname `plot()` funktsioonile sisse kogu irise tibble?

```r
plot(iris, col = iris$Species)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-11-1} \end{center}

Juhhei, tulemus on paariviisiline graafik kõigist muutujate kombinatsioonidest.

Ainus  mitte-plot verb, mida baasgraafikas vajame, on `hist()`, mis joonistab histogrammi.

```r
hist(iris$Sepal.Length)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-12-1} \end{center}

Histogrammi tegemiseks jagatakse andmepunktid nende väärtuste järgi bin-idesse ja plotitakse igasse bin-i sattunud andmepunktide arv. 
Näiteks esimeses bin-is on "Sepal.Length" muutuja väärtused, mis jäävad 4 ja 4.5 cm vahele ja selliseid väärtusi on kokku viis. 
Histogrammi puhul on oluline teada, et selle kuju sõltub bin-ide laiusest.
Bini laiust saab muuta kahel viisil, andes ette bin-ide piirid või arvu:

```r
hist(iris$Sepal.Length, breaks = seq(4, 9, by = 0.25))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-13-1} \end{center}

või

```r
hist(iris$Sepal.Length, breaks = 15)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-14-1} \end{center}

See viimane on kiire viis bin-i laiust reguleerida, aga arvestage, et sõltuvalt andmetest ei pruugi "breaks = 15" tähendada, et teie histogrammil on 15 bin-i.

Ja lõpuks veel üks histogramm, et demonstreerida baas R-i võimalusi (samad argumendid töötavad ka `plot()` funktsioonis):

```r
hist(iris$Sepal.Length,
     freq = FALSE, 
     col="red",
     breaks = 15,
     xlim = c(3, 9), 
     ylim = c(0, 0.6), 
     main = "Iris",
     xlab = "Sepal length",
     ylab = "Probability density")

abline(v = median(iris$Sepal.Length), col = "blue", lwd = 2) 
abline(h = 0.3, col = "cyan", lwd = 2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-15-1} \end{center}

## ggplot2

Ggplot on avaldamiseks sobiva tasemega lihtne aga võimas graafikasüsteem. 
Näiteid selle abil tehtud visualiseeringutest leiab näiteks järgnevatelt linkidelt: 

- http://ggplot2.tidyverse.org/reference/ 
- http://www.r-graph-gallery.com
- http://www.ggplot2-exts.org
- http://www.cookbook-r.com


"ggplot2" paketi põhiverb on `ggplot()`. 
See graafikasüsteem töötab kiht-kihi-haaval ja uusi kihte lisatakse pluss-märgi abil. 
See annab modulaarsuse kaudu lihtsuse ja võimaluse luua ka keerulisi taieseid. 
Tõenäoliselt on ggplot hetkel kättesaadavatest graafikasüsteemidest parim (kaasa arvatud tasulised programmid!).


### graafika "keel"

Millised elemendid on igal endast lugupidaval graafikul? 

**Esiteks teljestik** ehk graafiku ruum. Isegi siis, kui telgi pole välja joonistatud, on nad tegelikult alati olemas ja määravad akna, milles olevaid andmeid graafikul kuvatakse. Teljed võivad olla andmetega samas "ruumis" või transformeeritud (näit. logaritmitud). Lisaks on teljedel on suund (vasakult paremale, ülevalt alla, ringiratast, jms). Vastavalt teljestikule võib graafiku kuju olla 1D sirge, 2D ruut, 3D kuup, kera, ristkülik, trapets vms.

**Teiseks graafikule kaardistatud muutujad.** Näit võib x teljele kaardistada pideva muutuja "Sepal.Width" ja y teljele pideva muutuja Sepal.Length. Lisaks võime igale andmepunktile kaardistada näiteks värvi, mis vastab faktormuutuja Species tasemele. Aga võib ka x teljele kaardistada muutuja Sepal.Length ja y telje kaardistamata jätta. Esimesel juhul on võimalik joonistada näiteks scatter plot või line plot, teisel juhul aga histogramm või tihedusplot. Seega on graafiku tüüp veel lahtine.

**Kolmandaks graafiku tüüp.** Osad tüübid kasutavad andmeid otse (n scatter plot), teised arvutavad andmete pealt statistiku, ja plotivad selle (n histogramm). Graafikul on see nn data ink. 

**Neljandaks graafiku esteeetika.** Siia kuuluvad telgede paksused, värvid, tähistused, abijooned, taustavärvid ja kõik muu, mis otseselt ei kajasta andmeid. Graafikul on see nn non-data ink. Oluline on suhe data ink/non-data ink. Kui see suhe on väga madal, siis on teie graafiku teaduslik sisu raskesti leitav ja ilmselt peaks graafikut muutma. Samas, kui see suhe on väga kõrge, tekib oht, et puudu on tähelepanu õigesse kohta juhtivad abijooned ja muu selline, mistõttu andmed ripuvad nagu õhus.  

Ongi kõik. Teljestik sinna kaardistatud muutujatega, graafiku tüüp ja teema on kõik, mida me vajame, et teha ükskõik milline joonis 

ggploti töövoog kajastab seda kiht-kihi haaval ideoloogiat. Kihid eraldatakse omavahel "+" märgiga. Minimaalselt pead ggplot() funktsioonile andma kolm asja: 

1. **andmed**, mida visualiseeritakse, 

2. `aes()` funktsiooni, mis määrab, milline muutuja läheb x-teljele ja milline y-teljele, ning 

3. **geom**, mis määrab, mis tüüpi visualiseeringut sa tahad. 


Lisaks määrad sa `aes()`-is, kas ja kuidas sa tahad grupeerida pidevaid muutujaid faktori tasemete järgi.

Lisakihtides saab dikteerida, 

4. kuidas joonise elemendid jagada erinevate paneelide (facet, small multiple) vahel, kasutades facet_wrap() ja facet_grid() funktsioone.

5. määrata joonise teema theme() funktsiooni abil ning manipuleerida värve, telgi jms erinevate abifunktsioonidega.


Kõigepealt suuname oma andmed `ggplot()` funktsiooni:

```r
ggplot(iris)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grggplot-1} \end{center}

Saime tühja ploti. ggplot() loob vaid koordinaatsüsteemi, millele saab kihte lisada. 
Erinevalt baasgraafikast, ggplot-i puhul ainult andmetest ei piisa, et graafik valmis joonistataks.
Vaja on lisada kiht-kihilt instruktsioonid, kuidas andmed graafikule paigutada ja missugust graafikutüüpi visualiseerimiseks kasutada.

Nüüd ütleme, et x-teljele pannakse "Sepal.Length" ja y-teljele "Sepal.Width" andmed.
Pane siin tähele, et me suuname kõigepealt selle ploti objekti p ja alles siis trükime selle ggplot objekti välja.
Meie näites lisame edaspidi kihte sellele ggplot objektile.

```r
p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))
p
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-16-1} \end{center}

Graafik on ikka tühi sest me pole ggplotile öelnud, millist visualiseeringut me tahame. 
Teeme seda nüüd ja lisame andmepunktid kasutades `geom_point`-i ja lineaarse regressioonijoone kasutades `geom_smooth` funktsiooni koos argumendiga `method = lm`.
Ka nüüd täiendame ggplot objekti p uute kihtidega:

```r
p <- p + geom_point() + geom_smooth(method = lm)
p
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-17-1} \end{center}

Veelkord, me lisasime kaks kihti: esimene kiht `geom_point()` visualiseerib andmepunktid ja teine `geom_smooth(method = "lm")` joonistab regressioonisirge koos usaldusintervalliga (standardviga).

>Plussmärk peab ggplot-i koodireas olema vana rea lõpus, mitte uue rea (kihi) alguses


### Lisame plotile sirgjooni

Horisontaalsed sirged saab graafikule lisada `geom_hline()` abil.
Pane tähele, et eelnevalt me andsime oma ggplot-i põhikihtidele nime "p" ja seega panime selle alusploti oma töökeskkonda, et saaksime seda korduvkasutada.

Lisame graafikule p horisontaaljoone y = 20:

```r
# Add horizontal line at y = 2O
p + geom_hline(yintercept = 20)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-18-1} \end{center}

Vertikaalseid sirgeid saab lisada `geom_vline()` abil, näiteks vertikaalne sirge asukohas x = 3:

```r
# Add a vertical line at x = 3
p + geom_vline(xintercept = 3)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-19-1} \end{center}

### Segmendid ja nooled 

"ggplot2" funktsioon `geom_segment()` lisab joonejupi, mille algus ja lõpp on ette antud.


```r
# Add a vertical line segment
p + geom_segment(aes(x = 4, y = 15, xend = 4, yend = 27))

# Add horizontal line segment
p + geom_segment(aes(x = 2, y = 15, xend = 3, yend = 15))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-20-1} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-20-2} \end{center}

Saab joonistada ka **nooli**, kasutades arumenti "arrow" funktsioonis `geom_segment()`


```r
p + geom_segment(aes(x = 5, y = 30, xend = 3.5, yend = 25),
                 arrow = arrow(length = unit(0.5, "cm")))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-21-1} \end{center}


### Joongraafikud

"ggplot2"-s on näiteks joonetüübid on "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash".


```r
meals <- data.frame(sex = rep(c("Female", "Male"), each = 3),
                  time = c("Breakfeast", "Lunch", "Dinner"),
                  bill = c(10, 30, 15, 13, 40, 17) )

# Change line colors and sizes
ggplot(data = meals, aes(x = time, y = bill, group = sex)) +
  geom_line(linetype = "dotted", color = "red", size = 2) +
  geom_point(color = "blue", size = 3)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-22-1} \end{center}

Järgneval graafikul muudame joonetüüpi automaatselt muutuja sex taseme järgi:

```r
# Change line types + colors
ggplot(meals, aes(x = time, y = bill, group = sex)) +
  geom_line(aes(linetype = sex, color = sex)) +
  geom_point(aes(color = sex)) +
  theme(legend.position = "top")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-23-1} \end{center}

Muuda jooni käsitsi:

- `scale_linetype_manual()`: joone tüüp

- `scale_color_manual()`: joone värv

- `scale_size_manual()`: joone laius



```r
ggplot(meals, aes(x = time, y = bill, group = sex)) +
  geom_line(aes(linetype = sex, color = sex, size = sex)) +
  geom_point() +
  scale_linetype_manual(values = c("twodash", "dotted")) +
  scale_color_manual(values = c('#999999', '#E69F00')) +
  scale_size_manual(values = c(1, 1.5)) +
  theme(legend.position = "top")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-24-1} \end{center}


### Punktide tähistamise trikid

`aes()` töötab nii `ggplot()` kui `geom_` funktsioonides.

```r
ggplot(iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, size = Petal.Length, color = Species))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-25-1} \end{center}

Kui me kasutame color argumenti `aes()`-st väljaspool, siis värvime kõik punktid sama värvi.

```r
ggplot(iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, size = Petal.Length), color = "red")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-26-1} \end{center}


Kasulik trikk on kasutada mitut andmesetti sama ploti tegemiseks. 
Uus andmestik -- "mpg" -- on autode kütusekulu kohta.

```r
head(mpg, 2)
#> # A tibble: 2 x 11
#>   manufacturer model displ  year   cyl trans drv  
#>   <chr>        <chr> <dbl> <int> <int> <chr> <chr>
#> 1 audi         a4      1.8  1999     4 auto~ f    
#> 2 audi         a4      1.8  1999     4 manu~ f    
#> # ... with 4 more variables: cty <int>, hwy <int>,
#> #   fl <chr>, class <chr>

best_in_class <- mpg %>%
  group_by(class) %>%
  top_n(1, hwy)

head(best_in_class)
#> # A tibble: 6 x 11
#> # Groups:   class [2]
#>   manufacturer model displ  year   cyl trans drv  
#>   <chr>        <chr> <dbl> <int> <int> <chr> <chr>
#> 1 chevrolet    corv~   5.7  1999     8 manu~ r    
#> 2 chevrolet    corv~   6.2  2008     8 manu~ r    
#> 3 dodge        cara~   2.4  1999     4 auto~ f    
#> 4 dodge        cara~   3    1999     6 auto~ f    
#> 5 dodge        cara~   3.3  2008     6 auto~ f    
#> 6 dodge        cara~   3.3  2008     6 auto~ f    
#> # ... with 4 more variables: cty <int>, hwy <int>,
#> #   fl <chr>, class <chr>
```

Siin läheb kitsam andmeset uude `geom_point()` kihti ja teeb osad punktid teistsuguseks. 
Need on oma klassi parimad autod.

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))+
  geom_point(size = 3, shape = 1, data = best_in_class) 
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-28-1} \end{center}

Lõpuks toome graafikul eraldi välja nende parimate autode mudelite nimed. 
Selleks kasutame "ggrepel" raamatukogu funktsiooni `geom_label_repel()`.

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))+
  geom_point(size = 3, shape = 1, data = best_in_class) +
  geom_label_repel(aes(label = model), data = best_in_class, cex = 2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-29-1} \end{center}

## _Facet_ -- pisigraafik

Kui teil on mitmeid muutujaid või nende alamhulki, on teil kaks võimalust.

1. grupeeri pidevad muutujad faktormuutujate tasemete järgi ja kasuta color, fill, shape, size alpha parameetreid, et erinevatel gruppidel vahet teha.

2. grupeeri samamoodi ja kasuta facet-it, et iga grupp omaenda paneelile panna.

 

```r
# here we separate different classes of cars into different colors
p <- ggplot(mpg, aes(displ, hwy)) 
p + geom_point(aes(colour = class))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-30-1} \end{center}



```r
p + geom_point() + 
  facet_wrap(~ class)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-31-1} \end{center}


```r
p + geom_point() +
  facet_wrap(~ class, nrow = 2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-32-1} \end{center}

Kui me tahame kahe muutuja kõigi kombinatsioonide vastu paneele, siis kasuta `facet_grid()` funktsiooni.

```r
p + geom_point() +
  facet_grid(drv ~ cyl)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-33-1} \end{center}

- "drv" -- drive - 4(-wheel), f(orward), r(ear).
- "cyl" -- cylinders - 4, 5, 6, or 8.

Kasutades punkti `.` on võimalik asetada kõik alamgraafikud kõrvuti `(. ~ var)` või üksteise peale `(var ~ .)`.


```r
p + geom_point() +
  facet_grid(. ~ drv)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-34-1} \end{center}


```r
p + geom_point() +
  facet_grid(drv ~ .)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-35-1} \end{center}

## Mitu graafikut paneelidena ühel joonisel

Kõigepealt tooda komponentgraafikud ggplot() abil ja tee nendest graafilised objektid.
Näiteks nii: 


```r
library(tidyverse)
i1 <- ggplot(data= iris, aes(x=Sepal.Length)) + geom_histogram()
i2 <- ggplot(data= iris, aes(x=Sepal.Length)) + geom_density()
```

Seejäral, kasuta funktsioon `gridExtra::grid.arrange()` et graafikud kõrvuti panna


```r
library(gridExtra)
grid.arrange(i2, i1, nrow = 1) # ncol = 2 also works
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-36-1} \end{center}

## Teljed
### Telgede ulatus

Telgede ulatust saab määrata kolmel erineval viisil

1. filtreeri andmeid, mida plotid

2. pane x- ja y-teljele piirangud `xlim()`, `ylim()`

3. kasuta `coord_cartesian()` ja xlim, ylim parameetritena selle sees: `coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))`

Telgede ulatust saab muuta ka x- ja y-teljele eraldi:

- `scale_x_continuous(limits = range(mpg$displ))`
- `scale_y_continuous(limits = range(mpg$hwy))`


### Log skaalas teljed

1. Lineaarsed andmed lineaarsetel telgedel.


```r
ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point() + 
  ggtitle("Lineaarsed andmed ja teljed")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-37-1} \end{center}

2. Logaritmi andmed `aes()`-s.


```r
ggplot(cars, aes(x = log2(speed), y = log2(dist))) + 
  geom_point() +
  ggtitle("Andmed ja teljed on logaritmitud")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-38-1} \end{center}

3. Andmed on logaritmitud, aga teljed mitte.


```r
ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point() + 
  coord_trans(x = "log2", y = "log2") + 
  ggtitle("Andmed on logaritmitud, aga teljed mitte")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-39-1} \end{center}


### Pöörame graafikut 90 kraadi



```r
ggplot(iris, mapping = aes(x = Species, y = Sepal.Length)) + 
  geom_boxplot() +
  coord_flip()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-40-1} \end{center}



### Muudame telgede markeeringuid

Muudame y-telje markeeringut:

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5)) +
  ggtitle("y-telje markeeringud\n15 kuni 40, viieste vahedega")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-41-1} \end{center}

Muudame x-telje markeeringute nurka muutes `theme()` funktsiooni argumenti "axis.text.x":

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-42-1} \end{center}

Eemaldame telgede markeeringud, ka läbi `theme()` funktsiooni:

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  theme(axis.text = element_blank())
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-43-1} \end{center}

Muudame teljemarkeeringute järjekorda

```r
p <- ggplot(iris, aes(Species, Sepal.Length)) + geom_boxplot()
p
p + scale_x_discrete(breaks=c("versicolor", "setosa"))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-44-1} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-44-2} \end{center}

Muuda teljemarkeeringuid ja kustuta telje nimi.


```r
p + scale_x_discrete(labels=c("setosa" = "sp 1", "versicolor" = "sp2"), name=NULL)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-45-1} \end{center}



### telgede ja legendi nimed

```r
p <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + 
  geom_point()
p + labs(
     x = "Length",
     y = "Width",
     color = "Iris sp."
     )
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-46-1} \end{center}

Eemaldame telgede nimed:

```r
p + theme(axis.title = element_blank())
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-47-1} \end{center}


## Graafiku pealkiri, alapeakiri ja allkiri


```r
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + 
  geom_point() + 
  labs(
     title = "Main Title",
     subtitle = "Subtitle",
     caption = "Figure caption"
      )
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grpealk-1} \end{center}

`ggtitle()`  annab graafikule pealkirja

### Täpitähed jms graafikutel

R-s on sümbolid tavapäraselt UTF-8 kodeeringus. Mitte-inglise tähestikku kuuluvaid sümboleid saab lisada, andes ette nende kodeeringu, millele eelneb backslash. Näiteks "h\U00E4sti" annab joonisel "hästi". Täisnimekirja UTF-8 kodeeringutest leiab https://www.fileformat.info/info/charset/UTF-8/list.htm


## Graafiku legend

Legend erinevalt graafikust endast ei ole pool-läbipaistev.

```r
norm <- tibble(x = rnorm(1000), y = rnorm(1000))
norm$z <- cut(norm$x, 3, labels = c( "a" ,  "b" ,  "c" )) #creates a new column

ggplot(norm, aes(x, y)) +
  geom_point(aes(colour = z), alpha = 0.3) +
  guides(colour = guide_legend(override.aes = list(alpha = 1)))
```

legend graafiku sisse

```r
df <- data.frame(x = 1:3, y = 1:3, z = c( "a" ,  "b" ,  "c" ))
base <- ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z), size = 3) +
  xlab(NULL) +
  ylab(NULL)

base + theme(legend.position = c(0, 1), legend.justification = c(0, 1))
base + theme(legend.position = c(0.5, 0.5), legend.justification = c(0.5, 0.5))
base + theme(legend.position = c(1, 0), legend.justification = c(1, 0))

```


legendi asukoht graafiku ümber:

```r
base + theme(legend.position = "left")
base + theme(legend.position = "top")
base + theme(legend.position = "bottom")
base + theme(legend.position = "right") # the default
```

eemalda legend

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))+
  theme(legend.position = "none")

```




## Värviskaalad 

ColorBreweri skaala "Set1" on hästi nähtav värvipimedatele. colour_brewer skaalad loodi diskreetsetele muutujatele, aga nad näevad sageli head välja ka pidevate muutujate korral. 

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-52-1} \end{center}


### Värviskaalad pidevatele muutujatele

Pidevatele muutujatele töötab scale_colour_gradient() or scale_fill_gradient().
scale_colour_gradient2() võimaldab eristada näiteks positiivseid ja negatiivseid väärtusi erinevate värviskaaladega. 


```r
df <- data.frame(x = 1, y = 1:5, z = c(1, 3, 2, NA, 5))
p <- ggplot(df, aes(x, y)) + geom_tile(aes(fill = z), size = 5)
p
# Make missing colours invisible
p + scale_fill_gradient(na.value = NA)
# Customise on a black and white scale
p + scale_fill_gradient(low =  "black" , high =  "white" , na.value =  "red" )

#gradient between n colours
p+scale_color_gradientn(colours = rainbow(5))
```


```r
# Use distiller variant with continous data
ggplot(faithfuld) +
  geom_tile(aes(waiting, eruptions, fill = density)) + 
  scale_fill_distiller(palette = "Spectral")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-54-1} \end{center}


### Värviskaalad faktormuutujatele 

Tavaline värviskaala on scale_colour_hue() ja scale_fill_hue(), mis valivad värve HCL värvirattast. Töötavad hästi kuni u 8 värvini.


```r
ToothGrowth <- ToothGrowth
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
mtcars <- mtcars
mtcars$cyl <- as.factor(mtcars$cyl)

#bp for discrete color scales
bp<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_boxplot()
bp
#sp for continuous scales
sp<-ggplot(mtcars, aes(x=wt, y=mpg, color=cyl)) + geom_point()
sp

#You can control the default chroma and luminance, and the range 
#of hues, with the h, c and l arguments
bp + scale_fill_hue(l=40, c=35, h = c(180, 300)) #boxplot
sp + scale_color_hue(l=40, c=35) #scatterplot

```

Halli varjunditega töötab scale_fill_grey().


```r
bp + scale_fill_grey(start = 0.5, end = 1)
```


Järgmine võimalus on käsitsi värve sättida


```r
#bp for discrete color scales
bp<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_boxplot()
bp
#sp for continuous scales
sp<-ggplot(mtcars, aes(x=wt, y=mpg, color=cyl)) + geom_point()
sp
bp + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
sp + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))

```

Colour_brewer-i skaalad on loodud faktormuutujaid silmas pidades.


```r
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
d <- ggplot(dsamp, aes(carat, price)) +
  geom_point(aes(colour = clarity))
d + scale_colour_brewer()

# Change scale label
d + scale_colour_brewer("Diamond\nclarity")

# Select brewer palette to use, see ?scales::brewer_pal for more details
d + scale_colour_brewer(palette = "Greens")
d + scale_colour_brewer(palette = "Set1")

# scale_fill_brewer works just the same as
# scale_colour_brewer but for fill colours
p <- ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_histogram(position = "dodge", binwidth = 1000)
p + scale_fill_brewer()
# the order of colour can be reversed
# the brewer scales look better on a darker background
p + scale_fill_brewer(direction = -1) + theme_dark()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-58-1} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-58-2} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-58-3} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-58-4} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-58-5} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-58-6} \end{center}


Väga lahedad värviskaalad, mis eriti hästi sobivad diskreetsetele muutujatele, on wesanderson paketis. Enamus skaalasid on küll ainult 3-5 värviga. Sealt saab siiski ekstrapoleerida rohkematele värvidele (?wes_palette; ?wes_palettes).


```r
#install.packages("wesanderson")
#library(wesanderson)

#bp for discrete color scales
bp<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_boxplot()
bp

#wes_palette(name, n, type = c("discrete", "continuous"))
#n - the nr of colors desired, type - do you want a continious scalle?
bp+scale_fill_manual(values=wes_palette(n=3, name="GrandBudapest"))

wes_palette("Royal1")
wes_palette("GrandBudapest")
wes_palette("Cavalcanti")
wes_palette("BottleRocket")
wes_palette("Darjeeling")

wes_palettes #gives the complete list of palettes
```

Argument **breaks** kontrollib legendi. Sama kehtib ka teiste scale_xx() funktsioonide kohta.


```r
bp <- ToothGrowth %>% 
  ggplot(aes(x = dose, y = len, fill = dose)) +
  geom_boxplot()
bp
# Box plot
bp + scale_fill_manual(breaks = c("2", "1", "0.5"), 
                       values = c("red", "blue", "green"))

# color palettes
bp + scale_fill_brewer(palette = "Dark2") 
#sp + scale_color_brewer(palette="Dark2") 

# use graysacle
#Change the gray value at the low and the high ends of the palette :
bp + scale_fill_grey(start = 0.8, end = 0.2) + theme_classic()
```


The ColorBrewer scales are documented online at http://colorbrewer2.org/ and made available in R via the RColorBrewer package. When you have a predefined mapping between values and colours, use scale_colour_manual(). 

`scale_colour_manual(values = c(factor_level_1 = "red", factor_level_2 = "blue")`

`scale_colour_viridis()` provided by the viridis package is a continuous analog of the categorical ColorBrewer scales.


## A complex ggplot

 Let's pretend that we are measuring the same quantity by immunoassay at baseline and after 1 year of storage at -80 degrees. We'll add some heteroscedastic error and create some apparent degradation of about 20%:
 
 


```r
set.seed(10)
baseline <- rlnorm(100, 0, 1)
post <- 0.8 * baseline + rnorm(100, 0, 0.10 * baseline)
my_data <- tibble(baseline, post)
my_data %>% 
  ggplot(aes(baseline, post)) +
  geom_point(shape = 1) + # Use hollow circles
  geom_smooth(method = "lm") + # Add linear regression line 
  geom_abline(slope = 1, intercept = 0, linetype = 2, colour = "red")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-61-1} \end{center}

Now we will prepare the difference data:

```r
diff <- (post - baseline)
diffp <- (post - baseline) / baseline * 100
sd.diff <- sd(diff)
sd.diffp <- sd(diffp)
my.data <- data.frame(baseline, post, diff, diffp)
```

In standard Bland Altman plots, one plots the difference between methods against the average of the methods, but in this case, the x-axis should be the baseline result, because that is the closest thing we have to the truth.


```r
library(ggExtra)
diffplot <- ggplot(my.data, aes(baseline, diff)) + 
  geom_point(size=2, colour = rgb(0,0,0, alpha = 0.5)) + 
  theme_bw() + 
  #when the +/- 2SD lines will fall outside the default plot limits 
  #they need to be pre-stated explicitly to make the histogram line up properly. 
  ylim(mean(my.data$diff) - 3*sd.diff, mean(my.data$diff) + 3*sd.diff) +
  geom_hline(yintercept = 0, linetype = 3) +
  geom_hline(yintercept = mean(my.data$diff)) +
  geom_hline(yintercept = mean(my.data$diff) + 2*sd.diff, linetype = 2) +
  geom_hline(yintercept = mean(my.data$diff) - 2*sd.diff, linetype = 2) +
  ylab("Difference pre and post Storage (mg/L)") +
  xlab("Baseline Concentration (mg/L)")
 
#And now for the magic - we'll use 25 bins
ggMarginal(diffplot, type = "histogram", bins = 25)
```

# Kuraditosin graafikut, mida sa peaksid enne surma joonistama

Andmete plottimisel otsib analüütik tasakaalu informatsioonikao ja trendide/mustrite/kovarieeruvuste nähtavaks tegemise vahel. 
Idee on siin, et teie andmed võivad sisaldada a) juhuslikku müra, b) trende/mustreid, mis teile suurt huvi ei paku ja c) teid huvitavaid varjatud mustreid. 
Kui andmeid on palju ja need on mürarikkad ja kui igavad trendid/mustrid varjavad huvitavaid trende/mustreid, siis aitab vahest andmete graafiline redutseerimine üldisemale kujule ja nende modelleerimine. 
Kui andmeid ei ole väga palju, siis tasuks siiski vältida infot kaotavaid graafikuid ning joonistada algsed või ümber arvutatud andmepunktid. 
Järgnevalt esitame valiku graafikutüüpe erinevat tüüpi andmetele.


## Cleveland plot

x- pidev muutuja; y - faktormuutuja

Seda plotti kasuta a) kui iga muutja kohta on üks andmepunkt või b) kui soovid avaldada keskmise koos usalduspiiridega.

>Sageli lahendatakse sarnased ülesanded tulpdiagrammidega, mis ei ole aga üldiselt hea mõte, sest tulpdiagrammid juhivad asjatult tähelepanu tulpadele endile, pigem kui nende otstele, mis tegelikult andmete keskmist kajastavad. Kuna inimese aju tahab võrrelda tulpade kõrgusi suhtelistes, mitte absoluutsetes ühikutes (kui tulp A on 30% kõrgem kui tulp B, siis me näeme efekti suurust, mis on u 1/3), peavad tulbad algama mingilt oodatavalt baastasemelt (tavaliselt nullist). See aga võib muuta raskeks huvitavate efektide märkamise, kui need on protsentuaalselt väikesed. Näiteks 5%-ne CO2 taseme tõus atmosfääris on teaduslikult väga oluline, aga tulpdiagrammi korrektselt kasutades tuleb vaevu graafikult välja.

Kõigepealt plotime, mitu korda esinevad *diamonds* tabelis erinevate faktormuutuja *clarity* tasemetega teemandid (*clarity* igale tasemele vastab üks number -- selle *clarity*-ga teemantite arv). 


```r
dd <- diamonds %>% 
  group_by(clarity) %>% 
  summarise(number_of_diamonds = n())

dd %>% 
  ggplot(aes(x = number_of_diamonds, 
             y = reorder(clarity, number_of_diamonds))) +
  geom_point(size = 3) +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed")) +
  labs(y = "clarity") +
  theme_bw()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grkurat-1} \end{center}

Graafiku loetavuse huvides on mõistlik Y- telg sorteerida väärtuste järgi.

Järgmisel joonisel on näha *iris* tabeli *Sepal length* veeru keskmised koos 50% ja 95% usaldusintervallidega. Usaldusintervallid annavad hinnangu meie ebakindlusele keskväärtuse (mitte näiteks algandmete) paiknemise kohta, arvestades meie valimi suurust ja sellest tulenevat valimiviga. 50% CI tähendab, et me oleme täpselt sama vähe üllatunud leides tõese väärtuse väljaspoolt intervalli, kui leides selle intervalli seest. 95% CI tähendab, et me oleme mõõdukalt veendunud, et tõene väärtus asub intervallis (aga me arvestame siiski, et ühel juhul 20-st ta ei tee seda). **NB! Need tõlgendused eeldavad, et meie andmetes esinev juhuslik varieeruvus on palju suurem kui seal leiduv suunatud varieeruvus (ehk bias).**  

Kasutame Publish::ci.mean(), et arvutada usaldusintervallid (antud juhul 10% CI)

```r
library(Publish) #siit ci.mean()
a <- rnorm(10)
a1 <- ci.mean(a, alpha = 0.9)
str(a1)
#> List of 6
#>  $ mean     : num 0.151
#>  $ se       : num 0.332
#>  $ lower    : num 0.108
#>  $ upper    : num 0.194
#>  $ level    : num 0.9
#>  $ statistic: chr "arithmetic"
#>  - attr(*, "class")= chr [1:2] "ci" "list"
```

kisume listi elemendi nimega lower (usaldusintervalli alumine piir) välja 3-l alternatiivsel viisil

```r
a1$lower
#> [1] 0.108
a1[[3]]
#> [1] 0.108
a1 %>% pluck("lower")
#> [1] 0.108
```



```r
iris1 <- iris %>% 
  group_by(Species) %>% 
  summarise(Mean = mean(Sepal.Length),
            CI_low_0.5 = ci.mean(Sepal.Length, alpha=0.5) %>% pluck("lower"),
            CI_high_0.5 = ci.mean(Sepal.Length, alpha=0.5) %>% pluck("upper"),
            CI_low_0.95 = ci.mean(Sepal.Length) %>% pluck("lower"),
            CI_high_0.95 = ci.mean(Sepal.Length) %>% pluck("upper")
            )
#pluck() takes a named element out of a list 
#ci.mean() output is a list of 6 elements

ggplot(data = iris1, aes(x = Mean, y = Species)) +
  geom_point(size = 3) +
  geom_errorbarh(aes(xmin = CI_low_0.5, 
                     xmax = CI_high_0.5), 
                 height = 0.2) +
  geom_errorbarh(aes(xmin = CI_low_0.95, 
                     xmax = CI_high_0.95), 
                 height = 0.4) +
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed")) +
  labs(x = "Sepal length with 50% and 95% CI", 
       y = NULL) 
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-66-1} \end{center}


Alternatiivne graafiku kuju (muudetud on ainult geom_point size ja shape parameetreid):

```r
ggplot(data = iris1, aes(x = Mean, y = Species)) +
  geom_point(size = 5, shape = 108) +
  geom_errorbarh(aes(xmin = CI_low_0.5, 
                     xmax = CI_high_0.5), 
                 height = 0, 
                 size = 2) +
  geom_errorbarh(aes(xmin = CI_low_0.95, 
                     xmax = CI_high_0.95), 
                 height = 0.1) +
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed")) +
  labs(x = "Sepal length with 50% and 95% CI", 
       y = NULL) 
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-67-1} \end{center}

CI-d saab arvutada ka käsitsi.
Kui valimi suurus on piisav ja normaaljaotus pole meie andmetest liiga kaugel, siis saame CI arvutamiseks kasutada järgmisi heuristikuid:


\begin{tabular}{r|r}
\hline
CI\_percentage & nr\_of\_SEMs\\
\hline
50.0 & 0.675\\
\hline
75.0 & 1.150\\
\hline
90.0 & 1.645\\
\hline
95.0 & 1.960\\
\hline
97.0 & 2.170\\
\hline
99.0 & 2.575\\
\hline
99.9 & 3.291\\
\hline
\end{tabular}

SEM on standardviga, mille arvutame jagades valimi standardhälbe ruutjuurega valimi suurusest N. 
Kuna CI sõltub SEM-ist, sõltub see muidugi ka N-st, aga mitte lineaarselt, vaid üle ruutjuure. 
See tähendab, et uuringu usaldusväärsuse tõstmine, tõstes N-i kipub olema progressiivselt kulukas protsess.
Analoogiana võib siin tuua sportliku vormi tõstmine, kus trennis käimisega alustades on suhteliselt lihtne tõsta oma sooritust näiteks 20% võrra, aga peale aastast usinat rassimist tuleb juba teha väga tõsine pingutus, et saavutada veel 1% tõusu.


\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-69-1} \end{center}

Nagu näha jooniselt, on meil tegu progresiivselt kallineva ülesandega: mida rohkem tahame usalduspiire kitsamaks muuta **suhteliselt** (mis on sama, mis öelda, et me tahame tõsta katse tundlikust), seda suurema tõusu peame tagama kogutud andmete hulgas **absoluutarvuna**. 

## Andmepunktid mediaani või aritmeetilise keskmisega

x - faktormuutuja; y - pidev muutuja

Kui N < 20, siis on see tavaliselt parim valik sest säilitab maksimaalselt andmetes leiduvat informatsiooni.


```r
ggplot(iris, aes(x=Species, y=Sepal.Length)) + 
  geom_jitter(width = 0.05)+
  stat_summary(fun.y = median, geom = "point", shape = 95, 
               color = "red", size = 15, alpha = 0.6) +
  labs(x = NULL) + 
  theme_tufte()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-70-1} \end{center}

Siin on meil lausa 50 andmepunkti iga Irise liigi kohta ja graafik on ikkagi täitsa hästi loetav. 

Meil on võimalik teha sellest graafikust versioon, mis ei pane andmepunkti y skaalal täpselt õigesse kohta, vaid tekitab histogrammilaadsed andmebinnid, kus siiski iga punkt on eraldi näidatud. See lihtsustab veidi "kirjude" kompleksete andmete esitust, kuid kaotab informatsiooni andmepunktide täpse asukoha kohta. Eesmärk on muuta erinevused gruppide vahel paremini võrreldavaks.


```r
p<-ggplot(iris, aes(x=Species, y=Sepal.Length)) + 
  geom_dotplot(binaxis='y', stackdir='center', stackratio=1.3, dotsize=0.7) 

p + stat_summary(fun.y = median, geom = "point", shape = 95, 
               color = "red", size = 15) 
#try using shape=18, size=5.

#add mean and SD, use pointrange:
p + stat_summary(fun.data=mean_sdl, fun.args = list(mult=1), geom="pointrange", color="red")

#use errorbar instead of pointrange:
#p + stat_summary(fun.data=mean_sdl, fun.args = list(mult=1), geom="errorbar", color="red", width=0.2, size=1) + stat_summary(fun.y=mean, geom="point", size=3, color="red")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-71-1} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-71-2} \end{center}


Muuda punktide värvi nii:

scale_fill_manual() : to use custom colors

scale_fill_brewer() : to use color palettes from RColorBrewer package

scale_fill_grey() : to use grey color palettes


## Histogramm

x - pidev muutuja

Kui teil on palju andmepunkte (>50) ning soovite uurida nende jaotust (ja/või võrrelda mitme andmestiku jaotust) siis tasub kindlasti alustada histogrammist. Histogrammi koostamine näeb välja järgmine:

1. ploti andmepunktid x - teljele (järgnev on põhimõtteliselt ühedimensionaalne plot, kuigi andmepunktid on üksteise suhtes veidi nihutatud, et nad üksteist ei varjutaks). 


```r
stripchart(iris$Sepal.Length, method = "jitter")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-72-1} \end{center}



2. jaga andmestik x-teljel võrdse laiusega vahemikesse (binnidesse)


\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-73-1} \end{center}

3. loe kokku, mitu andmepunkti sattus igasse binni. Näiteks on meil viimases binnis (7.5 ... 8) kuus anmdepunkti
4. ploti iga bin tulpdiagrammina (y- teljel on tüüpiliselt andmepunktide arv)


```r
ggplot(iris, aes(x=Sepal.Length)) + geom_histogram(breaks= seq(4, 8, by=0.5), color="white")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-74-1} \end{center}

Tavaliselt on mõistlik määrata histogrammi binnide laius ja asukoht `breaks` argumeniga. On olemas ka alternatiivsed argumendid `bins`, mis annab binnide arvu, ja `binwidth`, mis annab binni laiuse, aga ohutum on kasutada `breaks`-i. Vt ka geom_boxplot() funktsiooni helpi.

Järnevalt genereerime ühtlase jaotuse 0 ja 1 vahel ning plotime selle kahel histogrammil, millest esimene (halli taustaga) kasutab `bins` argumenti ja teine (sinine) kasutab `breaks` argumenti. 

```r
set.seed(12)
a1 <- tibble(a=runif(200))
ggplot(a1, aes(a)) + 
  geom_histogram(bins = 20, color="white", alpha=0.8, fill="grey")+ 
  geom_histogram(breaks= seq(0,1, by=0.05), color= "navyblue", fill=NA)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-75-1} \end{center}

Pane tähele, et tulemus on küllaltki erinev ja et `breaks` argument töötab korrektselt. Nagu järgnev koodijupp näitab, on meil on 6 väärtust alla 0.05 (1. bin) ja 8 väärtust üle 0.95 (20. bin), mis on korrektselt kajastatud ainult `breaks` argumentdiga histogrammil.

```r
a1 %>% filter(a < 0.05) %>% nrow()
#> [1] 6
a1 %>% filter(a > 0.95) %>% nrow()
#> [1] 8
```

NB! Väga tähtis on mõista, et binnide laius on meie suva järgi määratud. Samade andmete põhjal joonistatud erineva binilaiusega histogrammid võivad anda lugejale väga erinevaid signaale. 


```r
library(gridExtra)
g1 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 3)
g2 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 8)
g3 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 20)
g4 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 50)
grid.arrange(g1, g2, g3, g4, nrow = 2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-77-1} \end{center}

Seega on tasub joonistada samadest andmetest mitu erineva binnilaiusega histogrammi, et oma andmeid vaadata mitme nurga alt.


Kui tahame võrrelda mitmeid jaotusi, siis on meil järgmised variandid:

Kõigepealt, me võime panna mitu histogrammi üksteise alla. Selleks kasutame facet_grid funktsiooni ja paneme joonisele ka hallilt summaarsete andmete histogrammi. Selle funktsioon on pakkuda joonise lugejale ühtset võrdlusskaalat üle kolme paneeli.


```r
d_bg <- iris[, -5]  # Background Data - full without the 5th column (Species)

ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(data = d_bg, fill = "grey", alpha=0.8, bins=10) +
  geom_histogram(colour = "black", bins=10) +
  facet_grid(Species~.) +
  guides(fill = FALSE) +  # to remove the legend
  theme_tufte()          # for clean look overall
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-78-1} \end{center}

Teine võimalus on näidata kõiki koos ühel paneelil kasutades histogrammi asemel sageduspolügoni. See töötab täpselt nagu histogramm, ainult et tulpade asemel joonistatakse binnitippude vahele jooned. Neid on lihtsam samale paneelile üksteise otsa laduda.


```r
ggplot(iris, aes(Sepal.Length, color=Species)) + geom_freqpoly(breaks= seq(4, 8, by=0.5)) + theme_tufte()+ labs(title="Frequency plot")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-79-1} \end{center}

Selle "histogrammi" binne saab ja tuleb manipuleerida täpselt samamoodi nagu geom_histogrammis.

Veel üks hea meetod histogrammide võrdlemiseks on joonistada nn viiuliplot. See asendab sakilise histogrammi silutud joonega ja muudab seega võrdlemise kergemaks. Viiulile on ka kerge lisada algsed andmepunktid


```r
ggplot(iris, aes(Species, Sepal.Length)) + geom_violin(aes(color=Species))+
  geom_jitter(size=0.2, width=0.1) + labs(title="Violin plot", x=NULL)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-80-1} \end{center}

## Tihedusplot

Hea alternatiiv histogrammile on joonistada silutud andmejaotus ehk tihedusplot. Tihedusplotil kajastab iga andmejaotust sujuv funktsioon ehk andmete tihedusjoon, ning kõik jaotused on normaliseeritud samale joonealusele pindalale (iga pindlala = 1, mis muudab selle sisuliselt tõenäosusfunktsiooniks). Seega saame hästi võrrelda erinevate jaotuste kujusid, aga mitte kõrgusi (ehk seda, mitu andmepunkti on mingis bin-is -- selline võrdlus töötab muidugi histogrammi korral). 


```r
ggplot(iris, aes(Sepal.Length, fill=Species)) + geom_density(alpha=0.5)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-81-1} \end{center}

Adjust parameeter reguleerib funktsiooni silumise määra.

\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-82-1} \end{center}

Veel üks võimalus jaotusi kõrvuti vaadata on joyplot, mis paneb samale paneelile kasvõi sada tihedusjaotust. Näiteid vaata ka aadressilt https://cran.r-project.org/web/packages/ggridges/vignettes/gallery.html



```r
library(ggridges)
library(viridis)
```


```r
sch <- read.csv("data/schools.csv")
sch$school <- as.factor(sch$school)

ggplot(sch, aes(x = score1, y = school, group = school)) +
  scale_fill_viridis(name = "score", option = "C") +
  geom_density_ridges(scale = 4, size = 0.25, rel_min_height = 0.05) +
  theme_ridges() 
#> Warning: Removed 202 rows containing non-finite values
#> (stat_density_ridges).

ggplot(sch, aes(x = score1, y = school, group = school, fill = ..x..)) +
  scale_fill_viridis(name = "score", option = "C") +
  geom_density_ridges_gradient(scale = 4, size = 0.25, rel_min_height = 0.05, gradient_lwd = 1) +
  theme_ridges() 
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-84-1} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-84-2} \end{center}


```r
ggplot(mpg, aes(x=hwy, y=manufacturer, color=drv, point_color=drv, fill=drv)) +
  geom_density_ridges(jittered_points=TRUE, scale = .95, rel_min_height = .01,
                      point_shape = "|", point_size = 3, size = 0.25,
                      position = position_points_jitter(height = 0)) +
  scale_y_discrete(expand = c(.01, 0)) +
  scale_x_continuous(expand = c(0, 0), name = "highway fuel consumption [gallons]") +
  theme_ridges(center = TRUE)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-85-1} \end{center}

## Boxplot

See plot mõeldi välja John Tukey poolt arvutieelsel ajastul (1969), ja see võimaldab millimeeterpaberi ja joonlaua abil võrrelda erinevaid jaotusi. Biomeditsiinis sai boxplot ülipopulaarseks veidi hilinenult, ca. 2010-2015. Inimese jaoks, kes oskab arvutit kasutada, võib viiulite joonistamine tunduda atraktiivsem (ja informatiivsem), aga kui võrreldavaid jaotusi on päris palju, siis võib ka boxploti kandiliselt lihtsusel eeliseid leida. Igal juhul käib klassikalise boxploti konstrueerimine järgevalt.

1. joonista andmepunktid 1D-s välja (nagu me tegime histogrammi puhul)

2. keskmine andmepunkt on mediaan. Selle kohale tuleb boxplotil keskmine kriips

3. ümbritse kastiga pooled andmepunktid (mõlemal pool mediaani). Nii määrad nn. interkvartiilse vahemiku (IQR).

4. pooleteistkordne IQR (y-telje suunas) annab meile vurrude maksimaalse pikkuse. Vurrud joonistatakse siiski ainult kuni viimase andmepunktini (aga kunagi mitte pikemad kui 1.5 IQR)

5. andmepunktid, mis jäävad väljaspoole 1.5 x IQR-i joonistatakse eraldi välja kui outlierid.


```r
ggplot(iris, aes(Species, Sepal.Length, color = Species)) + 
  geom_boxplot()+
  geom_jitter(width = 0.1, size=0.1, color="black")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-86-1} \end{center}

Boxplotile saab lisada ka aritmeetilise keskmise (järgnevas punase täpina), aga pea meeles, et boxploti põhiline kasu tuleb sellest, et see ei eelda sümmeetrilist andmejaotust. Seega on mediaani lisamine üldiselt parem lahendus.


```r
ggplot(iris, aes(Species, Sepal.Length, color = Species)) + 
  geom_boxplot()+ stat_summary(fun.y=mean,col='red', geom='point', size=2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-87-1} \end{center}


\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-88-1} \end{center}

See pilt näitab, et kui jaotus on mitme tipuga, siis võib boxplotist olla rohkem kahju kui kasu. 


## Joongraafikud

x - pidev muutuja (aeg, konsentratsioon, jms); y - pidev muutuja; x ja y vahel on deterministlik seos (trend)

Joongraafik (geom_line) töötab hästi siis, kui igale x-i väärtusele vastab unikaalne y-i väärtus ja iga kahe mõõdetud x-i väärtuse vahele jääb veel x-i väärtusi, mida pole küll mõõdetud, aga kui oleks, siis vastaks ka neile unikaalsed y-i väärtused. Lisaks me loodame, et y-i suunaline juhuslik varieeruvus ei ole nii suur, et maskeerida meid huvitavad trendid. 
Kui tahad näidata, kus täpselt muutus toimus, kasuta geom_step funktsiooni.


```r
recent <- economics[economics$date > as.Date("2013-01-01"), ]
ggplot(recent, aes(date, unemploy)) + geom_line()
ggplot(recent, aes(date, unemploy)) + geom_step()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-89-1} \includegraphics{06-graphics_files/figure-latex/unnamed-chunk-89-2} \end{center}

Astmeline graafik on eriti hea olukorras, kus astmete vahel y-dimensioonis muutust ei toimu -- näiteks piimapaki hinna dünaamika poes.

Geom_path võimaldab joonel ka tagasisuunas keerata.


```r
# geom_path lets you explore how two variables are related over time,
# e.g. unemployment and personal savings rate
m <- ggplot(economics, aes(unemploy/pop, psavert))
m + geom_path(aes(colour = as.numeric(date)))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-90-1} \end{center}


Tulpdiagramm juhib lugeja tähelepanu väikestele teravatele muutustele. Kui see on see, millele sa tahad tähelepanu juhtida, siis kasuta seda.

```r
p1 <- ggplot(economics, aes(date, unemploy)) + geom_line()
p2 <- ggplot(economics, aes(date, unemploy)) + geom_bar(stat="identity")
grid.arrange(p1, p2, nrow = 2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-91-1} \end{center}

Et mürarikkaid andmeid siluda kasutame liikuva keskmise meetodit. Siin asendame iga andmepunkti selle andmepunkti ja tema k lähima naabri keskmisega. k on tavaliselt paaritu arv ja mida suurem k, seda silutum tuleb tulemus. 


```r
library(zoo)
economics$rollmean <- rollmean(economics$unemploy, k = 13, fill = NA)
ggplot(economics, aes(date, rollmean)) + geom_line()
#> Warning: Removed 12 rows containing missing values
#> (geom_path).
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-92-1} \end{center}

Kui on oht, et ebahuvitavad tsüklid ja trendid varjutavad veel mingeid mustreid, mis meile võiks huvi pakkuda, võib proovida lahutada aegrea komponentideks kasutades seasonaalset lahutamist (Seasonal decomposition). R::stl() kasutab selleks loess meetodit lahutades aegrea kolmeks komponendiks. 1) trendikomponent püüab keskmise taseme muutusi ajas. 2) seasonaalne komponent lahutab muutused aastaaegade lõikes (konstantse amplituudiga tsüklilisus aegrea piires) ja 3) irregulaarne komponent on see, mis üle jääb. 
aegrea osadeks lahutamine võib olla additiivne või mulitlikatiivne. Additiivses mudelis

$$Y_t = Trend_t + Seasonal_t + Irregular_t$$

summeeruvad komponendid igas punktis algesele aegreale. Muliplikatiivses mudelis

$$Y_t = Trend_t * Seasonal_t * Irregular_t$$ 
tuleb selleks teha korrutamistehe.

Näiteks lahutame aegrea, mis käsitleb CO_2 konsentratsiooni muutusi viimase 50 aasta vältel.



```r
require(graphics)
#co2 is a time series object 
#stl() takes class "ts" objects only!
plot(stl(co2, "per"))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-93-1} \end{center}

Pane tähele graafiku paremas servas asuvaid halle kaste, mis annavad mõõtkava erinevate paneelide võrdlemiseks. Siit näeme, et "remainder" paneeli andmete kõikumise vahemik on väga palju väiksem kui ülemisel paneelil, kus on plotitud täisandmed.


Nüüd esitame versiooni, kus remainder-i andmeid on tugevasti silutud, et võimalikku signaali mürast eristada.

```r
plot(stl(log(co2), s.window = "per", t.window = 199))
# t.window -- the span (in lags) of the loess window for trend extraction, which should be odd.
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-94-1} \end{center}

## Scatter plot

x - pidev muutuja; y -pidev muutuja; x ja y vahel on tõenäosuslik, mitte deterministlik, seos.

Scatter ploti abil otsime oma andmetest trende ja mustreid.

X-teljel on geisri Old Faithful pursete tugevus ja y-teljel pursete vaheline aeg. Kui kahe purske vahel kulub rohkem aega, siis on oodata tugevamat purset. Tundub, et see süsteem töötab kahes diskreetses reziimis.


```r
m <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
  geom_point() +
  xlim(0.5, 6) +
  ylim(40, 110)
m + geom_density_2d()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-95-1} \end{center}

Kui punkte on liiga palju, et välja trükkida, kasuta geom = "polygon" varianti.


```r
m + stat_density_2d(aes(fill = ..level..), geom = "polygon")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-96-1} \end{center}


Nüüd plotime 3 iriseliigi õielehe pikkuse seose tolmuka pikkusega, ja lisame igale liigile mittelineaarse mudelennustuse koos 95% usaldusintervalliga. Mudel püüab ennustada keskmist õielehe pikkust igal tolmuka pikkusel, ja 95% CI kehtib ennustusele keskmisest, mitte üksikute isendite õielehtede pikkustele. 

```r
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) + 
  geom_point() + 
  geom_smooth()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-97-1} \end{center}

See mudeldamine tehti loess meetodiga, mis kujutab endast lokaalselt kaalutud polünoomset regressiooni. Loessi põhimõte on, et arvuti fitib palju lokaalseid lineaarseid osamudeleid, mis on kaalutud selles mõttes, et andmepunktidel, mis on vastavale osamudelile lähemal, on mudeli fittimisel suurem kaal. Nendest osamudelitest silutakse siis kokku lõplik mudel, mida joonisel näete.

Järgmiseks värvime eelnevalt tehtud plotil punktid iirise liigi kaupa aga joonistame ikkagi regressioonisirge läbi kõikide punktide. Seekord on tegu tavapärase lineaarse mudeliga, mis fititud vähimruutude meetodiga (vt ptk ....).

Vaata mis juhtub, kui värvide lahutamine toimub `ggplot()`-i enda `aes()`-s. `theme_classic()` muudab graafiku üldist väljanägemist.


```r
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(aes(color = Species)) + 
  geom_smooth(method = "lm", color = "black") +
  theme_classic()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-98-1} \end{center}

Me võime `geom_smooth()`-i anda erineva andmeseti kui `ggplot()` põhifunktsiooni. 
Nii joonistame me regressioonisirge ainult nendele andmetele.
Proovi ka `theme_bw()`.

```r
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() +
  geom_smooth(data = filter(iris, Species == "setosa"), method = lm) +
  theme_bw()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-99-1} \end{center}

Alljärgnevalt näiteks moodus kuidas öelda, et me soovime regressioonijoont näidata ainult iiriseliikide virginica või versicolor andmetele.


```r
## First we filter only data that we want to use for regressionline
smooth_data <- filter(iris, Species %in% c("virginica", "versicolor"))

## Then we use this filtered dataset in geom_smooth
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() +
  geom_smooth(data = smooth_data, method = "lm")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-100-1} \end{center}

Järgnev kood võimaldab eksplitsiitselt kasutada fititud regressioonikoefitsiente, kasutades regeressioonijoone määramiseks koordinaatteljestikus x-telje lõikumispunkti ja sirge tõusu. Lineaarse mudeli fittimist õpime peatükis ....
Kasuta `geom_abline()`.


```r
## Create plot
p <- ggplot(data = mtcars, aes(x = wt, y = mpg)) + 
  geom_point()

## Fit model and extract coefficients
model <- lm(mpg ~ wt, data = mtcars)
coefs  <- coef(model)

## Add regressionline to the plot
p + geom_abline(intercept = coefs[1], 
                 slope = coefs[2], 
                 color = "red", 
                 linetype = "dashed", 
                 size = 1.5)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-101-1} \end{center}

### Kaalutud lineaarne mudel

Kaalutud lineaarne mudel on viis anda andmepunktidele, mida me tähtsamaks peame (või mis on täpsemalt mõõdetud) suurem kaal. 
Kõigepealt, siin on USA demograafilised andmed `midwest` "ggplot2" library-st erinevate kesk-lääne omavalitsuste kohta (437 omavalitsust).

Me valime `midwest` andmetest välja kolm muutujat: "percwhite", "percbelowpoverty", "poptotal".

```r
midwest_subset <- midwest %>% select(percwhite, percbelowpoverty, poptotal)
```

Me tahame teada, kuidas valge rassi osakaal ennustab vaesust, aga me arvame, et suurematel omavalitsustel peaks selles ennustuses olema suurem kaal kui väiksematel. Sest me arvame, et väikestel omavalitsustel võib olla suurem valimiviga ja need võivad olla mõjutatud meie mudelis kontrollimata teguritest, nagu mõne suure tööandja käekäik.
Selleks lisame `geom_smooth()`-i lisaargumendi "weight". 


```r
ggplot(midwest_subset, aes(percwhite, percbelowpoverty)) +
  geom_point(aes(size = poptotal)) +
  geom_smooth(aes(weight = poptotal), method = lm, size = 1) + 
  geom_smooth(method = lm, color = "red") +
  labs(x = "Percent white", 
       y = "Percent below poverty", 
       caption = "Sinine joon on kaalutud mudel\npunane joon on tavaline mudel ", 
       title = "Vaesusriski seos rassiga")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-103-1} \end{center}

Kaalumine mitte ainult ei muutnud sirge asukohta, vaid vähendas ka ebakindlust sirge tõusu osas.


## Tulpdiagramm 

x - faktormuutuja; y - protsent;
x - faktormuutuja; y - sündmuse esinemiste arv

Tulpdiagramme on hea kasutada kahel viisil: 1. lugemaks üles, mitu korda midagi juhtus ja 2. näitamaks osa tervikust (proportsiooni). 
 

```r
str(diamonds)
#> Classes 'tbl_df', 'tbl' and 'data.frame':	53940 obs. of  10 variables:
#>  $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
#>  $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
#>  $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
#>  $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
#>  $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
#>  $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
#>  $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
#>  $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
#>  $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
#>  $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```


loeb üles, mitu korda esineb iga cut

```r
ggplot(diamonds) + 
  geom_bar(aes(x = cut, fill = cut)) + 
  theme(legend.position="none")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-105-1} \end{center}

Pane tähele, et y-teljel on arv, mitu korda esineb tabelis iga cut. See arv ei ole tabelis muutuja. geom_bar, geom_hist, geom_dens arvutavad plotile uued y väärtused --- nad jagavad andmed binidesse ja loevad üles, mitu andmepunkti sattus igasse bini.

Kui tahad tulpdiagrammi proportsioonidest, mitu korda eineb tabelis igat cut-i, siis tee nii:
  

```r
ggplot(diamonds) + 
  geom_bar(aes(x = cut, y = ..prop.., group = 1))
```

Pane tähele et tulpade omavahelised suhted jäid samaks. Muutus ainult y-telje tähistus.

Edasi lisame eelnevale veel ühe muutuja: clarity. Nii saame üles lugeda kõigi cut-i ja clarity kombinatsioonide esinemise arvu või sageduse. Erinvate clarity tasemete esinemiste arv samal cut-i tasemel on siin üksteise otsa kuhjatud, mis tähendab, et tulpade kõrgus ei muutu võrreldes eelnevaga.


```r
ggplot(diamonds) + 
  geom_bar(aes(x = cut, fill = clarity))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-107-1} \end{center}

Kui me tahame, et cut-i ja clarity kombinatsioonid oleks kastidena ükteise sees, pigem kui üksteise otsa kuhjatud, siis kasutame position = "identity" argumenti. 


```r
ggplot(diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 0.7, position = "identity") 
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-108-1} \end{center}

ka see graafik pole väga lihtne lugeda. Parem viime clarity klassid üksteise kõrvale


```r
ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-109-1} \end{center}

Eelnev on hea viis kuidas võrrelda clarity tasemete esinemis-sagedusi ühe cut-i taseme piires.

Ja lõpuks, position="fill" normaliseerib tulbad, mis muudab selle, mis toimub iga cut-i sees, hästi võrreldavaks. See on hea viis, kuidas võrrelda clarity tasemete proportsioone erinevate cut-i tasemete vahel. 


```r
ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "fill")
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-110-1} \end{center}

Ja lõpetuseks, kui teile miskipärast ei meeldi Cleveland plot ja te tahate plottida tulpdiagrammi nii, et tulba kõrgus vastaks tabeli ühes lahtris olevale numbrile, mitte faktortunnuse esinemiste arvule tabelis, siis kasutage `geom_col()`


```r
df <- tibble(a=c(2.3, 4, 5.2), b=c("A", "B", "C"))
ggplot(df, aes(b, a)) + geom_col()
```

## Residuaalide plot

Alustame lineaarse mudeli fittimisest ja mudeli ennustuse lisamisest algsele andmetabelile. Me fitime polünoomsse mudeli: 

$$Sepal.Length = intercept + b_1 * Petal.Length + b_2 * Petal.Length^2 + b_3 * Petal.Length^3$$ 

Mudeli ennustused keskmisele õielehe pikkusele (Sepal.Length) saame arvutada fikseerides mudeli koefitsiendid nende fititud väärtustega ja andes mudeli valemisse ühtlase rea võimalikke tolmuka pikkusi. Nii saame igale selle rea liikmele vastava ennustuse õielehe keskmisele pikkusele. Selleks teeme ühetulbalise andmeraami pred_matrix, millele lisame abifunktsiooni add_predictions() abil arvutatud mudeli ennustused. Need ilmuvad tabelisse uue tulbana "pred".


```r
library(modelr)
#fit the model
m1 <- lm(Sepal.Length~poly(Petal.Length, 3) , data= iris)

#make prediction matrix (equally spaced non-empirical Petal Length values)
pred_matrix <- tibble(Petal.Length=seq(min(iris$Petal.Length), 
                                       max(iris$Petal.Length), 
                                       length.out= 100))

#add prediction to each value in the prediction matrix
pred_matrix <- add_predictions(pred_matrix, m1)
```

Nii saab mugavalt visualiseerida ka keeruliste mudelite ennustusi. 

```r
ggplot(pred_matrix, aes(x = Petal.Length)) + 
  geom_point(data= iris, aes(y = Sepal.Length)) +
  geom_line(aes(y = pred))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-113-1} \end{center}

Nüüd lisame irise tabelisse residuaalid mugavusfunktsiooni add_residual() abil (tekib tulp "resid"). Residuaal on lihtsalt andmepunkti Sepal.Length väärtus miinus mudeli ennustus.


```r
iris1 <- iris
iris1 <- add_residuals(iris1, m1)
ggplot(iris1, aes(resid)) + geom_density()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-114-1} \end{center}

See plot näitab, et residuaalid on enam vähem 0-i ümber koondunud, aga negatiivseid residuaale paistab veidi enam olevat. 

Tegelik residuaaliplot näeb välja selline:

```r
ggplot(iris1, aes(Petal.Length, resid, color=Species)) + 
  modelr::geom_ref_line(h = 0) +
  geom_point() 
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-115-1} \end{center}



See võimaldab otsustada, kas mudel ennustab võrdselt hästi erinevatel predikrori (Petal.Length) väärtustel. Antud mudelis ei näe me süstemaatilisi erinevusi residuaalides üle õielehtede pikkuste vahemiku. 

Proovime sama lihtsa lineaarse mudeliga $Sepal.Length = intercept + b * Petal.Length$.

\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-116-1} \end{center}



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-117-1} \end{center}

Siit näeme, et I. setosa puhul on residuaalid pigem >0 ja et see mudel töötab paremini I. versicolor ja I. virginica puhul. 

Eelnevatelpiltidel on residuaalid algsetes Sepal Length-i mõõtühikutes (cm). 

Et otsustada, kas üks või teine residuaal on 0-st piisavalt kaugel, avaldame residuaalid standardhälvete ühikutes (nn Studentized residuals).
Residuaalide muster joonisel sellest ei muutu, muutub vaid y-telje tähistus.

```r
iris1 <- mutate(iris1, st_resid=resid/sd(resid))
ggplot(iris1, aes(Petal.Length, st_resid, color=Species)) + 
  geom_ref_line(h = 0) +
  geom_point()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-118-1} \end{center}

Nüüd näeme I. virginica isendit, mille koha pealt mudel ülehindab 3 standardhälbega.

Kumb mudel on parem?

```r
anova(m1, m2)
#> Analysis of Variance Table
#> 
#> Model 1: Sepal.Length ~ poly(Petal.Length, 3)
#> Model 2: Sepal.Length ~ Petal.Length
#>   Res.Df  RSS Df Sum of Sq    F  Pr(>F)    
#> 1    146 19.4                              
#> 2    148 24.5 -2     -5.18 19.5 3.1e-08 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

m1 on selgelt parem (RSS 19 vs 25, p = e-08)




## Tukey summa-erinevuse graafik

Seda gaafikutüüpi tuntakse meditsiinis ka Bland-Altmani graafikuna.
Te sooritate korraga palju paralleelseid mõõtmisi -- näiteks mõõdate mass-spektroskoopiaga 1000 valgu taset. Kui teete seda katset kaks korda (või katse vs. kontroll n korda) ja tahate näha süstemaatilisi erinevusi, siis tasub joonistada summa-erinevuse graafik. See on hea olukordades, kus ei ole vahet, mis läheb x ja mis läheb y teljele (erinevalt regressioonimudelitest ja residuaaliplottidest, kus see on väga tähtis).
Meie graafik on x ja y suhtes sümmeetriline. 

Graafik ise on lihtsalt scatterplot, kus horisontaalsele teljele plotitud x + y väärtused ja vertikaalsele teljele plotitud y - x väärtused. Me lisame ka horisontaalsele teljele 0 - joone, et meil oleks lihtsam oma vaimusilmas efekti suuruste punktipilve tsentreerida. 

Näituseks plottime mass spektroskoopia andmed, kus kahel tingimusel (d10 ja wt) on kummagil tehtud kolm iseseisvat katset. Järgneb tabel df_summary2, kus on 2023 valgu tasemete keskväärtused kahel tingimusel, ning Tukey summa-erinevuse graafik




```r
head(df_summary2, 3)
#> # A tibble: 3 x 3
#> # Groups:   gene [2,023]
#>   gene    d10    wt
#>   <fct> <dbl> <dbl>
#> 1 aaeR   25.6  25.6
#> 2 aas    28.8  28.8
#> 3 accA   33.7  33.6
```


```r
ggplot(df_summary2, aes(x = d10 + wt, y = d10 - wt)) + 
  geom_point(alpha=0.2) + 
  geom_hline(yintercept = 0) + 
  labs(title="Tukey sum-difference graph of mass spectroscopy data", y="d10 - wt (in log2 scale)", x= "d10 + wt (in log2 scale)")+
  theme_tufte()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-122-1} \end{center}

Meil näha on ilusti tsentreeritud keskmised 3st mõõtmisest kahele tingimusele, kus iga punkt vastab ühele valule. x telg annab suhtelised valgukogused log2 skaalas (selles skaalas on originaalandmed) ja y telg annab efekti suuruse (tingimus 1 miinus tingimus 2). 

Me näeme sellelt pildilt, et 

1. mida väiksem on valgu kogus, seda suurema tõenäosusega saame tugeva efekti (mis viitab valimivea rollile, eriti suuremate efektide puhul), 

2. efektipilv on kenasti nullile tsentreeritud (see näitab, et andmete esialgne töötlus on olnud korralik), 

3. enamus valgud ei anna suuri efekte (bioloog ohkab siinkohal kergendatult) ja 

4. positiivse märgiga efektid kipuvad olema suuremad, kui negatiivsed efektid (2.5 ühikuline effektisuurus log2 skaalas tähendab 2**2.5 = 5.7 kordset erinevust katse ja kontrolli vahel).

Proteoomikas on praegu populaarsed MA-fraafikud, kus y-teljel (M) on katse vs kontroll erinevus log2 skaalas ja x-teljel (A) on keskmine tase. 

    Log2 skaala koos lahutamistehtega on mugav sest 
    üks log2 ühik y-teljel vastab kahekordsele efektile 
    (kaks ühikut neljakordsele, kolm ühikut kaheksakordsele, jne) 
    ja 0 vastab ühekordsele ehk null-efektile.

### Vulkaaniplot

Tukey summa-erinevuse graafiku vaene sugulane on vulkaaniplot, kus horisontaalsel teljel on y - x (soovitavalt log2 skaalas) ja vertikaalsel teljel on p väärtused, mis arvutatud kahe grupi võrdluses, kusjuures p väärtused on -log10 skaalas. Vulkaaniplotti tutvustame mitte selle pärast, et seda soovitada, vaid ainult selle tõttu, et seda kasutatakse massiliselt näiteks proteoomika vallas. Vulkaaniplot on tõlgendamise mõttes kolmemõõtmeline ja pigem keeruline, näitlikustades korraga efekti suurust (ES), varieeruvust (sd) ja valimiviga (see sõltub valimi suurusest, aga ka mõõtmisobjekti/valgu tasemest).

Joonistame vulkaani samade andmete põhjal, mida kasutasime Tukey summa-erinevusgraafiku valmistamieks. Me alustame tabeli "df" ettevalmistamisest: d10_1, d10_2 ja d10_3 on kolm iseseisvat katset ja wt_1, wt_2 ja wt_3 on kolm iseseisvat kontrolli. 

```r
head(df, 3)
#>   gene d10_1 d10_2 d10_3 wt_1 wt_2 wt_3
#> 1 rpoC  36.3  36.3  36.4 36.2 36.3 36.4
#> 2 rpoB  36.2  36.3  36.2 36.1 36.3 36.3
#> 3 mukB  32.9  33.0  33.2 32.9 33.1 33.3
```

Me lisame tabelile veeru p väärtustega ja veeru effekti suurustega (ES), kasutades apply() funktsiooni sees tavapärast indekseerimist (vt ptk ...).

```r
df_x <- df[2:7] #numeric variables only
#p values
df$p <- apply(df_x, 1, function(x) t.test(x[1:3], x[4:6])$p.value)
#effect sizes (mean experiment - mean control)
df$ES <- apply(df_x, 1, function(x) mean(x[1:3]) - mean(x[4:6]))

plot <- ggplot(df, aes(ES, -log10(p))) + 
  geom_point(alpha=0.2) + 
  geom_hline(yintercept = -log10(0.05), linetype=2) + #add horizontal line
  geom_vline(xintercept = c(-1, 1), linetype=2)+ #add 2 vertical lines
  labs(x="d10 - wt (in log2 scale)", 
       y= "- log10 of p value", 
       title="volcano plot")+
  theme_tufte()
plot
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-124-1} \end{center}


```r
library(ggrepel) #for geom_text_repel()
d <- df %>% filter(ES > 1 | ES < -1) %>% filter(p < 0.05) #data for text labels
plot + geom_label_repel(data=d, aes(label=gene), cex=2) 
#alternative: geom_text_repel(data=d, aes(label=gene), cex=2)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-125-1} \end{center}


Sellel pildil markeerib horisontaalne punktiirjoon p = 0.05 ja vertikaalsed punktiirid 2-kordse efektisuuruse (üks ühik log2 skaalal; ühekordne ES võrdub sellel skaalal nulliga). Inimesed, kes paremini ei tea, kipuvad vulkaaniplotti tõlgendama nii: kui punkt (loe: valk) asub horisontaalsest joonest kõrgemal ja ei asu kahe vertikaalse joone vahel, siis on tegu "päris" efektiga. Seevastu inimesed, kes teavad, teavad ka seda, et p väärtuste ühekaupa tõlgendamine ei ole sageli mõistlik. 
Iga p väärtus koondab endasse informatsiooni kolmest muutujast: valimi suurus (N), varieeruvus (sd) ja efekti suurus (ES = katse - kontroll). Kuigi me saame vulkaaniplotil asuvaid punkte võrreldes ignoreerida valimi suuruse mõju (kuna me teame, et meil on iga punkti taga 3 + 3 mõõtmist), koondab iga p väärtus endasse infot nii ES kui sd kohta viisil, mida me ei oska hästi üksteisest lahutada (siiski, pane tähele, et horisontaalsel teljel on ES). Me teame, et igas punktis on nii ES kui sd mõjutatud valimiveast, mis on kummagi näitaja suhtes teisest sõltumatu. Seega, igal neljandal valgul on valimiveaga seose topeltprobleem: ülehinnatud ES ja samal ajal alahinnatud sd, mis viib oodatust ohtlikult väiksemale p väärtusele. 

Lisaks, p väärtuse definitsioonist (p on sinu andmete või neist ekstreemsemate andmete tõenäosus tingimusel, et nullhüpotees kehtib) tuleneb, et kui null hüpotees on tõene (tegelik ES = 0), siis on meil täpselt võrdne tõenäosus saada oma p väärtus ükskõik kuhu nulli ja ühe vahele. Seega, nullhüpoteesi kehtimise korral ei sisalda individuaalne p väärtus mitte mingisugust kasulikku informatsiooni. 

Oluline on mõista, et p väärtuse arvutamine toimub nullhüpoteesi all, mis kujutab endast põhimõtteliselt lõpmatu hulga hüpoteetiliste valimite põhjal -- mille N = 3 ja sd = valimi sd -- arvutatud lõpmatu hulga hüpoteetiliste valimikeskmiste jaotust (iga geeni jaoks eraldi arvutatuna). Seega demonstreerib p väärtus statistikat oma kõige abstraktsemas vormis. 

Igal juhul peaks olema siililegi selge, et kui valimi suurus on nõnda väike kui 3, siis valimi põhine sd ega valimi põhine efekti suurus ei ole kuigi usaldusväärsed ennustama tegelikku populatsiooni sd-d ega ES-i! 

Kuidas ikkagi vulkaani tõlgendada?

1. Enamus efektisuuruseid < 2 (see on hea)

2. Enamus p väärtusi > 0.05 (ka hea)

3. vulkaan on pisut ebasümmeetriline -- meil on rohkem positiivseid effekte, kus d10 > wt (see on teaduslikult oluline uudis)

4. Enamus valke, mille p < 0.05, annavad ES < 2. (See viitab, et meil on palju katseid, kus iseseisvate katsete vaheline varieeruvus on väga madal.)

5. Oluline osa valke (võib-olla ca 40%), mille ES > 2, annavad p > 0.05. (Viitab valimivea olulisele osale meie tulemustes.)

6. Enamus kõige suuremate ES-dega valke on üllatavalt kõrge p väärtusega. (Viitab valimivea olulisele osale meie tulemustes.)

Seega ei ole meil ES-i ja p väärtuse vahel selget suhet, kus suurtel efektidel oleks selgelt madalam p väärtus kui väikestel efektidel. Kuna meil pole põhust arvata, et valkudel, millel on suurem ES, on süstemaatiliselt suurem varieeruvus, siis paistab, et meie vulkaan dokumenteerib eelkõige valimivigu, ja seega pigem katse üldist madalat kvaliteeti, kui üksikute efektide "tõelisust". Seega tundub, et tegu on mudavulkaaniga.

Hea küll, joonistame oma vulkaani uuesti p väärtuste põhjal, mis seekord on arvutatud eeldusel, et mõlema grupi (d10 ja wt) varieeruvused on geeni kaupa võrdsed. See tähendab, et kui ES-i arvutamisel on valimi suurus 3 (kolme katse ja kolme kontrolli keskmine), siis sd arvutamisel, mis omakorda läheb p väärtuse arvutamise valemisse, on valimi suurus mõlemale grupile 6.


\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-126-1} \end{center}

Pilt on küll detailides erinev, aga suures plaanis üsna sarnane eelmisega.

## QQ-plot

Kuidas võrrelda kahte jaotust? Kõige lihtsam on joonistada bihistogramm, mis töötab ühtlasi t testi ekslploratoorse analoogina (ei anna ühte numbrit, aga selle eest annab palju parema ülevaate kui t test, kuidas kahe grupi valimid -- kuigi mitte tingimata nende taga olevad populatsioonid -- tegelikult erinevad).


```r
library(Hmisc)
histbackback(iris$Sepal.Length, iris$Sepal.Width)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grqq-1} \end{center}

See bihistogramm, mis küll veidi jaburalt võrdleb 3 Irise liigi tolmukate pikkusi ja laiusi, näitab, et kahe grupi keskmised on selgelt erinevad (ülekate peaaegu puudub), aga et ka jaotused ise erinevad omajagu (tolmukate laiuste jaotus on kitsam ja teravam).

Kuidas aga võrrelda oma andmete jaotust teoreetilise jaotusega, näiteks normaaljaotusega?
Selleks on parim viis kvantiil-kvantiil plot ehk qq-plot. Kvantiil tähendab lihtsalt andmepunktide osakaalu, mis on väiksemad kui mingi etteantud väärtus. Näiteks kvantiil 0.3 (mis on sama, mis 30s protsentiil) tähistab väärtust, millest 30% kogutud andmeid on väiksemad ja 70% on suuremad. Näiteks standartse normaaljaotuse (mean = 0, sd = 1) 0.5-s kvantiil on 0 ja 0.95-s kvantiil on 1.96. 

QQ-plot annab empiiriliste andmete kvantiilid (y teljel) teoreetilise jaotuse kvantiilide vastu (x teljel). Punktide arv graafikul vastab teie andmepunktide arvule. Referentsjoon oma 95% veapiiridega (punased katkendjooned) vastab ideaalsele olukorrale, kus teie andmete jaotus vastab teoreetilisele jaotusele (milleks on enamasti normaaljaotus). 

QQ-plot põõrab eelkõige tähelepanu jaotuste sabadele/õlgadele, mis on OK, sest sabad on sageli probleemiks vähimruutude meetodiga regressioonil. Kui me võrdleme normaaljaotusega paremale kiivas jaotust (*positive skew*), siis tulevad punktid mõlemas servas kõrgemale kui referentsjoon. See juhtub näit Chi-ruut jaotuse korral. Kui meil on paksude õlgadega sümmeetriline jaotus, nagu studenti t, siis tulevad ülemise otsa punktid kõrgemale ja alumise otsa punktid madalamale kui referentsjoon. 

Kõigepealt demonstreerime siiski olukorda, kus meie andmed on normaaljaotusega ja me võrdleme neid teoreetilise lognormaaljaotuse vastu. Võrdluseks saame kasutada kõiki R-s defineeritud jaotusi (distribution = "jaotus").

```r
library(car)
qqPlot(rnorm(100), distribution = "lnorm")
#> [1] 50 20
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-127-1} \end{center}

Proovime erinevaid jaotusi normaaljaotuse vastu. Kõigepealt jaotused:


```r
par(mfrow = c(1, 2))
plot(dnorm(seq(0,6, length.out = 100), 3, 1), main = "normal")
qqPlot(rnorm(100, 3, 1), main = "normal vs normal") #default on vrdls normaaljaotusega.
#> [1] 66  4
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-128-1} \end{center}


```r
par(mfrow = c(1, 2))
plot(dlnorm(seq(0,4, length.out = 100)), main = "log normal") 
qqPlot(rlnorm(100), main = "log normal vs normal")
#> [1] 54 19
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-129-1} \end{center}



```r
par(mfrow = c(1, 2))
plot(dt(seq(-4,4, length.out = 100), df=2), main = "student t") 
qqPlot(rt(100, df=2), main = "students t vs normal")
#> [1] 23 20
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-130-1} \end{center}


```r
par(mfrow = c(1, 2))
plot(c(dnorm(seq(-3,6, length.out = 50)), dnorm(seq(-3,6, length.out = 50), 4, 1)), main = "2 peaked normal") 
qqPlot(c(rnorm(50), rnorm(50, 4,1)), main = "two peaked normal vs normal")
#> [1] 32 48
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-131-1} \end{center}


```r
par(mfrow = c(1, 2))
plot(dunif(seq(0, 1, length=100))) 
qqPlot(runif(100), main = "uniform vs normal") #default on vrdls normaaljaotusega.
#> [1] 92 55
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-132-1} \end{center}


```r
par(mfrow = c(1, 2))
plot(dchisq(seq(0, 2, length=100), df=2)) 
qqPlot(rchisq(100, df=2), main = "chi square vs normal")
#> [1] 26 28
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-133-1} \end{center}


```r
par(mfrow = c(1, 2))
plot(dbeta(seq(0, 1, length=100), 2, 2)) 
qqPlot(rbeta(100, 2, 2), main = "beta vs normal")
#> [1] 100  38
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-134-1} \end{center}


Proovime veel erinevaid jaotusi normaaljaotuse vastu. Kõigepealt jaotused:

```
#> [1] 75 42
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-135-1} \end{center}

Nagu näha, beta jaotus, mis on normaaljaotusest palju laiem, on qq-plotil sellest halvasti eristatav. Erinevus on väga madalatel ja väga kõrgetel kvantiilidel (jaotuste otstes).

Ja exponentsiaalse jaotuse korral:

```r
y <- rexp(100)
par(mfrow=c(1,2))
plot(dexp(seq(0, 5, length=100)), main="exponential distr.") 
qqPlot(y, main = "exponential vs normal")
#> [1] 15 32
par(mfrow=c(1,1))
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-136-1} \end{center}

QQ-plotiga saab võrrelda ka kahte empiirilist jaotust, näiteks Irise liikide tolmukate pikkuste ja tolmukate laiuste jaotusi (vt ka peatüki algusest bihistogrammi). Selle meetodi oluline eelis on, et võrreldavad jaotused võivad olla erineva suurusega (N-ga). Siin kasutame base::R qqplot() funktsiooni.


```r
qqplot(iris$Sepal.Length, iris$Sepal.Width)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-137-1} \end{center}

Nagu näha, erinevad jaotused põhiliselt kõrgemates kvantiilides, kus tolmuka pikkus > 7.5 ja tolmuka laius > 3.6.

car::qqPlot saab kasutada ka lineaarse regressiooni normaalsuseelduse kontrollimiseks. Kui ennustatav y-muutuja on normaaljaotusega, siis peaksid residuaalid olema normaaljaotusega (keskväärtus = 0). Selle normaalsuse määramiseks plotitakse standardiseeritud residuaalid teoreetiliste normalsete kvantiilide vastu. Selleks anname qqPlot() funktsiooni lm mudeliobjekti


```r
m1 <- lm(Sepal.Length~ Sepal.Width + Petal.Width, data = iris)
qqPlot(m1)
#> [1] 107 123
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-138-1} \end{center}




## Heat map 

Heat map asendab tabelis numbrid värvidega, muutes nii keerulised tabelid kiiremini haaratavateks. Samas, inimese aju ei ole kuigi edukas värvitoone pidevate muutujate numbrilisteks väärtusteks tagasi konverteerima, mis tähendab, et heat map võimaldab lugejal kiiresti haarata mustreid andmetes, aga ei võimalda teha täpseid võrdlusi tabeli üksikute lahtrite vahel. 

Kõigepealt lihtne heat map, kus irise tabeli numbrilistes veergudes on asendatud arvud värvitoonidega, aga tabeli üldine kuju ei muutu: 

```r
library(pheatmap)
pheatmap(iris[1:4], fontsize_row = 3, cluster_cols = FALSE, cluster_rows = FALSE)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grheatm-1} \end{center}


Et andmetes leiduvad mustrid paremini välja paistaksid, tasub heat mapil andmed ümber paigutada kasutades näiteks hierarhilist klassifitseerimist. Seega lisanduvad heat mapile ka dendrogrammid.


```r
pheatmap(iris[1:4], fontsize_row = 5)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-139-1} \end{center}

Irise tabel on nüüd mõlemas dimensioonis sorteeritud hierarhilise klasterdamise läbi, mida omakorda kajastab 2 dendrogrammi (üks kummagis tabeli dimensioonis). Dendrogramm mõõdab erinevust/sarnasust. Dendrogrammi lugemist tuleb alustada selle harunenud otstest. Kõigepealt jagab dendrogramm vaatlused paaridesse, misjärel hakkab järk-järgult lähimaid paare klastritesse ühendama kuni lõpuks kõik vaatlused on ühendatud ainsasse klastrisse. Dendrogrammi harude pikkused markeerivad selle kriteerium-statistiku väärtust, mille järgi dendrogramm koostati (siin on palju võimalusi, aga kõige levinum on eukleidiline kaugus). Igal juhul, mida pikem haru, seda suuremat erinevust see kajastab. Me võime igal tasemel tõmmata läbi dendrogrammi joone ja saada just nii palju klastreid, kui palju harunemisi jääb sellest joonest ülespoole. Dendrogrammi harud võivad vabalt pöörelda oma vartel, ilma et see dendrogrammi topograafiat muudaks -- seega on joonisel olev dendrogrammi kuju lihtsalt üks juhuslikult fikseeritud olek paljudest. 


Nüüd me ütleme, et me tahame oma irise liigid ajada täpselt kolme k-means klastrisse.
NB! k-means klustrid on arvutatud hoopis teisel viisil kui eelmisel joonisel olevad hierarhilised klastrid. Siin alustame k = 3 tsentroidist, assigneerime iga andmepunkti oma lähimale tsentroidile, arvutame tsentroidid ümber kui klastri kõikide andmepunktide keskmised, assigneerime uuesti kõik andmepunktid oma tsentroidile ja kordame seda tsüklit näiteks 10 korda. 


```r
a <- pheatmap(iris[1:4], kmeans_k = 3)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-140-1} \end{center}

Lisame klastrid irise tabelisse ja vaatame, kui hästi klastrid tabavad kolme irise liiki:


```r
iris$cluster <- a$kmeans$cluster
table(iris$Species, iris$cluster)
#>             
#>               1  2  3
#>   setosa     33 17  0
#>   versicolor  0  4 46
#>   virginica   0  0 50
```

Ja sama graafiliselt:

```r
ggplot(iris, aes(factor(cluster), Species)) + geom_count()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-142-1} \end{center}

Või alternatiivina esitatuna tulpade pikkustena mosaiikgraafikul (tulpade pikkusi on lihtsam võrrelda kui pindalasid eelmisel graafikul):

```r
library(vcd)
iris_x <- iris %>% select(Species, cluster)
iris_x$cluster <- as.factor(iris_x$cluster)
mosaic(~Species + cluster, data= iris_x, shade=T, legend=FALSE)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-143-1} \end{center}

### Korrelatsioonimaatriksid heat mapina

Heat map on ka hea viis visualiseerida korrelatsioonimaatrikseid.

Kõigepealt tavaline scatterplot maatriks.

```r
plot(iris[1:4], col=iris$Species)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grcorr-1} \end{center}

Seejärel korrogramm, kus diagonaalist allpool tähistavad värvid korrelatsioone ja diagonaalist ülalpool on samad korrelatsioonid numbritega. Me sorteerime mustrite parema nägemise huvides ka andmetulbad ümber (order=TRUE), seekord kasutades selleks peakomponent analüüsi (PCA).

```r
library(corrgram)
corrgram(iris[1:4], order = TRUE, lower.panel=corrgram::panel.shade,
         upper.panel=panel.cor, diag.panel=panel.density)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-144-1} \end{center}

### Paraleelkoordinaatgraafik

Alternatiivne võimalus on scatterplot maatriksile on joonistada grrafik läbi paraleelsete koordinaatide. 


```r
library(MASS)
parcoord(iris[1:4], col = iris$Species, var.label = TRUE, lwd = 1)
par(xpd = TRUE)
legend(x = 1.75, y = -.25, cex = 1,
   legend = as.character(levels(iris$Species)),
    fill = unique(iris$Species), horiz = TRUE)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-145-1} \end{center}

Siit näeme, kuidas Petal length ja Petal width on parim viis, et setosat teistest eristada.

### Korrelatsioonid võrgustikuna

Võrgustik koosneb sõlmedest ja nende vahel olevatest servadest (nodes and edges). Meie eesmärk on joonisel näidata sõlmedena ainult need muutujaid, millel esineb mingist meie poolt etteantud numbrist suurem korrelatsioon mõne teise muutujaga. Korrelatsioone endid tähistavad võrgu servad. Järgnevasse voogu, kuhu sisestame kogu mtcars tabeli, lähevad ainult numbrilised muutujad (faktormuutujad tuleb tabelist välja visata).


```r
library(corrr)
library(igraph)
library(ggraph)

tidy_cors <- mtcars %>% 
  correlate() %>% 
  stretch()

# Convert correlations stronger than some value
# to an undirected graph object
graph_cors <- tidy_cors %>% 
  filter(abs(r) > 0.6) %>% 
  graph_from_data_frame(directed = FALSE)

# Plot
ggraph(graph_cors) +
  geom_edge_link(alpha=0.2) +
  geom_node_point() +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_graph()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-146-1} \end{center}

Siin on tabeli mtcars kõik korrelatsioonid, mis on suuremad kui absoluutväärtus 0.6-st.

Kenam (ja informatiivsem) versioon eelmisest on

```r
ggraph(graph_cors) +
  geom_edge_link(aes(edge_alpha = abs(r), edge_width = abs(r), color = r)) +
  guides(edge_alpha = "none", edge_width = "none") +
  geom_node_point(color = "white", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-147-1} \end{center}

Nipp! Kui teile ei meeldi võrgustiku üldine kuju, jooksutage koodi uuesti -- vähegi keerulisemad võrgud tulevad iga kord ise kujuga (säilitades siiski sõlmede ja servade kontaktid).

## Biplot ja peakomponentanalüüs

Kui teil on andmetes rohkem dimensioone, kui te jõuate plottida, siis peakomponentanalüüs (PCA) on üks võimalus multidimensionaalseid andmeid kahedimensionaalsena joonistada. PCA on lineaarne meetod, mis püüab omavahel korrelleeritud muutujad aesendada uute muutujatega, mis oleks võimalikult vähe korrelleeritud. PCA joonise teljed (peakomponent 1 ja peakomponent 2) on valitud nii, et need oleks üksteisega võimalikult vähe korreleeritud ja samas säiliks võimalikult suur osa andmete algsest multidimensionaalsest varieeruvusest. Eesmärk on saavutada 2D (või 3D) muster, mis oleks võimalikult lähedane algse multi-D mustriga. Seega, PCA projitseerib multidimensionaalse andmemustri 2D pinnale viisil, mis püüab säilitada maksimaalse osa algsest andmete varieeruvusest. PCA teeb seda, kasutades lineaarset additiivset mudelit. 

See analüüs on mõistlik ainult siis, kui andmed varieeruvad kõige rohkem suunas, mis on ka teaduslikult oluline (ei ole juhuslik müra) ja muutujate vahel ei ole mittelineaarseid interaktsioone (muutujad on sõltumatud). Te ei tea kunagi ette, kas ja millal PCAst võib kasu olla reaalsete mustrite leidmisel -- seega tuleks PCA tõlgendamisega olla pigem ettevaatlik, sest inimaju on suuteline mustreid nägema ka seal, kus neid ei ole. Lisaks, isegi kui PCAs ilmuv muster on ehtne, on PCA dimensioone sageli palju raskem teaduslikult tõlgendada kui originaalseid muutujaid.


```r
library(ggbiplot)
ir.species <- iris[, 5]
ir.pca <- prcomp(iris[,1:4], center = TRUE, scale = TRUE) 
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, 
              groups = iris$Species, ellipse = TRUE, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '') + theme_tufte()
print(g)
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/grbb-1} \end{center}

Seega taandasime 4D andmestiku 2D-sse, säilitades seejuurse suure osa algsest andmete varieeruvusest (esimene pekomponent sisaldab 73% algsest varieeruvusest ja 2. peakomponent 23%). Punkidena on näidatud irise isendid, mis on värvitud liigi järgi, ja lisaks on antud vektorid, mis näitavad, millised algsetest muutujatest korreleeruvad millise peakomponendiga. Siit näeme, et Petal.Length, Petal.Width ja Sepal.Width-i varieeruvus kajastub valdavas enamuses PC1 teljel (vektorid on PC1 teljega enam-vähem paralleelsed) ja et Sepal-Width muutuja varieeruvus kajastub suures osas PC2 teljel. 

### t-sne

Populaarne mittelineaarne viis multidimensionaalsete andmete 2D-sse redutseerimiseks on t-sne (t-Distributed Stochastic Neighbor Embedding), mis vaatab andmeid lokaalselt (mitte kogu andmeruumi tervikuna). Parameeter perplexity tuunitakse kasutaja poolt ja see määrab tasakaalu, millega algoritm vaatab andmeid lokaalselt ja globaalselt. Väiksem perplexity tõstab lokaalse vaatluse osakaalu. Perplexity annab hinnangu, mitu lähimat naabrit igal andmepunktil võiks olla. Üldiselt on soovitus jooksutada t-sne algoritmi mitu korda varieerides perplexity-d 5 ja 50 vahel. 
Enne selle meetodi kasutamist loe kindlasti https://distill.pub/2016/misread-tsne/




```r
library(tsne)
ts <- tsne(iris[1:4], perplexity = 10)
ts <- as_tibble(ts)#output is a table of 2D t-sne coordinates
ism1 <- bind_cols(iris, ts)
ggplot(ism1, aes(x = V1, y = V2, color = (Species))) + 
  geom_point()
```



\begin{center}\includegraphics{06-graphics_files/figure-latex/unnamed-chunk-148-1} \end{center}

# Üldised jooniste printsiibid

Kõigepealt, joonise tüüp peaks vastama joonise sõnumile - sõnasta järeldus, mille sa oma joonise pealt teed. Kas mõni teine joonise tüüp illustreerib seda järeldust paremini/on ühemõttelisem/kiiremini loetav?

1. optimaalne data ink/non-data ink suhe.

2. Joonisel on rõhutatud/silmapaistvad need data ink-i elemendid, mis on ka teaduslike tulemuste seisukohalt kõige olulisemad.

3. data ink on silmatorkavam kui näiteks teljed ja abijooned

4. Kasuta nooli, et juhtida tähelepanu olulistele tulemustele (suuna joonise lugeja tähelepanu).

5. kui võimalik, pane andmete tähised (kirjad) otse joonisele - niikaua kui see muudab joonise kiiremini loetavaks.

6. Ära kuhja joonist üle - keskendu oluliste tulemuste visualiseerimisele. 
