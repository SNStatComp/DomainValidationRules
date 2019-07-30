#  Demo: STS data validation rules
#  Mark van der Loo, Olav ten Bosch, Dick Windmeijer
#  Statistics Netherlands, August 2019
#
# To install the packages used here see:
# https://github.com/data-cleaning/validate
# https://github.com/data-cleaning/validatereport
# https://github.com/SNStatComp/GenericValidationRules


# Load a function to read the transmission file format.
source("STS/stsfun.R")

# Validate package (version >= 0.2.7)
library(validate)
# GenericValidationRules (version >= 0.5.0)
library(GenericValidationRules)

# load the data
sts <- read_sts("STS/data/STSIND_TOVT_Q_2018_0002_V0001.csv")

# load the rules
rls <- validator(.file="STS/rules/sts_rules.yaml")

# confront data with rules
out <- confront(sts$data, rls, ref=list(meta=sts$meta)
                , key = names(sts$data)[1:7])

# study result
summary(out)

# turn result into regular dataset
validation_data <- as.data.frame(out)
View(validation_data)

# Translate results into ESS validation report format.
# validatereport (version >= 0.5.0)
library(validatereport)

export_ess_validation_report(out, rls, file="STS/report/STS_validation_report.json")



