

# R on kalkulaator {#calc}

Liidame `2 + 2`. 

```r
2 + 2
#> [1] 4
```

Nüüd trükiti see vastus konsooli kujul `[1] 4`.
See tähendab, et `2 + 2 = 4`.

Kontrollime seda:

```r
## liidame 2 ja 2 ning vaatame kas vastus võrdub 4
answer <- (2 + 2) == 4
## Trükime vastuse välja
answer
#> [1] TRUE
```

Vastus on TRUE, (logical). 

Pane tähele, et aritmeetiline võrdusmärk on `==` (sest = tähendab hoopis väärtuse määramist objektile/argumendile).

Veel mõned näidisarvutused:

```r
## 3 astmes 2; Please read Note ?'**' 
3 ^ 2 # 3**2 also works
## Ruutjuur 3st
sqrt(3)
## Naturaallogaritm sajast
log(100)
```

Arvule $\pi$ on määratud oma objekt `pi`. 
Seega on soovitav enda poolt loodavatele objektidele mitte panna nimeks "pi".

```r
## Ümarda pi neljale komakohale
round(pi, 4)
#> [1] 3.14
```
Ümardamine on oluline tulemuste väljaprintimisel.

