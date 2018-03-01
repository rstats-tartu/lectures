

# Graafilised lahendused

R-s on kaks olulisemat graafikasüsteemi mida võib vaadata nagu kaht eraldi keelt mis mõlemad elavad R keele sees. 

- **Baasgraafika** võimaldab väga lihtsate vahenditega teha kiireid ja suhteliselt ilusaid graafikuid. 
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
library(ggjoy)
library(wesanderson)
```

## Baasgraafika

Kõigepealt laadime tabeli, mida me visuaalselt analüüsima hakkame:

```r
iris <- as_tibble(iris)
iris
#> # A tibble: 150 x 5
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#>          <dbl>       <dbl>        <dbl>       <dbl>
#> 1         5.10        3.50         1.40       0.200
#> 2         4.90        3.00         1.40       0.200
#> 3         4.70        3.20         1.30       0.200
#> 4         4.60        3.10         1.50       0.200
#> 5         5.00        3.60         1.40       0.200
#> 6         5.40        3.90         1.70       0.400
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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-4-1.svg" width="70%" style="display: block; margin: auto;" />

Kui te annate ette ühe pideva muutuja:

```r
plot(iris$Sepal.Length)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-5-1.svg" width="70%" style="display: block; margin: auto;" />

Nüüd on tulemuseks graafik, kus on näha mõõtmisete rea (ehk tabeli) iga järgmise liikme (tabeli rea) väärtus. 
Siin on meil kokku 150 mõõtmist muutujale `Sepal.Length`.


Alternatiiv sellele vaatele on `stripchart()`

```r
stripchart(iris$Sepal.Length)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-6-1.svg" width="70%" style="display: block; margin: auto;" />

Enam lihtsamaks üks joonis ei lähe!


Mis juhtub, kui me x-teljele paneme faktortunnuse ja y-teljele pideva tunnuse?

```r
plot(iris$Species, iris$Sepal.Length)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-7-1.svg" width="70%" style="display: block; margin: auto;" />

Vastuseks on boxplot. Sama graafiku saame ka nii: 

```r
boxplot(iris$Sepal.Length ~ iris$Species).
```

Siin on tegu R-i mudeli notatsiooniga: y-telje muutuja, tilde, x-telje muutuja. Tilde näitab, et y sõltub x-st stohhastiliselt, mitte deterministlikult. Deterministliku seost tähistatakse võrdusmärgiga (=).

Aga vastupidi?

```r
plot(iris$Sepal.Length, iris$Species)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-9-1.svg" width="70%" style="display: block; margin: auto;" />

Pole paha, see on üsna informatiivne scatterplot.

Järgmiseks kahe pideva muutuja scatterplot, kus me veel lisaks värvime punktid liikide järgi.

```r
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-10-1.svg" width="70%" style="display: block; margin: auto;" />

Ja lõpuks tõmbame läbi punktide punase regressioonijoone: 

```r
plot(iris$Sepal.Length, iris$Sepal.Width)
model <- lm(iris$Sepal.Width ~ iris$Sepal.Length)
abline(model, col = "red", lwd = 2)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-11-1.svg" width="70%" style="display: block; margin: auto;" />

"lwd" parameeter reguleerib joone laiust. 
`lm()` on funktsioon, mis fitib sirge vähimruutude meetodil.

Mis juhtub, kui me anname `plot()` funktsioonile sisse kogu irise tibble?

```r
plot(iris, col = iris$Species)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-12-1.svg" width="70%" style="display: block; margin: auto;" />

Juhhei, tulemus on paariviisiline graafik kõigist muutujate kombinatsioonidest.

Ainus  mitte-plot verb, mida baasgraafikas vajame, on `hist()`, mis joonistab histogrammi.

```r
hist(iris$Sepal.Length)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-13-1.svg" width="70%" style="display: block; margin: auto;" />

Histogrammi tegemiseks jagatakse andmepunktid nende väärtuste järgi bin-idesse ja plotitakse igasse bin-i sattunud andmepunktide arv. 
Näiteks esimeses bin-is on "Sepal.Length" muutuja väärtused, mis jäävad 4 ja 4.5 cm vahele ja selliseid väärtusi on kokku viis. 
Histogrammi puhul on oluline teada, et selle kuju sõltub bin-ide laiusest.
Bini laiust saab muuta kahel viisil, andes ette bin-ide piirid või arvu:

```r
hist(iris$Sepal.Length, breaks = seq(4, 9, by = 0.25))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-14-1.svg" width="70%" style="display: block; margin: auto;" />

või

```r
hist(iris$Sepal.Length, breaks = 15)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-15-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-16-1.svg" width="70%" style="display: block; margin: auto;" />

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
Tõenäoliselt on ggplot hetkel kättesaadavatest graafikasüsteemidest parim (kaasa arvates tasulised programmid!).

ggploti töövoog on järgmine, minimaalselt pead ette andma kolm asja: 

1. **andmed**, mida visualiseeritakse, 

2. `aes()` funktsiooni, mis määrab, milline muutuja läheb x-teljele ja milline y-teljele, ning 

3. **geom**, mis määrab, mis tüüpi visualiseeringut sa tahad. 


Lisaks määrad sa `aes()`-is, kas ja kuidas sa tahad grupeerida pidevaid muutujaid faktori tasemete järgi.


Kõigepealt suuname oma andmed `ggplot()` funktsiooni:

```r
ggplot(iris)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-17-1.svg" width="70%" style="display: block; margin: auto;" />

Saime tühja ploti. 
Erinevalt baasgraafikast, ggplot-i puhul ainult andmetest ei piisa, et graafik valmis joonistataks.
Vaja on lisada kiht-kihilt instruktsioonid, kuidas andmed graafikule paigutada ja missugust graafikutüüpi visualiseerimiseks kasutada.

Nüüd ütleme, et x-teljele pannakse "Sepal.Length" ja y-teljele "Sepal.Width" andmed.
Pane siin tähele, et me suuname kõigepealt selle ploti objekti p ja alles siis trükime selle ggplot objekti välja.
Antud näites, lisame edaspidi graafika kihte sellele ggplot objektile.

```r
p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))
p
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-18-1.svg" width="70%" style="display: block; margin: auto;" />

Aga graafik on ikka tühi sest me pole ggplotile öelnud, millist visualiseeringut me tahame. 
Teeme seda nüüd ja lisame andmepunktid kasutades `geom_smooth`-i ja lineaarse regressioonijoone kasutades `geom_smooth` funktsiooni koos argumendiga `method = "lm"`.
Ka nüüd täiendame ggplot objekti p uute kihtidega:

```r
p <- p + geom_point() + geom_smooth(method = "lm")
p
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-19-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-20-1.svg" width="70%" style="display: block; margin: auto;" />

Vertikaalseid sirgeid saab lisada `geom_vline()` abil, näiteks vertikaalne sirge asukohas x = 3:

```r
# Add a vertical line at x = 3
p + geom_vline(xintercept = 3)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-21-1.svg" width="70%" style="display: block; margin: auto;" />

### Segmendid ja nooled 

"ggplot2" funktsioon `geom_segment()` lisab joonejupi, mille algus ja lõpp on ette antud.


```r
# Add a vertical line segment
p + geom_segment(aes(x = 4, y = 15, xend = 4, yend = 27))

# Add horizontal line segment
p + geom_segment(aes(x = 2, y = 15, xend = 3, yend = 15))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-22-1.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-22-2.svg" width="70%" style="display: block; margin: auto;" />

Saab joonistada ka **nooli**, kasutades arumenti "arrow" funktsioonis `geom_segment()`


```r
p + geom_segment(aes(x = 5, y = 30, xend = 3.5, yend = 25),
                 arrow = arrow(length = unit(0.5, "cm")))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-23-1.svg" width="70%" style="display: block; margin: auto;" />


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-24-1.svg" width="70%" style="display: block; margin: auto;" />

Järgneval graafikul muudame joonetüüpi automaatselt muutuja sex taseme järgi:

```r
# Change line types + colors
ggplot(meals, aes(x = time, y = bill, group = sex)) +
  geom_line(aes(linetype = sex, color = sex)) +
  geom_point(aes(color = sex)) +
  theme(legend.position = "top")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-25-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-26-1.svg" width="70%" style="display: block; margin: auto;" />


### Punktide tähistamise trikid

`aes()` töötab nii `ggplot()` kui `geom_` funktsioonides.

```r
ggplot(iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, size = Petal.Length, color = Species))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-27-1.svg" width="70%" style="display: block; margin: auto;" />

Kui me kasutame color argumenti `aes()`-st väljaspool, siis värvime kõik punktid sama värvi.

```r
ggplot(iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, size = Petal.Length), color = "red")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-28-1.svg" width="70%" style="display: block; margin: auto;" />


Kasulik trikk on kasutada mitut andmesetti sama ploti tegemiseks. 
Uus andmestik -- "mpg" -- on autode kütusekulu kohta.

```r
head(mpg, 2)
#> # A tibble: 2 x 11
#>   manufacturer model displ  year   cyl trans     drv  
#>   <chr>        <chr> <dbl> <int> <int> <chr>     <chr>
#> 1 audi         a4     1.80  1999     4 auto(l5)  f    
#> 2 audi         a4     1.80  1999     4 manual(m… f    
#> # ... with 4 more variables: cty <int>, hwy <int>,
#> #   fl <chr>, class <chr>

best_in_class <- mpg %>%
  group_by(class) %>%
  top_n(1, hwy)

head(best_in_class)
#> # A tibble: 6 x 11
#> # Groups:   class [2]
#>   manufacturer model    displ  year   cyl trans  drv  
#>   <chr>        <chr>    <dbl> <int> <int> <chr>  <chr>
#> 1 chevrolet    corvette  5.70  1999     8 manua… r    
#> 2 chevrolet    corvette  6.20  2008     8 manua… r    
#> 3 dodge        caravan…  2.40  1999     4 auto(… f    
#> 4 dodge        caravan…  3.00  1999     6 auto(… f    
#> 5 dodge        caravan…  3.30  2008     6 auto(… f    
#> 6 dodge        caravan…  3.30  2008     6 auto(… f    
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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-30-1.svg" width="70%" style="display: block; margin: auto;" />

Lõpuks toome graafikul eraldi välja nende parimate autode mudelite nimed. 
Selleks kasutame "ggrepel" raamatukogu funktsiooni `geom_label_repel()`.

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))+
  geom_point(size = 3, shape = 1, data = best_in_class) +
  geom_label_repel(aes(label = model), data = best_in_class, cex = 2)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-31-1.svg" width="70%" style="display: block; margin: auto;" />

## _Facet_ -- pisigraafik

Kui teil on mitmeid muutujaid või nende alamhulki, on teil kaks võimalust.

1. grupeeri pidevad muutujad faktormuutujate tasemete järgi ja kasuta color, fill, shape, size alpha parameetreid, et erinevatel gruppidel vahet teha.

2. grupeeri samamoodi ja kasuta facet-it, et iga grupp omaenda paneelile panna.

 

```r
# here we separate different classes of cars into different colors
p <- ggplot(mpg, aes(displ, hwy)) 
p + geom_point(aes(colour = class))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-32-1.svg" width="70%" style="display: block; margin: auto;" />



```r
p + geom_point() + 
  facet_wrap(~ class)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-33-1.svg" width="70%" style="display: block; margin: auto;" />


```r
p + geom_point() +
  facet_wrap(~ class, nrow = 2)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-34-1.svg" width="70%" style="display: block; margin: auto;" />

Kui me tahame kahe muutuja kõigi kombinatsioonide vastu paneele, siis kasuta `facet_grid()` funktsiooni.

```r
p + geom_point() +
  facet_grid(drv ~ cyl)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-35-1.svg" width="70%" style="display: block; margin: auto;" />

- "drv" -- drive - 4(-wheel), f(orward), r(ear).
- "cyl" -- cylinders - 4, 5, 6, or 8.

Kasutades punkti `.` on võimalik asetada kõik alamgraafikud kõrvuti `(. ~ var)` või üksteise peale `(var ~ .)`.


```r
p + geom_point() +
  facet_grid(. ~ drv)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-36-1.svg" width="70%" style="display: block; margin: auto;" />


```r
p + geom_point() +
  facet_grid(drv ~ .)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-37-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-39-1.svg" width="70%" style="display: block; margin: auto;" />

## Teljed
### Telgede ulatus

Telgede ulatust saab määrata kolmel erineval viisil

1. filtreeri andmeid, mida plotid

2. pane x- ja y-teljele piirangud `xlim()`, `ylim()`

3. kasuta `coord_cartesian()` ja xlim, ylim on parameetrid selle sees: `coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))`

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-40-1.svg" width="70%" style="display: block; margin: auto;" />

2. Logaritmi andmed `aes()`-s.


```r
ggplot(cars, aes(x = log2(speed), y = log2(dist))) + 
  geom_point() +
  ggtitle("Andmed ja teljed on logaritmitud")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-41-1.svg" width="70%" style="display: block; margin: auto;" />

3. Andmed on logaritmitud, aga teljed mitte.


```r
ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point() + 
  coord_trans(x = "log2", y = "log2") + 
  ggtitle("Andmed on logaritmitud, aga teljed mitte")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-42-1.svg" width="70%" style="display: block; margin: auto;" />


### Pöörame graafikut 90 kraadi



```r
ggplot(iris, mapping = aes(x = Species, y = Sepal.Length)) + 
  geom_boxplot() +
  coord_flip()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-43-1.svg" width="70%" style="display: block; margin: auto;" />



### Muudame telgede markeeringuid

Muudame y-telje markeeringut:

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5)) +
  ggtitle("y-telje markeeringud\n15 kuni 40, viieste vahedega")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-44-1.svg" width="70%" style="display: block; margin: auto;" />

Muudame x-telje markeeringute nurka muutes `theme()` funktsiooni argumenti "axis.text.x":

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-45-1.svg" width="70%" style="display: block; margin: auto;" />

Eemaldame telgede markeeringud, ka läbi `theme()` funktsiooni:

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  theme(axis.text = element_blank())
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-46-1.svg" width="70%" style="display: block; margin: auto;" />

Muudame teljemarkeeringute järjekorda

```r
p <- ggplot(iris, aes(Species, Sepal.Length)) + geom_boxplot()
p
p + scale_x_discrete(breaks=c("versicolor", "setosa"))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-47-1.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-47-2.svg" width="70%" style="display: block; margin: auto;" />

Muuda teljemarkeeringuid ja kustuta telje nimi.


```r
p + scale_x_discrete(labels=c("setosa" = "sp 1", "versicolor" = "sp2"), name=NULL)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-48-1.svg" width="70%" style="display: block; margin: auto;" />



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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-49-1.svg" width="70%" style="display: block; margin: auto;" />

Eemaldame telgede nimed:

```r
p + theme(axis.title = element_blank())
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-50-1.svg" width="70%" style="display: block; margin: auto;" />


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-51-1.svg" width="70%" style="display: block; margin: auto;" />

`ggtitle()`  annab graafikule pealkirja

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-56-1.svg" width="70%" style="display: block; margin: auto;" />


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-58-1.svg" width="70%" style="display: block; margin: auto;" />


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-62-1.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-62-2.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-62-3.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-62-4.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-62-5.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-62-6.svg" width="70%" style="display: block; margin: auto;" />


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-65-1.svg" width="70%" style="display: block; margin: auto;" />

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

We can also obviously do the percent difference.
 

```r
diffplotp <- ggplot(my.data, aes(baseline, diffp)) + 
  geom_point(size = 2, colour = rgb(0, 0, 0, alpha = 0.5)) + 
  theme_bw() + 
  geom_hline(yintercept = 0, linetype = 3) +
  geom_hline(yintercept = mean(my.data$diffp)) +
  geom_hline(yintercept = mean(my.data$diffp) + 2 * sd.diffp, linetype = 2) +
  geom_hline(yintercept = mean(my.data$diffp) - 2 * sd.diffp, linetype = 2) +
  labs(x = "Baseline Concentration (mg/L)",
       y = "Difference pre and post Storage (%)")

ggMarginal(diffplotp, type = "histogram", bins = 25)
```

# Kümme olulisimat graafikutüüpi

Andmete plottimisel otsib analüütik tasakaalu informatsioonikao ja trendide/mustrite/kovarieeruvuste nähtavaks tegemise vahel. 
Idee on siin, et teie andmed võivad sisaldada a) juhuslikku müra, b) trende/mustreid, mis teile suurt huvi ei paku ja c) teid huvitavaid varjatud mustreid. 
Kui andmeid on palju ja need on mürarikkad ja kui igavad trendid/mustrid varjavad huvitavaid trende/mustreid, siis aitab vahest andmete graafiline redutseerimine üldisemale kujule ja nende modelleerimine. 
Kui andmeid ei ole väga palju, siis tasuks siiski vältida infot kaotavaid graafikuid ning joonistada algsed või ümber arvutatud andmepunktid. 
Järgnevalt esitame valiku graafikutüüpe erinevat tüüpi andmetele.


## Cleveland plot

x- pidev muutuja; y - faktormuutuja

Seda plotti kasuta a) kui iga muutja kohta on üks andmepunkt või b) kui soovid avaldada keskmise koos usalduspiiridega.

>Sageli lahendatakse sarnased ülesanded tulpdiagrammidega, mis ei ole aga üldiselt hea mõte, sest tulpdiagrammid juhivad asjatult tähelepanu tulpadele endile, pigem kui nende otstele, mis tegelikult andmete keskmist kajastavad. Kuna inimese aju tahab võrrelda tulpade kõrgusi suhtelistes, mitte absoluutsetes ühikutes (kui tulp A on 30% kõrgem kui tulp B, siis me näeme efekti suurust, mis on u 1/3), peavad tulbad algama mingilt oodatavalt baastasemelt (tavaliselt nullist). See aga võib muuta raskeks huvitavate efektide märkamise, kui need on protsentuaalselt väikesed. Näiteks 5%-ne CO2 taseme tõus atmosfääris on teaduslikult väga oluline, aga tulpdiagrammi korrektselt kasutades tuleb vaevu graafikult välja.

Kõigepealt plottime, mitu korda esinevad diamond tabelis erinevate faktormuutuja clarity tasemetega teemandid (clarity igale tasemele vastab üks number -- selle clarity-ga teemantite arv). 


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-69-1.svg" width="70%" style="display: block; margin: auto;" />

Graafiku loetavuse huvides on mõistlik on Cleveland plotil Y- telg sorteerida väärtuste järgi.

Järgmisel joonisel on näha irise tabeli Sepal length veeru keskmised koos 50% ja 95% usaldusintervallidega. Usaldusintervallid annavad hinnangu meie ebakindlusele keskväärtuse (mitte näiteks algandmete) paiknemise kohta, arvestades meie valimi suurust ja sellest tulenevat valimiviga. 50% CI tähendab, et me oleme täpselt sama vähe üllatunud leides tõese väärtuse väljaspoolt intervalli, kui leides selle intervalli seest. 95% CI tähendab, et me oleme mõõdukalt veendunud, et tõene väärtus asub intervallis (aga me arvestame siiski, et ühel juhul 20-st ta ei tee seda). **NB! Mõlemad tõlgendused eeldavad (vähemalt senikaua, kuni me kasutame ad hoc lahendusi), et meie andmetes esinev juhuslik varieeruvus on palju suurem kui seal leiduv suunatud varieeruvus (ehk bias).**  


```r
iris1 <- iris %>% 
  group_by(Species) %>% 
  summarise(Mean = mean(Sepal.Length), 
            SEM = sd(Sepal.Length) / sqrt(nrow(iris)))

ggplot(data = iris1, aes(x = Mean, y = Species)) +
  geom_point(size = 3) +
  geom_errorbarh(aes(xmin = Mean - 0.675 * SEM, xmax = Mean + 0.675 * SEM), height = 0.2) +
  geom_errorbarh(aes(xmin = Mean - 1.96 * SEM, xmax = Mean + 1.96 * SEM), height = 0.4) +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed")) +
  labs(x = "Sepal length with 50% and 95% CI", 
       y = NULL) +
  theme_bw()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-70-1.svg" width="70%" style="display: block; margin: auto;" />

Alternatiivne graafiku kuju:

```r
ggplot(data = iris1, aes(x = Mean, y = Species)) +
  geom_point(size = 5, shape = 108) +
  geom_errorbarh(aes(xmin = Mean - 0.675*SEM, xmax = Mean + 0.675*SEM), height = 0, size = 2) +
  geom_errorbarh(aes(xmin = Mean - 1.96*SEM, xmax = Mean + 1.96*SEM), height = 0.1) +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed"))+
  labs(x = "Sepal length with 50% and 95% CI", 
       y = NULL) +
  theme_bw()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-71-1.svg" width="70%" style="display: block; margin: auto;" />

Pane tähele, et siin on usaldusintervallide arvutamiseks kasutatud mugavat *ad hoc* meetodit, mis eeldab muuhulgas, et valimi suurus ei ole väike. 
Kui n < 30, või kui valimi andmejaotus on väga kaugel normaaljaotusest (jaotus on näiteks väga pika õlaga), soovitame usaldusintervalli arvutamiseks kasutada bayesiaanlikke meetodeid, mida tutvustame hilisemates peatükkides.
Igal juhul, kui valimi suurus on piisav ja normaaljaotus pole meie andmetest liiga kaugel, siis saame kasutada järgmisi heuristikuid:


```
#> # A tibble: 7 x 2
#>   CI_percentage nr_of_SEMs
#>           <dbl>      <dbl>
#> 1          50.0      0.675
#> 2          75.0      1.15 
#> 3          90.0      1.64 
#> 4          95.0      1.96 
#> 5          97.0      2.17 
#> 6          99.0      2.58 
#> # ... with 1 more row
```

SEM on standardviga, mille arvutame jagades valimi standardhälbe ruutjuurega valimi suurusest N. 
Kuna CI sõltub SEM-ist, sõltub see muidugi ka N-st, aga mitte lineaarselt, vaid üle ruutjuure. 
See tähendab, et uuringu usaldusväärsuse tõstmine, tõstes N-i kipub olema progressiivselt kulukas protsess.
Analoogiana võib siin tuua sportliku vormi tõstmine, kus trennis käimisega alustades on suhteliselt lihtne tõsta oma sooritust näiteks 20% võrra, aga peale aastast usinat rassimist tuleb juba teha väga tõsine pingutus, et saavutada veel 1% tõusu.

<img src="06-graphics_files/figure-epub3/unnamed-chunk-73-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-74-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-75-1.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-75-2.svg" width="70%" style="display: block; margin: auto;" />


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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-76-1.svg" width="70%" style="display: block; margin: auto;" />



2. jaga andmestik x-teljel võrdse laiusega vahemikesse (binnidesse)

<img src="06-graphics_files/figure-epub3/unnamed-chunk-77-1.svg" width="70%" style="display: block; margin: auto;" />

3. loe kokku, mitu andmepunkti sattus igasse binni. Näiteks on meil viimases binnis (7.5 ... 8) kuus anmdepunkti
4. ploti iga bin tulpdiagrammina (y- teljel on tüüpiliselt andmepunktide arv)


```r
ggplot(iris, aes(x=Sepal.Length)) + geom_histogram(breaks= seq(4, 8, by=0.5), color="white")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-78-1.svg" width="70%" style="display: block; margin: auto;" />

Tavaliselt on siiski mõistlik määrata histogrammi binnide laius ja asukoht mitte *breaks* argumeniga vaid kas argumendiga *bins*, mis annab binnide arvu, või argumendiga *binwidth*, mis annab binni laiuse. Vt ka geom_boxplot() funktsiooni helpi.

NB! Väga tähtis on mõista, et binnide laius on meie suva järgi määratud. Samade andmete põhjal joonistatud erineva binilaiusega histogrammid võivad anda lugejale väga erinevaid signaale. 


```r
library(gridExtra)
g1 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 3)
g2 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 8)
g3 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 20)
g4 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins = 50)
grid.arrange(g1, g2, g3, g4, nrow = 2)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-79-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-80-1.svg" width="70%" style="display: block; margin: auto;" />

Teine võimalus on näidata kõiki koos ühel paneelil kasutades histogrammi asemel sageduspolügoni. See töötab täpselt nagu histogramm, ainult et tulpade asemel joonistatakse binnitippude vahele jooned. Neid on lihtsam samale paneelile üksteise otsa laduda.


```r
ggplot(iris, aes(Sepal.Length, color=Species)) + geom_freqpoly(breaks= seq(4, 8, by=0.5)) + theme_tufte()+ labs(title="Frequency plot")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-81-1.svg" width="70%" style="display: block; margin: auto;" />

Selle "histogrammi" binne saab ja tuleb manipuleerida täpselt samamoodi nagu geom_histogrammis.

Veel üks hea meetod histogrammide võrdlemiseks on joonistada nn viiuliplot. See asendab sakilise histogrammi silutud joonega ja muudab seega võrdlemise kergemaks. Viiulile on ka kerge lisada algsed andmepunktid


```r
ggplot(iris, aes(Species, Sepal.Length)) + geom_violin(aes(color=Species))+
  geom_jitter(size=0.2, width=0.1) + labs(title="Violin plot", x=NULL)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-82-1.svg" width="70%" style="display: block; margin: auto;" />

## Tihedusplot

Hea alternatiiv histogrammile on joonistada silutud andmejaotus, mis käitub silutud histogrammina. 


```r
ggplot(iris, aes(Sepal.Length, fill=Species)) + geom_density(alpha=0.5)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-83-1.svg" width="70%" style="display: block; margin: auto;" />

Adjust parameeter reguleerib silumise määra.
<img src="06-graphics_files/figure-epub3/unnamed-chunk-84-1.svg" width="70%" style="display: block; margin: auto;" />

Veel üks võimalus jaotusi kõrvuti vaadata on joyplot, mis paneb samale paneelile kasvõi sada tihedusjaotust.


```r
library(ggjoy)
ggplot(iris, aes(x=Sepal.Length, y=Species, fill=Species)) + 
  geom_joy(scale=4, rel_min_height=0.01, alpha=0.9) +
  theme_joy(font_size = 13, grid=TRUE) + 
  theme(legend.position = "none")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-85-1.svg" width="70%" style="display: block; margin: auto;" />


```r
sch <- read.csv("data/schools.csv")
sch$school <- as.factor(sch$school)
ggplot(sch, aes(score1, y=reorder(school, score1))) + 
  geom_joy() + theme_tufte()
#> Warning: Removed 202 rows containing non-finite values
#> (stat_density_ridges).
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-86-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-87-1.svg" width="70%" style="display: block; margin: auto;" />

Boxplotile saab lisada ka aritmeetilise keskmise (järgnevas punase täpina), aga pea meeles, et boxploti põhiline kasu tuleb sellest, et see ei eelda sümmeetrilist andmejaotust. Seega on mediaani lisamine üldiselt parem lahendus.


```r
ggplot(iris, aes(Species, Sepal.Length, color = Species)) + 
  geom_boxplot()+ stat_summary(fun.y=mean,col='red', geom='point', size=2)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-88-1.svg" width="70%" style="display: block; margin: auto;" />

<img src="06-graphics_files/figure-epub3/unnamed-chunk-89-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-90-1.svg" width="70%" style="display: block; margin: auto;" /><img src="06-graphics_files/figure-epub3/unnamed-chunk-90-2.svg" width="70%" style="display: block; margin: auto;" />

Astmeline graafik on eriti hea olukorras, kus astmete vahel y-dimensioonis muutust ei toimu -- näiteks piimapaki hinna dünaamika poes.

Geom_path võimaldab joonel ka tagasisuunas keerata.


```r
# geom_path lets you explore how two variables are related over time,
# e.g. unemployment and personal savings rate
m <- ggplot(economics, aes(unemploy/pop, psavert))
m + geom_path(aes(colour = as.numeric(date)))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-91-1.svg" width="70%" style="display: block; margin: auto;" />


Tulpdiagramm juhib lugeja tähelepanu väikestele teravatele muutustele. Kui see on see, millele sa tahad tähelepanu juhtida, siis kasuta seda.

```r
p1 <- ggplot(economics, aes(date, unemploy)) + geom_line()
p2 <- ggplot(economics, aes(date, unemploy)) + geom_bar(stat="identity")
grid.arrange(p1, p2, nrow = 2)
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-92-1.svg" width="70%" style="display: block; margin: auto;" />

Et mürarikkaid andmeid siluda kasutame liikuva keskmise meetodit. Siin asendame iga andmepunkti selle andmepunkti ja tema k lähima naabri keskmisega. k on tavaliselt paaritu arv ja mida suurem k, seda silutum tuleb tulemus. 


```r
library(zoo)
economics$rollmean <- rollmean(economics$unemploy, k = 13, fill = NA)
ggplot(economics, aes(date, rollmean)) + geom_line()
#> Warning: Removed 12 rows containing missing values
#> (geom_path).
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-93-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-94-1.svg" width="70%" style="display: block; margin: auto;" />

Pane tähele graafiku paremas servas asuvaid halle kaste, mis annavad mõõtkava erinevate paneelide võrdlemiseks. Siit näeme, et "remainder" paneeli andmete kõikumise vahemik on väga palju väiksem kui ülemisel paneelil, kus on plotitud täisandmed.


Nüüd esitame versiooni, kus remainder-i andmeid on tugevasti silutud, et võimalikku signaali mürast eristada.

```r
plot(stl(log(co2), s.window = "per", t.window = 1000))
# t.window -- the span (in lags) of the loess window for trend extraction, which should be odd.
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-95-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-96-1.svg" width="70%" style="display: block; margin: auto;" />

Kui punkte on liiga palju, et välja trükkida, kasuta geom = "polygon" varianti.


```r
m + stat_density_2d(aes(fill = ..level..), geom = "polygon")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-97-1.svg" width="70%" style="display: block; margin: auto;" />


kui meil on eraldi välja arvutatud tihedus (density) igale vaatluspunktile, saame kasutada geom_tile


```r
ggplot(faithfuld) +
  geom_tile(aes(eruptions, waiting, fill = density)) + 
  scale_fill_distiller(palette = "Spectral")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-98-1.svg" width="70%" style="display: block; margin: auto;" />



Nüüd plotime 3 iriseliigi õielehe pikkuse seose tolmuka pikkusega, ja lisame igale liigile mittelineaarse mudelennustuse koos 95% usaldusintervalliga. Mudel püüab ennustada keskmist õielehe pikkust igal tolmuka pikkusel, ja 95% CI kehtib ennustusele keskmisest, mitte üksikute isendite õielehtede pikkustele. 

```r
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) + geom_point() + geom_smooth()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-99-1.svg" width="70%" style="display: block; margin: auto;" />

See mudeldamine tehti loess meetodiga, mis kujutab endast lokaalselt kaalutud polünoomset regressiooni. Loessi põhimõte on, et arvuti fitib palju lokaalseid lineaarseid osamudeleid, mis on kaalutud selles mõttes, et andmepunktidel, mis on vastavale osamudelile lähemal, on mudeli fittimisel suurem kaal. Nendest osamudelitest silutakse siis kokku lõplik mudel, mida joonisel näete.

Järgmiseks värvime eelnevalt tehtud plotil punktid iirise liigi kaupa aga joonistame ikkagi regressioonisirge läbi kõikide punktide. Seekord on tegu tavapärase lineaarse mudeliga, mis fititud vähimruutude meetodiga (vt ptk ....).

Vaata mis juhtub, kui värvide lahutamine toimub `ggplot()`-i enda `aes()`-s. `theme_classic()` muudab graafiku üldist väljanägemist.


```r
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(aes(color = Species)) + 
  geom_smooth(method = "lm", color = "black") +
  theme_classic()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-100-1.svg" width="70%" style="display: block; margin: auto;" />

Me võime `geom_smooth()`-i anda erineva andmeseti kui `ggplot()` põhifunktsiooni. 
Nii joonistame me regressioonisirge ainult nendele andmetele.
Proovi ka `theme_bw()`.

```r
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() +
  geom_smooth(data = filter(iris, Species == "setosa"), method = lm) +
  theme_bw()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-101-1.svg" width="70%" style="display: block; margin: auto;" />

Alljärgnevalt näiteks moodus kuidas öelda, et me soovime regressioonijoont näidata ainult iiriseliikide virginica või versicolor andmetele.


```r
## First we filter only data that we want to use for regressionline
smooth_data <- filter(iris, Species %in% c("virginica", "versicolor"))

## Then we use this filtered dataset in geom_smooth
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() +
  geom_smooth(data = smooth_data, method = "lm")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-102-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-103-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-105-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-107-1.svg" width="70%" style="display: block; margin: auto;" />

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

<img src="06-graphics_files/figure-epub3/unnamed-chunk-109-1.svg" width="70%" style="display: block; margin: auto;" />

Kui me tahame, et cut-i ja clarity kombinatsioonid oleks kastidena ükteise sees, pigem kui üksteise otsa kuhjatud, siis kasutame position = "identity" argumenti. 


```r
ggplot(diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 0.7, position = "identity") 
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-110-1.svg" width="70%" style="display: block; margin: auto;" />

ka see graafik pole väga lihtne lugeda. Parem viime clarity klassid üksteise kõrvale


```r
ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-111-1.svg" width="70%" style="display: block; margin: auto;" />

Eelnev on hea viis kuidas võrrelda clarity tasemete esinemis-sagedusi ühe cut-i taseme piires.

Ja lõpuks, position="fill" normaliseerib tulbad, mis muudab selle, mis toimub iga cut-i sees, hästi võrreldavaks. See on hea viis, kuidas võrrelda clarity tasemete proportsioone erinevate cut-i tasemete vahel. 


```r
ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "fill")
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-112-1.svg" width="70%" style="display: block; margin: auto;" />

Ja lõpetuseks, kui teile miskipärast ei meeldi Cleveland plot ja te tahate plottida tulpdiagrammi nii, et tulba kõrgus vastaks tabeli ühes lahtris olevale numbrile, mitte faktortunnuse esinemiste arvule tabelis, siis kasutage: `geom_bar(stat = "identity")`



```r
df <- tibble(a=c(2.3, 4, 5.2), b=c("A", "B", "C"))
ggplot(df, aes(b, a)) + geom_bar(stat = "identity")
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

Nii saab mugavalt visualiseerida ka väga keeruliste mudelite ennustusi. 

```r
ggplot(pred_matrix, aes(x = Petal.Length)) + 
  geom_point(data= iris, aes(y = Sepal.Length)) +
  geom_line(aes(y = pred))
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-115-1.svg" width="70%" style="display: block; margin: auto;" />

Nüüd lisame irise tabelisse residuaalid mugavusfunktsiooni add_residual() abil (tekib tulp "resid"). Residuaal on lihtsalt andmepunkti Sepal.Length väärtus miinus mudeli ennustus.


```r
iris1 <- iris
iris1 <- add_residuals(iris1, m1)
ggplot(iris1, aes(resid)) + geom_density()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-116-1.svg" width="70%" style="display: block; margin: auto;" />

See plot näitab, et residuaalid on enam vähem 0-i ümber koondunud, aga negatiivseid residuaale paistab veidi enam olevat. 

Tegelik residuaaliplot näeb välja selline:

```r
ggplot(iris1, aes(Petal.Length, resid, color=Species)) + 
  modelr::geom_ref_line(h = 0) +
  geom_point() 
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-117-1.svg" width="70%" style="display: block; margin: auto;" />



See võimaldab otsustada, kas mudel ennustab võrdselt hästi erinevatel predikrori (Petal.Length) väärtustel. Antud mudelis ei näe me süstemaatilisi erinevusi residuaalides üle õielehtede pikkuste vahemiku. 

Proovime sama lihtsa lineaarse mudeliga $Sepal.Length = intercept + b * Petal.Length$.
<img src="06-graphics_files/figure-epub3/unnamed-chunk-118-1.svg" width="70%" style="display: block; margin: auto;" />


<img src="06-graphics_files/figure-epub3/unnamed-chunk-119-1.svg" width="70%" style="display: block; margin: auto;" />

Siit näeme, et I. setosa puhul on residuaalid pigem >0 ja et see mudel töötab paremini I. versicolor ja I. virginica puhul. 

Siin on residuaalid algsetes Sepal Length-i mõõtühikutes (cm). Et otsustada, kas üks või teine residuaal on 0-st piisavalt kaugel, avaldame residuaalid standardhälvete ühikutes (nn Studentized residuals).
Residuaalide muster joonisel sellest ei muutu, muutub vaid y-telje tähistus.

```r
iris1 <- mutate(iris1, st_resid=resid/sd(resid))
ggplot(iris1, aes(Petal.Length, st_resid, color=Species)) + 
  geom_ref_line(h = 0) +
  geom_point()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-120-1.svg" width="70%" style="display: block; margin: auto;" />

Nüüd näeme I. virginica isendit, mille koha pealt mudel ülehindab 3 standardhälbega ja kahte sama liigi isendit (ja ühte I. setosa isendit), mille koha pealt mudel alahindab >2 standardhälbega.

## Tukey summa-erinevuse graafik

Te sooritate korraga palju paralleelseid mõõtmisi -- näiteks mõõdate mass-spektroskoopiaga 1000 valgu taset. Kui teete seda katset kaks korda (või katse vs. kontroll n korda) ja tahate näha süstemaatilisi erinevusi, siis tasub joonistada summa-erinevuse graafik. See on hea olukordades, kus ei ole vahet, mis läheb x ja mis läheb y teljele (erinevalt regressioonimudelitest ja residuaaliplottidest, kus see on väga tähtis).
Meie graafik on x ja y suhtes sümmeetriline. 

Graafik ise on lihtsalt scatterplot, kus horisontaalsele teljele plotitud x + y väärtused ja vertikaalsele teljele plotitud y - x väärtused. Me lisame ka horisontaalsele teljele 0 - joone, et meil oleks lihtsam oma vaimusilmas efekti suuruste punktipilve tsentreerida. 

Näituseks plottime mass spektroskoopia andmed, kus kahel tingimusel (d10 ja wt) on kummagil tehtud kolm iseseisvat katset. Järgneb tabel df_summary2, kus on 2023 valgu tasemete keskväärtused kahel tingimusel, ning Tukey summa-erinevuse graafik




```r
head(df_summary2, 3)
#> # A tibble: 3 x 3
#> # Groups:   gene [3]
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
  labs(title="Tukey sum-difference graph of mass spectroscopy data", y="d10 - wt (log2 skaalas)", x= "d10 + wt (log2 skaalas)")+
  theme_tufte()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-123-1.svg" width="70%" style="display: block; margin: auto;" />

Meil näha on ilusti tsentreeritud keskmised 3st mõõtmisest kahele tingimusele, kus iga punkt vastab ühele valule. x telg annab suhtelised valgukogused log2 skaalas (selles skaalas on originaalandmed) ja y telg annab efekti suuruse (tingimus 1 miinus tingimus 2). Me näeme sellelt pildilt väga kiiresti, 

(1) et mida väiksem on valgu kogus, seda suurema tõenäosusega saame tugeva efekti (mis viitab valimivea rollile, eriti suuremate efektide puhul), 

(2) et efektipilv on kenasti nullile tsentreeritud (see näitab, et andmete esialgne töötlus on olnud korralik), 

(3) et enamus valgud ei anna suuri efekte (bioloog ohkab siinkohal kergendatult) ja 

(4) et positiivse märgiga efektid kipuvad olema suuremad, kui negatiivsed efektid (2.5 ühikuline effektisuurus log2 skaalas tähendab 2**2.5 = 5.7 kordset erinevust katse ja kontrolli vahel).

Tukey summa-erinevuse graafiku vaene sugulane on vulkaaniplot, kus horisontaalsel teljel on y - x (soovitavalt log2 skaalas) ja vertikaalsel teljel on p väärtused, mis arvutatud kahe grupi võrdluses, kusjuures p väärtused on -log10 skaalas.


```r
df_x <- df[2:7]
#arvutame p väärtused
df$p <- apply(df_x, 1, function(x) t.test(x[1:3], x[4:6])$p.value)
#arvutame efekti suurused (katsete keskmine - kontrollide keskmine)
df$ES <- apply(df_x, 1, function(x) mean(x[1:3]) - mean(x[4:6]))

ggplot(df, aes(ES, -log10(p))) + 
  geom_point(alpha=0.2) + 
  geom_hline(yintercept = -log10(0.05), linetype=2) +
  geom_vline(xintercept = c(-1, 1), linetype=2)+
  labs(x="d10 - wt (log2 skaalas)", y= "- log10 of p value", title="volcano plot")+
  theme_tufte()
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-124-1.svg" width="70%" style="display: block; margin: auto;" />

Sellel pildil demarkeerib horisontaalne punktiirjoon p = 0.05 ja vertikaalsed punktiirid 2-kordse efektisuuruse. Inimesed, kes paremini ei tea, kipuvad vulkaaniplotti tõlgendama nii: kui punkt (loe: valk) asub hotisontaalsest joonest kõrgemal ja ei asu kahe vertikaalse joone vahel, siis on tegu "päris" efektiga.  


```r
library(Hmisc)
histbackback(iris[,1:2])
```

<img src="06-graphics_files/figure-epub3/unnamed-chunk-125-1.svg" width="70%" style="display: block; margin: auto;" />

Te teet
