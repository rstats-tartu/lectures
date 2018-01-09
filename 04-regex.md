

# Regular expression ja find & replace {#regex}

Regular expression annab võimaluse lühidalt kirjeldada mitte-üheseid otsinguparameetreid.

> regular expression on string, mis kirjeldab mitut stringi


A [regular expression](https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html)  [Regular Expressions as used in R](https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html)


string on märkide järjestus, mis on jutumärkide vahel ("" või ''). 
Osad märgid ei ole R stringis otse representeeritavad. 
Neid representeerivad nn special characters ehk erimärgid.
Iga kord kui te regular expressionis näete \ peate seda stringis, mis representeerib seda rexexp-i, kirjutama kui \\.

`writeLines()` näitab kuidas R näeb su stringi peale seda, kui erimärgid on välja loetud (parsitud).  


```r
writeLines("\\.") # \.
writeLines("\\ is a backslash") # \ is a backslash
```


Enamus märke (k.a. tähed ja numbrid) tähistavad ainult iseennast. 

+ `.` tähistab igat märki.

Märgiklass on märkide nimekiri nurksulgude vahel, nagu näiteks `[[:alnum:]]`, mis on sama kui `[A-z0-9]`. Enamasti tuleb need stringi kirjutada topelt nurksulgudes: [[:siia_märgiklass:]]. Aga näiteks [0-9] on üksik nurksulgudes.  

+ tavalised märgiklassid:
- `[:alnum:]` numbrid ja tähed: AacF123 
- `[:digit:]` numbrid: 123
- `[:alpha:]` tähed: asdf
- `[:upper:]` suured tähed: ASDF
- `[:lower:]` väiksed tähed: asdf
- `[:punct:]` ! " # $ % & ' ( ) * + , - / : ; < = > ? @ [ \ ] ^ _ ` ` { | } ~. 
- `[:space:]` space, tab ja newline.
- `[:blank:]` tab ja newline.

Metamärgid on `. \ | ( ) [ { ^ $ * + ?`. Nende tähendus sõltub kontekstist. `\\` teeb metamärgist tavalise märgi.


```r

trüki see   regex
\\n         \n   new line (return)
\\t         \t   tab
\\s         \s   any whitespace (\S - any non-whitespace)
\\d         \d   any digit (\D - any non-digit) 
\\w         \w   any word character (\W - non-word char)
\\b         \b   word boundaries

Selleks, et trükkida erimärk tavalise märgina:
  
trüki  selleks  
\\.    .
\\!    !
\\?    ?        
\\\\   \
\\(    (
\\{    {

```



+ Repetition quantifiers put after regex specify how many times regex is matched: `?`, zero or one; `*`, zero or more times; `+`, one or more times; `{n}`, n times; `{n,}`, n or more times; `{n,m}`, n to m times. 
+ ^ anchors the regular expression to the start of the string.
+ $ anchors the the regular expression to end of the string.

+ ab|d tähendab ab või d
+ [abe] tähendab ühte kolmest (kas a või b või e)
+ [^abe] tähendab kõike, mis ei ole a või b või e
+ [a-c] tähendab a või b või c

Sulud annavad eelistuse

+ (ab|d)e tähendab abe või de

Leia string, millele järgneb või eelneb mingi string

+ a(?=c) annab need a-d, millele järgneb c
+ a(?!c) annab need a-d, millele ei järgne c
+ (?<=b)a annab need a-d, millele eelneb b
+ (?<!b)a annab need a-d, millele ei eelne b

**patterns that match more than one character:**



```r

. (dot): any character apart from a newline.

\\d: any digit.

\\s: any whitespace (space, tab, newline).

\[abc]: match a, b, or c.

\[!abc]: match anything except a, b, or c.

To create a regular expression containing \d or \s, you???ll need to escape the \ for the string, so you will type "\\\\d" or "\\\\s".

abc|d..f will match either "abc", or "deaf". 
```



Et mitte interpreteerida stringi tavalise regex-ina:
`regex(pattern, ignore_case = FALSE, multiline = FALSE, comments = FALSE, dotall = FALSE, ...)` ignore cases, match end of lines and end of strings, allow R comments within regex's , and/or to have `.` match everything including `\n`. 
Näiteks `str_detect("I", regex("i", TRUE))`


## Common operations with regular expressions

+ Locate a pattern match (positions)
- str_detect() annab TRUE/FALSE
- str_which() annab stringide, mis sisaldavad otsingumustrit, indeksinumbrid
- str_count() annab esinemiste arvu stringis
- str_locate_all() annab otsingumustri positsiooninumbri (indeksi) stringis

+ Extract a matched pattern
- str_sub() võtab välja otsitud alamstringi; otsing indeksinumbrite järgi
- str_subset() võtab välja terve stringi; regex otsing
- str_extract_all() võtab välja mustri (alamstringi); regex otsing 
- str_match_all() annab maatriksi, millel on veerg igale grupile regeximustris

+ Replace a matched pattern
- str_replace_all()
- str_to_lower()
- str_to_upper()
- str_to_title()

+ stringi pikkus
- str_length() annab märkide arvu stringis
- str_trim() võtab maha whitespace stringi algusest/lõpust

+ ühenda ja eralda stringe
- str_c() ühendab, k.a. kollapseerib mitu stringi üheks (arg collapse=)
- str_dup() kordab stringi n korda
- str_split_fixed() jagab stringi alamstringide maatriksiks
- glue::glue_data() teeb stringi df-st, listist v environmentist

+ järjesta stringe
- str_sort() annab sorditud character vectori

## Find and replace


```r
library(stringr)
x<- c("apple", "ananas", "banana")

#replaces all a-s at the beginning of strings with e-s
str_replace(x, "^a", "e") 
#> [1] "epple"  "enanas" "banana"

# str_replace only replaces at the first occurence at each string
str_replace(x, "a", "e") 
#> [1] "epple"  "enanas" "benana"

#str_replace_all replaces all a-s anywhere in the strings
str_replace_all(x, "a", "e") 
#> [1] "epple"  "enenes" "benene"

#replaces a and the following character at the end of string with nothing (i.e. deletes 2 chars)
str_replace(x, "a.$", "")
#> [1] "apple"  "anan"   "banana"

#replaces a-s or s-s at the end of string with e-s
str_replace(x, "(a|s)$", "e")
#> [1] "apple"  "ananae" "banane"

#replaces a-s or s-s anywhere in the string with e-s
str_replace_all(x, "a|s", "e")
#> [1] "epple"  "enenee" "benene"

#remove all numbers. 
y<-c("as1", "2we3w", "3e")
str_replace_all(y, "\\d", "") 
#> [1] "as"  "wew" "e"

#remove everything, except numbers. 
str_replace_all(y, "[A-Za-z_]", "") 
#> [1] "1"  "23" "3"
```




```r
x<- c("apple", "apple pie")
str_replace_all(x, "^apple$","m") #To force to only match a complete string:
#> [1] "m"         "apple pie"
str_replace_all(x, "\\s","_") #space to _
#> [1] "apple"     "apple_pie"
str_replace_all(x, "[apl]","_") #a or p or l to _
#> [1] "____e"     "____e _ie"
str_replace_all(x, "[ap|p.e]","_") # ap or p.e to _
#> [1] "___l_"     "___l_ _i_"
```

näide: meil on vector v, milles täht tähistab katse tüüpi, number, mis on tähe ees, tähistab mõõtmisobjekti identiteeti ja tähe järel asuv number tähistab ajapunkti tundides (h). F ja f tähistavad sama asja. Kõigepealt võtame välja F-i mõõtmisojbekti ehk subjekti koodid

```r
library(stringr)
v <- c("1F1", "12F2h", "13f1", "2S")


v_f <- str_subset(v, "[Ff]") 
#filtreerime F ja f sisaldavad stringid
v_f
#> [1] "1F1"   "12F2h" "13f1"
v_f_subject <- str_replace_all(v_f, "[Ff][0-9]+h?", "") 
#string "F või f, number üks või enam korda, h 0 või enam korda" asendada tühja stringiga
v_f_subject
#> [1] "1"  "12" "13"
```

Ja nääd võtame välja ajapunktide koodid. Kõigepealt asendame stringid, mis sisaldavad vähemalt üht numbrit, millele järgneb F v f tühja stringiga. Seejärel asendame tühja stringiga h-d. Ja lõpuks avaldame iga ajapunkti numbrina (mitte enam stringina).


```r
library(tidyverse)
str_replace_all(v_f, "[0-9]+[Ff]", "") %>% str_replace_all("h", "") %>% as.integer
#> [1] 1 2 1
```

