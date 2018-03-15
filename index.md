
--- 
title: "Reprodutseeritav andmeanalüüs kasutades R keelt"
author: "Taavi Päll, Ülo Maiväli"
date: "2018-03-15"
knit: "bookdown::render_book"
documentclass: krantz
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
fontsize: 12pt
monofont: "Source Code Pro"
monofontoptions: "Scale=0.7"
site: bookdown::bookdown_site
description: "Praktilise kursuse 'Reprodutseeritav andmeanalüüs R keeles' materjalid."
github-repo: rstats-tartu/lectures
cover-image: img/cover.png
---


# Haara kannel, Vanemuine! {-}



Kas oled tundnud, et sul tekib andmeid rohkem kui sa neid "käistsi" analüüsida jõuad? 
Sa oled sunnitud analüüsiks valima oma multidimensionaalsetest "suurtest" andmetest ainult pisikese osa. 
See ei pruugi olla iseenesest halb, sest vähendab oluliselt testitavaid hüpoteese ja keskendub ainult kõige selgemini interpreteeritavatele efektidele.
Teisalt, kas sa oled tundnud frustratsiooni algandmete, transformatsioonide, jooniste ja statistikute paigutamisel *workbook*-i.
Kas sa oled tundnud frustratsiooni sellest *workbook*-ist kuu-kaks hiljem aru saamisel.
Kas keegi teine saab aru mis sa oma andmetega teinud oled?

Kui sul tekivad eelmainitud probleemid, oled sa ilmselt valmis järgmiseks elu muutvaks sammuks andmeanalüüsi ja statistika vallas -- skaleerimaks need protsessid ülesse võttes kasutusele skriptid ja muutes oma töövoo reprodutseeritavaks.

Skriptid ja koodid võimaldavad sul hoida lahus algandmed (mis on püha ja puutumatu) andmete töötlusest ja töödeldud andmetest ning genereerida eraldiseisvad andmeanalüüsi produktid -- joonised ja raportid.

Selline reprodutseeritav töövoog on tänapäeval võimalik organiseerida kasutades erinevaid andmeanalüüsi programmeerimiskeeli, eelkõige näiteks *Python* ja R.
*Python*-il ja R-il on loomulikult mitmeid erinevusi ja paralleelseid omadusi, esimene on nö täielik keel, võimaldades luua ka iseseisva graafilise kasutajaliidesega programme.
R on seevastu mõeldud eelkõige andmeanalüüsiks ja selle tulemuste visualiseerimiseks.


Antud raamat keskendub sissejuhatusele **R statistilise programmeerimiskeelde**, mille jaoks on praeguseks hetkeks välja töötatud ka suurepärased kasutajaliidesed, nii et R kasutamine ei eelda 100% tööd käsurealt-konsoolist.
Lisaks R-ile annab antud raamat ka mõned soovitused oma **töövoo reprodutseeritavaks organiseerimiseks**.

Jõudu ja entusiasmi sellel teel!


