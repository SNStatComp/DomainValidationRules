
#' Read an STS transmission file
#' 
#' @param file \code{[character]} scalar. Location of an STS file in SDMX csv format.
#' 
#' 
#' @return A list with two data frames, called \code{meta} and \code{data},
#' where \code{meta} contains data extracted from the file name.
#' 
#' @references 
#' SDMX for Short-Term Business Statistics (STS). 
#' DSD ESTAT+STSALL+2.1 Version 1.0 12/01/2017.
#' (Especially appendix 2)
#'
#'
#' @exoprt
read_sts <- function(file){

  # name string from SDMX for_STS_guidelines.pdf, page 29
  namestr <- 
    "FREQ;REF_AREA;SEASONAL_ADJUST;INDICATOR;ACTIVITY;BASE_PER;TIME_PERIOD;OBS_VALUE;OBS_STATUS;CONF_STATUS;PRE_BREAK_VALUE;EMBARGO_TIME;COMMENT_OBS;COMMENT_DSET;TRANSFORMATION;DECIMALS;UNIT_MULT;UNIT_MEASURE;TIME_FORMAT;COMMENT_TS"
  
  colnames <- strsplit(namestr,";")[[1]]

  colnames <- strsplit(namestr,";")[[1]]
  
  dat <- read.table(file
           , header           = FALSE
           , sep              = ";"
           , col.names        = colnames
           , stringsAsFactors = FALSE)
  
  # get metadata from string
  # remove file extension
  str <- gsub("\\..+$","", basename(file))
  str_parts <- strsplit(str,"_")[[1]]
  meta <- data.frame(
      DOMAIN    = str_parts[1]
    , INDICATOR = str_parts[2] 
    , FREQ      = str_parts[3]
    , PERIOD    = paste(str_parts[4],as.integer(str_parts[5]))
    , VERSION   = str_parts[6]
    )
    
  list(data=dat, meta=meta)
}





