
## Install gmailr package
# install.packages("gmailr")

## Load library and use secret file
library(gmailr)
library(dplyr)
library(purrr)

use_secret_file("~/.tapa741-gmailr.json")

## Send test email
# test_email <- mime(
#   To = "taavi.pall@ttu.ee",
#   From = "tapa741@gmail.com",
#   Subject = "this is just a gmailr test",
#   body = "Can you hear me now?")
# send_message(test_email)

mungecontacts <- FALSE
if(mungecontacts){
## 2017 course contacts
contacts <- read.csv("data/contacts_2017.csv")

fix_name <- function(name, email){
  
  # Check if name is present
  hasname <- stringi::stri_length(name)>0
  
  ## If name's missing extract from email address
  if(!hasname) {
    emailid <- stringr::str_extract(email, "^.*(?=@)")
    name <- stringr::str_replace_all(emailid, "\\.", " ")
  }
  
  ## Remove leading and training whitespace
  name <- stringi::stri_trim_both(name)
  
  ## Convert name to titlecase
  stringi::stri_trans_totitle(name)
}

contacts <- mutate(contacts, name = map2(name, address, fix_name))
saveRDS(contacts, file = "data/contacts17_fixed.rds")
}

contacts <- readRDS("data/contacts17_fixed.rds")

body <- "Hi, %s.

<p><em>Reproducible data analysis using R</em> course will start next week, 19. September 2017.</p>   

<p>In order to efficently participate in the course, we need that you have working 
installations of the <b>R, RStudio, Stan and Git</b> in your computer.</p>    

<p>Below are links to the required software, please download and install proper version for your OS:   

<ol type=1>
<li>R can be obtained from https://cran.r-project.org</li>
<li>RStudio can be obtained from https://www.rstudio.com/products/rstudio/download/.</li>
<li>Git can be obtained from https://git-scm.com/downloads.</li>
<li>To install R interface to Stan, please follow steps described in 
https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started.</li>
</ol>
</p> 


<p>It is also advisable that you create your personal Github account (https://github.com) 
if you already don't have one. However, we go through the steps creating and 
testing Github account in the first session.</p>

<p>Course related topics and issues can be discussed on the course github page: 
https://github.com/rstats-tartu/discussion</p>

<p>First session will take place in the main auditorium (ground floor) in Nooruse 1, Tartu.</p>

<p>Course organisers,</p>
<p>Taavi Päll and Ülo Maiväli</p>

<p><small>You received this message because you have signed to 'Reproducible data 
analysis using R' 2017 course at University of Tartu.</small></p>
"

email_sender <- 'Taavi Päll <tapa741@gmail.com>' # your Gmail address
edat <- as_data_frame(contacts) %>%
  mutate(
    To = sprintf('%s <%s>', name, address),
    From = email_sender,
    Subject = "Required software installations for Reproducible data analysis using R",
    body = sprintf(body, name))
edat <- select(edat, To, From, Subject, body)
# me <- filter(edat, To == 'Taavi Päll <taavi.pall@ttu.ee>')

compose_mime <- function(To, From, Subject, body){
  mime() %>%
    from(From) %>%
    to(To) %>%
    subject(Subject) %>% 
    html_body(body)
}

emails <- pmap(edat, compose_mime)

safe_send_message <- safely(send_message)
sent_mail <- map(emails, safe_send_message)

saveRDS(sent_mail,
        paste(gsub("\\s+", "_", "required_software"), "sent-emails.rds", sep = "_"))
errors <- sent_mail %>% 
  transpose() %>% 
  .$error %>% 
  map_lgl(Negate(is.null))
sent_mail[errors]
contacts[errors,]
