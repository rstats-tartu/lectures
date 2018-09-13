

#lisa: funktsioonid
## raamatukogud

`install.packages("ggplot2")` laadib raamatukogu CRAN-ist alla
`library(ggplot2)` muudab raamatukogu funktsioonid kättesaadavaks

### bioconductor

First run biocLite script fron bioconductor.org
`source("https://bioconductor.org/biocLite.R")`  
use 'http' in url if 'https' is unavailable. 
`biocLite("edgeR")`

### Github

https://github.com
following command installs xaringan (presentation ninja) package from GitHub user yihui
`devtools::install_github("yihui/xaringan")`

## failide sisselugemine

+ `readit::readit()`kasutab tidyverse, loeb sisse mida iganes
+ `readr::read_delim(file, delim="")` saad määrata delimiteri 
+ `readr::read_csv2()` loeb sisse Exceli csv-d
+ `readr::read_csv()` loeb sisse csv-d
+ Addins/Gotta Read Em All - interaktiivne 
+ `readr::write_csv()  & base::write.csv()`

## matemaatika

+ `sum(x, na.rm = TRUE)`
+ `sqrt()` võtab ruutjuure
+ `prod()` korrutab
+ `log()` naturaallogaritm alusel e
+ `exp()` anti-logaritm alusele e
+ `log2()`
+ `log10()`
+ `round(x, 2)` ümardab 2le komakohale
+ ^ - astendamine (** töötab ka)
+ \* - korrutamine
+ / - jagamine
+ == - võrdusmärk

## andmeraamid

+ `tibble()` andmeraami sisestamine rea vektoritena
+ `tribble()` andmeraami sisetamine tabelina
+ `str(df)` näitab tabeli struktuuri
+ `nrow()` annab tabeli ridade arvu
+ `ncol()`
+ `class()` annab objekti klassi
+ `as_tibble() & as.data.frame()`
+ `add_row()`
+ `add_column()`
+ `distinct()` eemalda duplikaatread
+ `count()` loeb üles tabeli rea väärtuste aesinemise arvu
+ `add_count()` lisab faktori esinemiste arvu tabelile uue veeruna "n"
+ `table()` annab väärtuste aesinemise arvu igal faktorite taseme kombinatsioonil
+ `summary()` summeerib tabeli
+ `psych::describe()` summeerib tabeli
+ `colnames()`
+ `rownames()`
+ `rownames_to_column()`
+ `remove_rownames()`
+ `rowid_to_column()` adds a column of ascending nrs starting at 1.
+ `arrange(df, desc(column_name))` sordib read
+ `top_n()` annab n suureima/väikseima väärtusega rida 
+ `colSums()`
+ `rowSums()`
+ `rowMeans()`
+ `apply()` 
+ `bind_rows(df1, df2, .id = "id")` (base::rbind)
+ `bind_cols()` (base::cbind)
+ `full_join(df1, df2)`
+ `left_join(df1, df2)` ühendab df2 df1-e ridadega nii, et uusi ridu ei teki.
+ `semi_join(df1, df2)` filter: 2 tabeli ühisosa
+ `anti_join(df1, df2)` filter: 1 tabeli read, mis puuduvad 2. tabelis

## NA-d

+ `VIM::aggr()` näitab puuduvad väärtused
+ `sapply(diabetes, function(x) sum(is.na(x)))` Mitu NA-d on igas tulbas.
+ `VIM::matrixplot(x)` NA-de plot
+ `filter_all(x, any_vars(is.na(.)))` annab read, mis sisaldavad NA-sid
+ `na_if(x, y)` rekodeerib vektoris x väärtused y NA-deks
+ `coalesce(x, 0L)` rekodeerime NA 0-ks

+ ``
+ ``
+ ``
+ ``
+ ``
+ ``
+ ``
+ ``





