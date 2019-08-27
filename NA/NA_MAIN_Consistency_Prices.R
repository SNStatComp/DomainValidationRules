# Implementation in R-validate of the chain linked formula as described in NA VTL file:
# NA_MAIN_VCO_4_2_3_Consistency_between Prices.txt
# 20190506, Statistics Netherlands

library('validate')
library('dplyr')

# Generic function for selecting data:
selectSet <- function(data, selections, join_cols, value_col, value_names, periods) {
  data['rowid'] <- row(data)[,1]
  res <- data.frame()
  for (i in 1:length(selections)) {
    selcols <- c(join_cols, value_col, 'rowid', periods[i])
    newdata <- subset(data,eval(selections[[i]]),selcols)
    names(newdata)[match(periods[i],names(newdata))] <- 'JOIN_PERIOD'
    if (is.null(periods[i])) {
      join <- join_cols
    } else {
      join <- c(join_cols, 'JOIN_PERIOD')
    }
    res <- merge(res, newdata, by=join)
    names(res)[match(value_col,names(res))] <- value_names[i]
    names(res)[match('rowid',names(res))] <- paste('rowid',value_names[i],sep='_')
  }
  return(res)
}

# Read data:
nr <- read.csv('./data/20180416_NAMAIN_T0101_A_NL_2016_0000_4D_V0003.csv',sep=";")

# Add T minus 1 column:
nr$PERIOD_T = group_indices(nr, TIME_PERIOD)
nr$PERIOD_TMIN1 = nr$PERIOD_T + 1

# Define columns:
join_cols = c('ADJUSTMENT','ACCOUNTING_ENTRY','ACTIVITY','STO','TRANSFORMATION')
time_periods = c('PERIOD_T','PERIOD_T','PERIOD_TMIN1','PERIOD_TMIN1')

# Define filters:
cond_a <- quote((FREQ=='A') &
                  (REF_AREA=='NL') &
                  (COUNTERPART_AREA=='W2') &
                  (REF_SECTOR=='S1') &
                  (COUNTERPART_SECTOR=='S1') &
                  (INSTR_ASSET=='_Z') &
                  (EXPENDITURE=='_Z') &
                  (UNIT_MEASURE=='XDC') &
                  (PRICES=='Y'))

cond_b <- quote((FREQ=='A') &
                  (REF_AREA=='NL') &
                  (COUNTERPART_AREA=='W2') &
                  (REF_SECTOR=='S1') &
                  (COUNTERPART_SECTOR=='S1') &
                  (INSTR_ASSET=='_Z') &
                  (EXPENDITURE=='_Z') &
                  (UNIT_MEASURE=='XDC') &
                  (PRICES=='L'))

cond_c <- quote((FREQ=='A') &
                  (REF_AREA=='NL') &
                  (COUNTERPART_AREA=='W2') &
                  (REF_SECTOR=='S1') &
                  (COUNTERPART_SECTOR=='S1') &
                  (INSTR_ASSET=='_Z') &
                  (EXPENDITURE=='_Z') &
                  (UNIT_MEASURE=='XDC') &
                  (PRICES=='L'))

cond_d <- quote((FREQ=='A') &
                  (REF_AREA=='NL') &
                  (COUNTERPART_AREA=='W2') &
                  (REF_SECTOR=='S1') &
                  (COUNTERPART_SECTOR=='S1') &
                  (INSTR_ASSET=='_Z') &
                  (EXPENDITURE=='_Z') &
                  (UNIT_MEASURE=='XDC') &
                  (PRICES=='V'))

# Select filtered data:
res <- selectSet(nr, c(cond_a,cond_b,cond_c,cond_d), join_cols, 'OBS_VALUE', c('A','B','C','D'), time_periods)

# Define validator:
v <- validator(A-((B/C)*D)<1)

# Validate:
cf1 <- confront(res, v)

# Show summary:
summary(cf1)
